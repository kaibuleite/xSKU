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
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard self.itemArray.count > 0 else { return }
        // 重新计算位置
        let cfg = self.config
        var itemFrame = CGRect.zero 
        let equalWidth = (self.frame.width - cfg.columnSpacing * CGFloat(cfg.column - 1)) / CGFloat(cfg.column)
        for item in self.itemArray {
            itemFrame.size = item.frame.size
            // 宽度
            if itemFrame.size.width == 0 || cfg.column > 0 {
                itemFrame.size.width = equalWidth
            }
            // 高度
            if itemFrame.size.height == 0 {
                itemFrame.size.height = cfg.itemHeight
            }
            // 换行
            if itemFrame.origin.x + itemFrame.width > self.bounds.width {
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
    
}
