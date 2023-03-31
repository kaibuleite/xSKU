//
//  xSKUItem.swift
//  xSKU
//
//  Created by Mac on 2023/3/31.
//

import UIKit

open class xSKUItem: UIView {
    
    // MARK: - Public Property
    public var title = ""
    
    // MARK: - Override Func
    open override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - 设置样式
    /// 默认
    open func updateNormalStyle()
    {
        print("默认样式")
    }
    /// 选中
    open func updateChooseStyle()
    {
        print("选中样式")
    }
    
}
