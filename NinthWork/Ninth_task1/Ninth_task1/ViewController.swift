//
//  ViewController.swift
//  Ninth_task1
//
//  Created by student on 2018/12/15.
//  Copyright © 2018年 XJW. All rights reserved.
//

/*
 (1)    Gesture
 a)    分别采用代码随机位置大小生成和直接拖拽的方式产生多个视图；
 b)    采用简单的动画进行移动；
 c)    给视图加上阴影(layer)；
 d)    可全部清空子视图；
 e)    视图支持手势（pan移动、tap删除、pinch缩放、rotation旋转）；
 提示：Pinch的scale属性可用于调整frame
 rotation需要用transform属性实现
 */
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 设置根视图的标题和背景颜色
        title = "Ninth Project"
        self.view.backgroundColor = UIColor.gray
        
        //导航栏上添加三个按钮
        let addButton = UIBarButtonItem(title: "添加", style:.plain, target: self, action: #selector(addView))
        let moveButton = UIBarButtonItem(title: "移动", style: .plain, target: self, action: #selector(moveView))
        let clearButton = UIBarButtonItem(title: "清空", style: .plain, target: self, action: #selector(clearView))
        
        self.navigationItem.rightBarButtonItems = [addButton, moveButton]
        self.navigationItem.leftBarButtonItem = clearButton
    }

    @objc func addView() {
        //设置最大宽度 防止自动生成的视图太大
        let maxWidth: CGFloat = 150
        let x = CGFloat(arc4random() % UInt32(self.view.bounds.width))
        let y = CGFloat(arc4random() % UInt32(self.view.bounds.height - 40)) + 40
        let point = CGPoint(x: x, y: y)
        let width = CGFloat(arc4random() % UInt32(maxWidth))
        let height = CGFloat(arc4random() % UInt32(maxWidth))
        let size = CGSize(width: width, height: height)
        let view = MyView(frame: CGRect(origin: point, size: size))
        self.view.addSubview(view)
    }
    
    @objc func clearView() {
        self.view.subviews.map { $0.removeFromSuperview() }
    }
    
    @objc func moveView() {
        self.view.subviews.map { (view) in
            let x = CGFloat(arc4random() % UInt32(self.view.bounds.width))
            let y = CGFloat(arc4random() % UInt32(self.view.bounds.height - 40)) + 40
            let point = CGPoint(x: x, y: y)
            
            UIView.animate(withDuration: 3, animations: {
                view.center = point
            })
        }
    }
    
    
}

