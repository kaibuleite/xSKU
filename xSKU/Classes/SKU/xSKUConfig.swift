//
//  xSKUConfig.swift
//  xSDK
//
//  Created by Mac on 2020/9/19.
//

import UIKit
import xExtension

// MARK: - Struct
/// 颜色数据结构
public struct xSKUItemColor {
    /// 普通
    public var normal = UIColor.systemBlue
    /// 选中
    public var choose = UIColor.systemRed
    
    /// 实例化对象
    public init(normal: UIColor = .clear,
                choose: UIColor = .clear)
    {
        self.normal = normal
        self.choose = choose
    }
    /// 实例化指定对象
    public static func xNew(_ color : UIColor) -> xSKUItemColor
    {
        let color = xSKUItemColor.init(normal: color,
                                       choose: color)
        return color
    }
    /// 实例化透明对象
    public static func xNewClear() -> xSKUItemColor
    {
        let color = xSKUItemColor.xNew(.clear)
        return color
    }
    /// 实例化随机对象
    public static func xNewRandom(alpha: CGFloat = 1) -> xSKUItemColor
    {
        let color = xSKUItemColor.init(normal: .xNewRandom(alpha: alpha),
                                       choose: .xNewRandom(alpha: alpha))
        return color
    }
}

/// 边框数据结构
public struct xSKUItemBorder {
    /// 边框颜色
    public var color = xSKUItemColor.xNewClear()
    /// 线宽
    public var width = CGFloat.zero
    /// 圆角
    public var cornerRadius = CGFloat.zero
    
    /// 实例化对象
    public init(color: xSKUItemColor = .xNewClear(),
                width: CGFloat = .zero,
                cornerRadius: CGFloat = .zero) {
        self.color = color
        self.width = width
        self.cornerRadius = cornerRadius
    }
}

/// 字体数据结构
public struct xSKUItemFont {
    /// 普通
    public var normal = UIFont.systemFont(ofSize: 15)
    /// 选中
    public var choose = UIFont.systemFont(ofSize: 15)
    
    /// 实例化对象
    public init(normal: UIFont = .systemFont(ofSize: 15),
                choose: UIFont = .systemFont(ofSize: 15))
    {
        self.normal = normal
        self.choose = choose
    }
    public static func xNew(fontSize : CGFloat) -> xSKUItemFont
    {
        let font = xSKUItemFont.init(normal: .systemFont(ofSize: fontSize),
                                     choose: .systemFont(ofSize: fontSize))
        return font
    }
    
}

public class xSKUConfig: NSObject {
    
    // MARK: - Public Property
    /// 是否支持多选
    public var isMultiEnable = false
    /// 多选数量
    public var multipleCount = 0
    /// 字体
    public var font = xSKUItemFont.init(normal: .systemFont(ofSize: 14),
                                        choose: .boldSystemFont(ofSize: 15))
    /// 行数
    public var titleLines = 1
    
    /// 行间距
    public var rowSpacing = CGFloat(0)
    /// item指定高度(默认44)
    public var itemHeight = CGFloat(44)
    /// item指定宽度(默认0)
    public var itemWidth = CGFloat(0)
    /// item边距(默认8，自适应计算宽度后留空)
    public var itemMargin = UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 8)
    
    /// 等宽分列（0表示自适应宽度）
    public var column = 0
    /// 列间距
    public var columnSpacing = CGFloat(0)
    
    /// 标题颜色
    public var titleColor = xSKUItemColor(normal: .lightGray,
                                          choose: .darkText)
    /// 背景颜色
    public var backgroundColor = xSKUItemColor.xNewClear()
    
    /// 边框样式
    public var border = xSKUItemBorder()
    
    // MARK: - 更新配置
    /// 更新基本配置
    /// - Parameters:
    ///   - column: 指定列数（0表示自适应宽度）
    ///   - titleLines: 标题行数(默认1行)
    public func updateBasic(column : Int = 0,
                            titleLines : Int = 1)
    {
        self.column = column
        self.titleLines = titleLines
    }
    /// 更新多选配置
    /// - Parameters:
    ///   - enable: 是否可以多选
    ///   - count: 多选数量 (0表示无限制数量)
    public func updateMultiple(enable : Bool,
                               count : Int = 0)
    {
        self.isMultiEnable = enable
        self.multipleCount = count
    }
    /// 更新字体配置
    /// - Parameters:
    ///   - normal: 普通字体
    ///   - choose: 选中字体
    public func updateFont(normal : UIFont,
                           choose : UIFont)
    {
        self.font.normal = normal
        self.font.choose = choose
    }
    /// 更新间距配置
    /// - Parameters:
    ///   - column: 列间距
    ///   - row: 行间距
    public func updateSpacing(column: CGFloat,
                              row: CGFloat)
    {
        self.columnSpacing = column
        self.rowSpacing = row
    }
    /// 更新Item配置
    /// - Parameters:
    ///   - height: 高度
    ///   - width: 宽度(默认0，自适应计算)
    ///   - margin: 边距(默认8，自适应计算宽度后留空)
    public func updateItem(height : CGFloat,
                           width : CGFloat = 0,
                           margin : UIEdgeInsets = .init(top: 0, left: 8, bottom: 0, right: 8))
    {
        self.itemHeight = height
        self.itemWidth = width
        self.itemMargin = margin
    }
    /// 更新颜色配置
    /// - Parameters:
    ///   - title: 标题颜色
    ///   - background: 背景颜色
    public func updateColor(title : xSKUItemColor,
                            background : xSKUItemColor)
    {
        self.titleColor = title
        self.backgroundColor = background
    }
    /// 更新边框配置
    /// - Parameters:
    ///   - color: 边框颜色
    ///   - width: 边框线条宽度
    ///   - radius: 圆角半径
    public func updateBorder(color : xSKUItemColor,
                             width : CGFloat,
                             radius : CGFloat)
    {
        self.border.color = color
        self.border.width = width
        self.border.cornerRadius = radius
    }
    
}
