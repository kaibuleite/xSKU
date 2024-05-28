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
            print("⚠️ SKU没有数据")
            return
        } 
        // 创建新控件
        let cfg = self.config
        let font = UIFont.systemFont(ofSize: cfg.fontSize)
        var list = [UIView]()
        for (i, title) in dataArray.enumerated() {
            let btn = UIButton(type: .system)
            btn.tag = i
            btn.contentHorizontalAlignment = .center
            btn.setTitle(title, for: .normal)
            // 计算宽高
            if let lbl = btn.titleLabel {
                lbl.font = font
                let size = lbl.xContentSize(margin: cfg.itemMarginEdgeInsets)
                var frame = CGRect.zero
                frame.size = size
                if cfg.itemHeight > 0 {
                    frame.size.height = cfg.itemHeight
                }
                btn.frame = frame
            }
            list.append(btn)
        }
        self.reload(itemViewArray: list, column: column)
    }
    
    /// 加载自定义组件数据(view的frame自己设)
    /// - Parameters:
    ///   - itemViewArray: 视图列表
    ///   - column: 指定列数,默认自适应   
    public func reload(itemViewArray : [UIView],
                       column : Int = -1)
    {
        guard itemViewArray.count > 0 else {
            print("⚠️ SKU没有数据")
            return
        }
        // 清空旧规格控件
        for item in self.itemArray {
            item.removeFromSuperview()
        }
        self.itemArray.removeAll()
        // 保存数据
        if column >= 0 { self.config.column = column }
        let count = itemViewArray.count
        self.itemArray = itemViewArray
        self.chooseItemArray = .init(repeating: nil, count: count)
        self.chooseFlagArray = .init(repeating: false, count: count)
        // 排列控件
        let cfg = self.config
        for (i, item) in itemViewArray.enumerated() {
            item.tag = i
            // 设置初始样式
            item.layer.masksToBounds = true
            item.layer.cornerRadius = cfg.border.cornerRadius
            item.layer.borderWidth = cfg.border.width
            item.layer.borderColor = cfg.border.color.normal.cgColor
            item.backgroundColor = cfg.backgroundColor.normal
            // TODO: 按钮
            if let obj = item as? UIButton {
                obj.setTitleColor(cfg.titleColor.normal, for: .normal) 
                // 添加响应事件
                obj.xAddClick {
                    [unowned self] (sender) in
                    let idx = sender.tag
                    self.choose(idx: idx)
                }
            } else
            // TODO: 标签
            if let obj = item as? UILabel {
                obj.textColor = cfg.titleColor.normal
                // 添加响应事件
                obj.isUserInteractionEnabled = true
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapItem(_:)))
                obj.addGestureRecognizer(tap)
            } else
            // TODO: 自定义视图
            if let obj = item as? xSKUItem {
                obj.updateNormalStyle()
                // 添加响应事件
                obj.isUserInteractionEnabled = true
                let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapItem(_:)))
                obj.addGestureRecognizer(tap)
            }
            self.addSubview(item)
        }
        // 更新布局
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    // MARK: - 点击手势
    /// 点击手势
    @objc func tapItem(_ gesture : UITapGestureRecognizer)
    {
        guard let idx = gesture.view?.tag else { return }
        self.choose(idx: idx)
    }
    
}
