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
    
}
