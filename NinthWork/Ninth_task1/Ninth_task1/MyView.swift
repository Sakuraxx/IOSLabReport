//
//  MyView.swift
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

class MyView: UIView {
    //重写draw(_:)方法
    override func draw(_ rect: CGRect) {
        let rect = UIBezierPath(rect: rect)
        //使用arc4random()方法来生成随机数产生rgb颜色值
        let rColor = CGFloat(Float(arc4random()%255)/255)
        let gColor = CGFloat(Float(arc4random()%255)/255)
        let bColor = CGFloat(Float(arc4random()%255)/255)
        UIColor(red: rColor, green: gColor, blue: bColor, alpha: 1.0).set()
        //设置图形的边界和填充颜色为生成的随机颜色
        rect.stroke()
        rect.fill()
    }
    
    //重写初始化函数
    override init(frame: CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    //必须实现UIView的另一个初始化函数
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setup()
    }
    
    //在此方法中设置视图的阴影并添加要求的手势
    func setup(){
        //设置矩形区域圆角
        self.layer.cornerRadius = 20
        
        //设置阴影颜色 偏移 透明度
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.shadowOpacity = 0.8
        //设置视图的内容模式为重绘
        self.contentMode = .redraw
        
        //pan移动
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(pan(gesture:)))
        self.addGestureRecognizer(panGesture)
        
        //tap删除
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap(gesture:)))
        self.addGestureRecognizer(tapGesture)
        
        //pinch缩放
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch(gesture:)))
        self.addGestureRecognizer(pinchGesture)
        
        //rotation旋转
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotation(gestrue:)))
        self.addGestureRecognizer(rotationGesture)
    }
   
    //pan移动
    @objc func pan(gesture: UIPanGestureRecognizer) {
        self.center = gesture.location(in: superview)
    }
    
    //tap删除
    @objc func tap(gesture: UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
    
    //pinch缩放
    @objc func pinch(gesture: UIPinchGestureRecognizer) {
        let scale = gesture.scale
        self.transform = self.transform.scaledBy(x: scale, y: scale)
        gesture.scale = 1
    }
    
    //rotation旋转
    @objc func rotation(gestrue: UIRotationGestureRecognizer) {
        let rotation = gestrue.rotation
        self.transform = self.transform.rotated(by: rotation)
        gestrue.rotation = 0
    }
        
    
    
 

}
