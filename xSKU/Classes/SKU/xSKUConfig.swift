//
//  xSKUConfig.swift
//  xSDK
//
//  Created by Mac on 2020/9/19.
//

import UIKit

public class xSKUConfig: NSObject {
    
    // MARK: - Struct
    /// 颜色数据结构
    public struct xSKUItemColor {
        /// 普通
        public var normal = UIColor.black
        /// 选中
        public var choose = UIColor.red
    }
    /// 边框数据结构
    public struct xSKUItemBorder {
        /// 边框颜色
        public var color = xSKUItemColor.init(normal: .clear, choose: .clear)
        /// 线宽
        public var width = CGFloat.zero
        /// 圆角
        public var cornerRadius = CGFloat(0)
    }
    
    
    // MARK: - Public Property
    /// 是否支持多选
    public var isMultiEnable = false
    /// 字号(默认15.0)
    public var fontSize = CGFloat(15)
    /// 标题颜色
    public var titleColor = xSKUItemColor(normal: .lightGray, choose: .darkText)
    /// 背景颜色
    public var backgroundColor = xSKUItemColor(normal: .clear, choose: .clear)
    /// 边框样式
    public var border = xSKUItemBorder()
    /// 等宽分列（0表示自适应宽度）
    public var column = 0
    /// 列间距
    public var columnSpacing = CGFloat(0)
    /// 行间距
    public var rowSpacing = CGFloat(0)
    /// item指定高度(默认44)
    public var itemHeight = CGFloat(44)
    /// item边距(默认8，自适应计算宽度后留空)
    public var itemMarginEdgeInsets = UIEdgeInsets.init(top: 0, left: 8, bottom: 0, right: 8)
    
    // MARK: - 更新配置
    /// 更新基本配置
    /// - Parameters:
    ///   - column: 指定列数（0表示自适应宽度）
    ///   - fontSize: 字体大小
    ///   - multipleChoice: 是否可以多选
    public func updateBasic(column : Int = 0,
                            fontSize : CGFloat,
                            multipleChoice : Bool = false)
    {
        self.column = column
        self.fontSize = fontSize
        self.isMultiEnable = multipleChoice
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
    
}
