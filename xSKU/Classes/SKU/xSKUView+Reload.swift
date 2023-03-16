//
//  xSKUView+Reload.swift
//  xSKU
//
//  Created by Mac on 2023/3/15.
//

import Foundation
import xExtension

extension xSKUView {
    
    // MARK: - 数据加载
    // TODO: 数据加载
    /// 加载组件数据
    /// - Parameters:
    ///   - dataArray: 数据源
    ///   - column: 等宽分列,默认自适应
    public func reload(dataArray : [String],
                       column : Int = -1)
    {
        guard dataArray.count > 0 else {
            print("⚠️ 木有数据")
            return
        }
        // 保存数据
        if column >= 0 { self.config.column = column }
        self.dataArray = dataArray
        self.chooseItemArray = .init(repeating: nil, count: dataArray.count)
        self.chooseItemTitleArray.removeAll()
        self.chooseItemIndexArray.removeAll()
        // 清空旧规格控件
        for item in self.itemArray {
            item.xRemoveClickHandler()
            item.removeFromSuperview()
        }
        self.itemArray.removeAll()
        // 添加规格控件
        let cfg = self.config
        let font = UIFont.systemFont(ofSize: cfg.fontSize)
        for (i, title) in dataArray.enumerated()
        {
            let btn = UIButton(type: .system)
            btn.tag = i
            btn.setTitle(title, for: .normal)
            btn.titleLabel?.font = font
            btn.contentHorizontalAlignment = .center
            btn.layer.borderWidth = cfg.border.width
            btn.layer.borderColor = cfg.border.color.normal.cgColor
            btn.layer.cornerRadius = cfg.border.cornerRadius
            btn.backgroundColor = cfg.backgroundColor.normal
            btn.setTitleColor(cfg.titleColor.normal, for: .normal)
            // 添加响应事件
            btn.xAddClick {
                [unowned self] (sender) in
                self.choose(idx: sender.tag)
            }
            self.addSubview(btn)
            self.itemArray.append(btn)
        }
        // 更新布局
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    // MARK: - 选中
    /// 选中
    public func choose(idx : Int)
    {
        guard let item = self.itemArray.xObject(at: idx) else { return }
        if self.config.isMultiEnable {
            // 多选模式
            if self.chooseItemArray[idx] != nil {
                self.chooseItemArray[idx] = nil
                self.updateItemStyleToNormal(at: idx)
            } else {
                self.chooseItemArray[idx] = item
                self.updateItemStyleToChoose(at: idx)
            }
            self.chooseItemTitleArray.removeAll()
            self.chooseItemIndexArray.removeAll()
            for obj in chooseItemArray {
                guard let item = obj else { continue }
                self.chooseItemTitleArray.append(item.currentTitle ?? "")
                self.chooseItemIndexArray.append(item.tag)
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
    
}
