//
//  xSKUView+Kit.swift
//  xSKU
//
//  Created by Mac on 2023/3/15.
//

import Foundation
import xExtension

extension xSKUView {
    
    // MARK: - 内容样式
    /// 设置普通样式
    public func updateAllItemStyleToNormal()
    {
        let count = self.itemArray.count
        for i in 0 ..< count {
            self.updateItemStyleToNormal(at: i)
        }
    }
    /// 设置普通样式
    public func updateItemStyleToNormal(at idx : Int)
    {
        guard let item = self.itemArray.xObject(at: idx) else { return }
        let cfg = self.config
        item.backgroundColor = cfg.backgroundColor.normal
        item.layer.borderColor = cfg.border.color.normal.cgColor
        if let obj = item as? UIButton {
            obj.titleLabel?.font = cfg.font.normal
            obj.setTitleColor(cfg.titleColor.normal, for: .normal)
        } else
        if let obj = item as? UILabel {
            obj.font = cfg.font.normal
            obj.textColor = cfg.titleColor.normal
        } else
        if let obj = item as? xSKUItem {
            obj.updateNormalStyle(cfg)
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
            obj.titleLabel?.font = cfg.font.choose
            obj.setTitleColor(cfg.titleColor.choose, for: .normal)
        } else
        if let obj = item as? UILabel {
            obj.font = cfg.font.choose
            obj.textColor = cfg.titleColor.choose
        } else
        if let obj = item as? xSKUItem {
            obj.updateChooseStyle(cfg)
        }
        self.currentChooseIdx = idx
        self.chooseItemArray[idx] = item
        self.chooseFlagArray[idx] = true
    }
    
}
