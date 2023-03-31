//
//  ViewController.swift
//  xSKU
//
//  Created by 177955297@qq.com on 07/14/2021.
//  Copyright (c) 2021 177955297@qq.com. All rights reserved.
//

import UIKit
import xExtension
import xSKU

class ViewController: UIViewController {
    
    // MARK: - IBOutlet Property
    @IBOutlet weak var contentStack: UIStackView!
    @IBOutlet weak var sku1: xSKUView!
    @IBOutlet weak var sku1HeightLayout: NSLayoutConstraint!
    @IBOutlet weak var sku2: xSKUView!
    @IBOutlet weak var sku2HeightLayout: NSLayoutConstraint!
    @IBOutlet weak var sku3: xSKUView!
    @IBOutlet weak var sku3HeightLayout: NSLayoutConstraint!
    
    // MARK: - Public Property
    
    // MARK: - Override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        // 基本配置
        DispatchQueue.main.async {
            self.resetConfigBtnClick()
        }
    }
    
    // MARK: - 初始化SKU
    func initSKU(_ sku : xSKUView)
    {
        sku.backgroundColor = .xNewRandom(alpha: 0.2)
        sku.addReloadCompleted {
            [unowned self] (frame) in
            if sku == self.sku1 { self.sku1HeightLayout.constant = frame.height } else
            if sku == self.sku2 { self.sku2HeightLayout.constant = frame.height } else
            if sku == self.sku3 { self.sku3HeightLayout.constant = frame.height }
            self.contentStack.setNeedsLayout()
            self.contentStack.layoutIfNeeded()
        }
        sku.addChooseItem {
            (idx) in
            let list = sku.getChooseItemNameArray()
            print(list)
        }
        
        let config = sku.config
        let random = (arc4random() % 2 == 0)
        config.isMultiEnable = random
        config.fontSize = 15
        config.titleColor.normal = .xNewRandom()
        config.titleColor.choose = .xNewRandom()
        config.backgroundColor.normal = .xNewRandom(alpha: 0.5)
        config.backgroundColor.choose = .xNewRandom(alpha: 0.5)
        config.border.color.normal = .xNewRandom()
        config.border.color.choose = .xNewRandom()
        config.border.cornerRadius = 4
        config.border.width = (random ? 0 : 1)
        config.columnSpacing = 10
        config.rowSpacing = 10
        config.itemHeight = 30 + CGFloat.xNewRandom(max: 10)
    }

    
    // MARK: - 重置样式
    @IBAction func resetConfigBtnClick()
    {
        print("\(#function) in \(type(of: self))")
        self.view.endEditing(true)
        self.initSKU(self.sku1)
        self.initSKU(self.sku2)
        self.initSKU(self.sku3)
        
        let list1 = ["泉州", "厦门", "哈尔滨", "呼和浩特", "武汉", "重庆", "乌鲁木齐", "天津", "晋江", "华盛顿", "伦敦", "巴黎", "长安"]
        self.sku1.reload(dataArray: list1)
        
        let arr2 = ["🍏", "🍎", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑", "🍍", "🥝", "🥑", "🍅", "🍆", "🥒", "🥕", "🌶", "🥔", "🌽", "🍠", "🥜", "🍯", "🥐", "🍞", "🥖", "🧀", "🥚", "🥓", "🥞", "🍗", "🍖"]
        var list2 = [UILabel]()
        for str in arr2 {
            let lbl = UILabel()
            lbl.font = .systemFont(ofSize: 15)
            lbl.text = str
            lbl.textAlignment = .center
            list2.append(lbl)
        }
        // 等宽排列不用设置frame
        self.sku2.reload(itemViewArray: list2, column: 6)
        
        var list3 = [xSKUItem]()
        for _ in 0 ..< 20 {
            let view = xSKUItem()
            view.backgroundColor = .xNewRandom()
            view.frame = CGRect.init(x: 0, y: 0, width: 30 + CGFloat.xNewRandom(max: 50), height: 30)
            list3.append(view)
        }
        // 自动排列需要设置frame
        self.sku3.reload(itemViewArray: list3)
    }
}

