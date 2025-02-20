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
    public func reload(dataArray : [String])
    {
        guard dataArray.count > 0 else {
            print("⚠️ SKU没有数据")
            return
        }
        // 创建新控件
        let cfg = self.config
        var list = [xSKUItem]()
        
        for title in dataArray {
            let item = xSKUItem.loadXib()
            let lbl = item.titleLbl!
            lbl.numberOfLines = cfg.titleLines
            lbl.font = cfg.font.normal
            lbl.text = title
            // 计算内容宽度
            var frame = CGRect.zero
            var contentWidth = title.xContentWidth(for: cfg.font.normal,
                                                   height: cfg.itemHeight)
            contentWidth += cfg.itemMargin.left
            contentWidth += cfg.itemMargin.right
            frame.size.width = contentWidth
            // 是否固定宽高
            if cfg.itemWidth > 0 { frame.size.width = cfg.itemWidth }
            if cfg.itemHeight > 0 { frame.size.height = cfg.itemHeight }
            
            item.frame = frame
            list.append(item)
        }
        self.reload(itemViewArray: list)
    }
    
    /// 加载自定义组件数据(view的frame自己设)
    /// - Parameters:
    ///   - itemViewArray: 视图列表
    ///   - column: 指定列数,默认自适应
    public func reload(itemViewArray : [UIView])
    {
        guard itemViewArray.count > 0 else {
            print("⚠️ SKU没有数据")
            return
        }
        // 移除旧控件
        self.xRemoveAllSubViews()
        self.itemArray.removeAll()
        self.itemFrameArray.removeAll()
        // 保存数据
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
            self.updateItemStyleToNormal(at: i)
            // 保存Frame
            self.itemFrameArray.append(item.frame)
            self.addSubview(item)
            // 添加响应事件
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapItem(_:)))
            item.addGestureRecognizer(tap)
            item.isUserInteractionEnabled = true
        }
        // 更新布局
        self.setNeedsLayout()
        self.layoutIfNeeded()
        // 默认选中第一个数据
//        self.updateItemStyleToChoose(at: 0)
    }
    
    // MARK: - 点击手势
    /// 点击手势
    @objc func tapItem(_ gesture : UITapGestureRecognizer)
    {
        guard let idx = gesture.view?.tag else { return }
        self.choose(idx: idx)
    }
    
}
