//
//  ViewController.swift
//  FourthWork_task2
//
//  Created by student on 2018/12/10.
//  Copyright © 2018年 XJW. All rights reserved.
//

import UIKit

//自定义UIView
class MyView:UIView{
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(ovalIn: rect)
        
        //设置红色边界
        UIColor.red.setStroke();
        path.stroke()
        
        //设置红色填充
        UIColor.green.setFill()
        path.fill()
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //创建椭圆 并加入视图中
        let oval = MyView(frame: CGRect(x: 50, y: 50, width: 100, height: 150))
        oval.backgroundColor = UIColor.clear
        self.view.addSubview(oval)
        
        //创建圆 并加入视图中
        let circle = MyView(frame: CGRect(x: 150, y: 150, width: 100, height: 100))
        circle.backgroundColor = UIColor.clear
        self.view.addSubview(circle)
    }
}

