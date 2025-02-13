//
//  xSKUItem.swift
//  xSKU
//
//  Created by Mac on 2023/3/31.
//

import UIKit
import xExtension

open class xSKUItem: UIView {
    
    // MARK: - Public Property
    @IBOutlet public weak var titleLbl: UILabel?
    
    // MARK: - Override Func
    public class func xDefaultViewController() -> Self {
        let vc = Self.loadXib()
        return vc
    }
    public class func loadXib() -> Self {
        let bundle = Bundle.init(for: self.classForCoder())
        let name = self.xClassInfoStruct.name
        let arr = bundle.loadNibNamed(name, owner: nil, options: nil)!
        let view = arr.first!
        return view as! Self
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    // MARK: - 设置样式
    /// 默认
    open func updateNormalStyle(_ config : xSKUConfig)
    {
        self.titleLbl?.textColor = config.titleColor.normal
        self.titleLbl?.font = config.font.normal
    }
    /// 选中
    open func updateChooseStyle(_ config : xSKUConfig)
    {
        self.titleLbl?.textColor = config.titleColor.choose
        self.titleLbl?.font = config.font.choose
    }
    
}
