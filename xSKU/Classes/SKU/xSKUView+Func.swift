//
//  xSKUView+Func.swift
//  xSKU
//
//  Created by Mac on 2023/3/16.
//

import Foundation
import xExtension

extension xSKUView {
    
    // MARK: - 添加回调
    public func addChooseItem(handler : @escaping xSKUView.xHandlerChooseItem)
    {
        self.chooseHandler = handler
    }
    public func addReloadCompleted(handler : @escaping xSKUView.xHandlerReloadCompleted)
    {
        self.reloadHandler = handler
    }
    
    // MARK: - 选中
    /// 选中
    public func choose(idx : Int)
    {
        if self.config.isMultiEnable {
            // 多选模式
            if self.checkItemIsChoose(at: idx) {
                self.updateItemStyleToNormal(at: idx)
            } else {
                self.updateItemStyleToChoose(at: idx)
            }
            // 已选选项数量
            let curChooseIdxArr = self.getChooseItemIndexArray()
            let curChooseCount = curChooseIdxArr.count
            // 最多选择数量
            var maxChooseCount = self.config.multipleCount
            if maxChooseCount > self.itemArray.count {
                maxChooseCount = self.itemArray.count
            }
            if curChooseCount > maxChooseCount, maxChooseCount > 0 {
                let firstIdx = curChooseIdxArr.first ?? 0
                let lastIdx = curChooseIdxArr.last ?? 0
                let curChooseIdx = self.currentChooseIdx
                if curChooseIdx > firstIdx {
                    self.updateItemStyleToNormal(at: firstIdx)
                } else {
                    self.updateItemStyleToNormal(at: lastIdx)
                }
            }
        } else {
            // 单选模式
            if idx != self.currentChooseIdx {
                self.updateItemStyleToNormal(at: self.currentChooseIdx)
            }
            self.updateItemStyleToChoose(at: idx)
        }
        self.chooseHandler?(idx)
    }
    
    // MARK: - 获取选中的item
    /// 获取选中的item名称
    public func getChooseItemNameArray() -> [String]
    {
        var list = [String]()
        for obj in self.chooseItemArray {
            guard let item = obj else { continue }
            if let obj = item as? UIButton {
                list.append(obj.currentTitle ?? "")
            } else
            if let obj = item as? UILabel {
                list.append(obj.text ?? "")
            } else
            if let obj = item as? xSKUItem {
                list.append(obj.titleLbl?.text ?? "")
            }
        }
        return list
    }
    /// 获取选中的item编号
    public func getChooseItemIndexArray() -> [Int]
    {
        var list = [Int]()
        for obj in self.chooseItemArray {
            guard let item = obj else { continue }
            list.append(item.tag)
        }
        return list
    }
    
    // MARK: - 判断Item是否选中
    /// 判断Item是否选中
    public func checkItemIsChoose(at idx : Int) -> Bool
    {
        let flag = self.chooseFlagArray.xObject(at: idx)
        return flag ?? false
    }
    
}
