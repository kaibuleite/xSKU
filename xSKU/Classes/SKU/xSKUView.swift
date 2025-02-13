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
    /// 当前那选中idx
    public var currentChooseIdx = 0
    /// 子控件
    public var itemArray = [UIView]()
    /// 子控件Frame
    public var itemFrameArray = [CGRect]()
    /// 选中的子控件
    var chooseItemArray = [UIView?]()
    /// 选中的子控件
    var chooseFlagArray = [Bool]()
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
        // 基本配置
        self.backgroundColor = .clear
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard self.itemArray.count > 0 else { return }
        // 重新计算位置
        let cfg = self.config
        let contentW = self.bounds.width
        var equalWidth = contentW
        if cfg.column > 0 {
            equalWidth = ((contentW - 1) - cfg.columnSpacing * CGFloat(cfg.column - 1)) / CGFloat(cfg.column)
        }
        if equalWidth <= 0 { equalWidth = 50 }
        
        var itemFrame = CGRect.zero
        for (i, item) in self.itemArray.enumerated() {
            // 默认使用控件自身宽高
            itemFrame.size = self.itemFrameArray[i].size
            // 根据条件使用等宽
            if itemFrame.size.width <= 0 || cfg.column > 0 {
                itemFrame.size.width = equalWidth
            }
            // 根据条件使用指定高度
            if itemFrame.size.height <= 0 || itemFrame.size.height > cfg.itemHeight {
                itemFrame.size.height = cfg.itemHeight
            }
            // 计算起始位置
            if itemFrame.origin.x + itemFrame.width > contentW {
                itemFrame.origin.x = 0
                itemFrame.origin.y += (cfg.rowSpacing + itemFrame.height)
            }
            // 更新 item fame
            item.frame = itemFrame
            itemFrame.origin.x += (cfg.columnSpacing + itemFrame.width)
        }
        // 执行回调
        var frame = self.bounds
        frame.size.height = itemFrame.maxY
        self.reloadHandler?(frame)
    }
    
}
