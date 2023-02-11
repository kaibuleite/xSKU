//
//  xSKUView.swift
//  xSDK
//
//  Created by Mac on 2020/9/19.
//

import UIKit
import xExtension

public class xSKUView: UIView {

    // MARK: - Handler
    /// 选中回调
    public typealias xHandlerChooseItem = (Int) -> Void
    /// 刷新数据回调，返回尺寸
    public typealias xHandlerReloadCompleted = (CGRect) -> Void
    
    // MARK: - Public Property
    /// 配置
    public var config = xSKUConfig()
    /// 当期那选中item
    public var currentChooseIdx = 0
    
    // MARK: - Private Property
    /// 子控件
    var itemViewArray = [UIButton]()
    /// 选择回调
    var chooseHandler : xHandlerChooseItem?
    /// 刷新回调
    var reloadHandler : xHandlerReloadCompleted?
    
    // MARK: - 内存释放
    deinit {
        self.chooseHandler = nil
        self.reloadHandler = nil
    }
    
    // MARK: - Public Override Func
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard self.itemViewArray.count > 0 else { return }
        // 更新UI
        let cfg = self.config
        var itemFrame = CGRect.zero
        itemFrame.size.height = cfg.itemHeight
        if cfg.column > 0 {   // 等宽
            itemFrame.size.width = (self.frame.width - cfg.columnSpacing * CGFloat(cfg.column - 1)) / CGFloat(cfg.column)
        }
        for item in self.itemViewArray {
            if cfg.column <= 0, let lbl = item.titleLabel {
                // 自适应宽度
                let size = lbl.xContentSize(margin: cfg.itemMarginEdgeInsets)
                itemFrame.size.width = size.width
            }
            if itemFrame.origin.x + itemFrame.width > self.bounds.width {
                // 换行
                itemFrame.origin.x = 0
                itemFrame.origin.y += (cfg.rowSpacing + itemFrame.height)
            }
            item.frame = itemFrame
            itemFrame.origin.x += (cfg.columnSpacing + itemFrame.width)
        }
        // 更新frame
        var frame = self.bounds
        frame.size.height = itemFrame.origin.y + itemFrame.height
        self.reloadHandler?(frame)
    }
    
    // MARK: - Public Func
    // TODO: 数据加载
    /// 加载组件数据
    /// - Parameters:
    ///   - dataArray: 数据源
    ///   - column: 等宽分列,默认自适应
    ///   - handler: 回调
    public func reload(dataArray : [String],
                       column : Int = -1,
                       completed handler1 : @escaping xHandlerReloadCompleted,
                       choose handler2 : @escaping xHandlerChooseItem)
    {
        guard dataArray.count > 0 else {
            print("⚠️ 木有数据")
            return
        }
        self.clearOldSkuItem()
        if column >= 0 { self.config.column = column }
        self.reloadHandler = handler1
        self.chooseHandler = handler2
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
            btn.layer.cornerRadius = cfg.cornerRadius
            btn.layer.borderWidth = cfg.borderWidth
            btn.backgroundColor = cfg.itemBackgroundNormalColor
            btn.layer.borderColor = cfg.itemBorderNormalColor.cgColor
            btn.setTitleColor(cfg.itemTitleNormalColor, for: .normal)
            // 添加响应事件
            btn.xAddClick {
                [unowned self] (sender) in
                self.choose(idx: sender.tag)
            }
            self.addSubview(btn)
            self.itemViewArray.append(btn)
        }
        // 更新布局
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    // TODO: Item样式
    /// 选中
    public func choose(idx : Int)
    {
        guard idx >= 0 else { return }
        guard idx < self.itemViewArray.count else { return }
        self.updateItemsStyleDidEndChoose(idx: idx)
        self.chooseHandler?(idx)
    }
    /// 更新选中样式
    public func updateItemsStyleDidEndChoose(idx : Int)
    {
        // 更新样式
        if idx != self.currentChooseIdx {
            self.updateItemStyleToNormal(at: self.currentChooseIdx)
        }
        self.updateItemStyleToChoose(at: idx)
        // 保存idx
        self.currentChooseIdx = idx
    }
    /// 设置普通样式
    public func updateItemStyleToNormal(at idx : Int)
    {
        guard let item = self.getItem(at: idx)  else { return }
        let cfg = self.config
        item.backgroundColor = cfg.itemBackgroundNormalColor
        item.layer.borderColor = cfg.itemBorderNormalColor.cgColor
        item.setTitleColor(cfg.itemTitleNormalColor, for: .normal)
    }
    /// 设置选中样式
    public func updateItemStyleToChoose(at idx : Int)
    {
        guard let item = self.getItem(at: idx)  else { return }
        let cfg = self.config
        item.backgroundColor = cfg.itemBackgroundChooseColor
        item.layer.borderColor = cfg.itemBorderChooseColor.cgColor
        item.setTitleColor(cfg.itemTitleChooseColor, for: .normal)
    }

    // MARK: - Private Func
    /// 获取指定的item
    private func getItem(at idx : Int) -> UIButton?
    {
        guard idx >= 0 else { return nil }
        guard idx < self.itemViewArray.count else { return nil }
        return self.itemViewArray[idx]
    }
    /// 清空旧规格控件
    private func clearOldSkuItem()
    {
        for item in self.itemViewArray {
            item.xRemoveClickHandler()
            item.removeFromSuperview()
        }
        self.itemViewArray.removeAll()
    }
}
