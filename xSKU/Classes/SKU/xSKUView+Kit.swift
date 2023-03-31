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
        if let obj = item as? UIButton {
            obj.setTitleColor(cfg.titleColor.normal, for: .normal)
        } else
        if let obj = item as? UILabel {
            obj.textColor = cfg.titleColor.normal
        } else
        if let obj = item as? xSKUItem {
            obj.updateNormalStyle()
        }
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
        if let obj = item as? UIButton {
            obj.setTitleColor(cfg.titleColor.choose, for: .normal)
        } else
        if let obj = item as? UILabel {
            obj.textColor = cfg.titleColor.choose
        } else
        if let obj = item as? xSKUItem {
            obj.updateChooseStyle()
        }
        self.currentChooseIdx = idx
        self.chooseItemArray[idx] = item
        self.chooseFlagArray[idx] = true
    }
    
}
