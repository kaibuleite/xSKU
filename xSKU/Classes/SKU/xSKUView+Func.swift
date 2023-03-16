//
//  xSKUView+Func.swift
//  xSKU
//
//  Created by Mac on 2023/3/16.
//

import Foundation

extension xSKUView {
    
    // MARK: - 选中
    /// 选中
    public func choose(idx : Int)
    {
        if self.config.isMultiEnable {
            // 多选模式
            if self.chooseItemArray[idx] != nil {
                self.updateItemStyleToNormal(at: idx)
            } else {
                self.updateItemStyleToChoose(at: idx)
            }
        } else {
            // 单选模式
            if idx != self.currentChooseIdx {
                self.updateItemStyleToNormal(at: self.currentChooseIdx)
            }
            self.updateItemStyleToChoose(at: idx)
        }
        self.currentChooseIdx = idx
        self.chooseHandler?(idx)
    }
    
    // MARK: - 获取选中的item
    /// 获取选中的item名称
    public func getChooseItemNameArray() -> [String]
    {
        var list = [String]()
        for obj in chooseItemArray {
            guard let item = obj else { continue }
            list.append(item.currentTitle ?? "")
        }
        return list
    }
    /// 获取选中的item编号
    public func getChooseItemIndexArray() -> [Int]
    {
        var list = [Int]()
        for obj in chooseItemArray {
            guard let item = obj else { continue }
            list.append(item.tag)
        }
        return list
    }
    
}