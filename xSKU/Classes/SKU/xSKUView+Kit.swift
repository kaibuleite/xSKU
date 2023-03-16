//
//  xSKUView+Kit.swift
//  xSKU
//
//  Created by Mac on 2023/3/15.
//

import Foundation
import xExtension

extension xSKUView {
    
    /// 设置普通样式
    public func updateItemStyleToNormal(at idx : Int)
    {
        guard let item = self.itemArray.xObject(at: idx) else { return }
        let cfg = self.config
        item.backgroundColor = cfg.backgroundColor.normal
        item.layer.borderColor = cfg.border.color.normal.cgColor
        item.setTitleColor(cfg.titleColor.normal, for: .normal)
        
        self.chooseItemArray[idx] = nil
        self.chooseFlagArray[idx] = false
    }
    /// 设置选中样式
    public func updateItemStyleToChoose(at idx : Int)
    {
        guard let item = self.itemArray.xObject(at: idx) else { return }
        let cfg = self.config
        item.backgroundColor = cfg.backgroundColor.choose
        item.layer.borderColor = cfg.border.color.choose.cgColor
        item.setTitleColor(cfg.titleColor.choose, for: .normal)
        
        self.chooseItemArray[idx] = item
        self.chooseFlagArray[idx] = true
        self.currentChooseIdx = idx
    }
    
}
