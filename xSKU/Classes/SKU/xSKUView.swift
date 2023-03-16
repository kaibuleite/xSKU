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
    /// 当前那选中item
    public var currentChooseIdx = 0
    /// 数据源
    public var dataArray = [String]()
    /// 选中的Item标题
    public var chooseItemTitleArray = [String]()
    /// 选中的Item编号
    public var chooseItemIndexArray = [Int]() 
    /// 子控件
    var itemArray = [UIButton]()
    /// 选中的子控件
    var chooseItemArray = [UIButton?]()
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
        // 更新UI
        let cfg = self.config
        var itemFrame = CGRect.zero
        itemFrame.size.height = cfg.itemHeight
        if cfg.column > 0 {   // 等宽
            itemFrame.size.width = (self.frame.width - cfg.columnSpacing * CGFloat(cfg.column - 1)) / CGFloat(cfg.column)
        }
        for item in self.itemArray {
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
    
    // MARK: - 添加回调
    public func addChooseItem(handler : @escaping xSKUView.xHandlerChooseItem)
    {
        self.chooseHandler = handler
    }
    public func addReloadCompleted(handler : @escaping xSKUView.xHandlerReloadCompleted)
    {
        self.reloadHandler = handler
    }
}
