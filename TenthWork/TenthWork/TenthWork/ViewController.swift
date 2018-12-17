//
//  ViewController.swift
//  TenthWork
//
//  Created by sakura on 2018/12/15.
//  Copyright © 2018年 2016110342. All rights reserved.
//

/*
 (1)基于UIView.animation实现如下动画效果：
 a)改变视图的位置
 b)改变视图的大小
 c)改变视图的transform
 (2)基于UIView.transition实现如下动画效果：
 a)改变视图的背景颜色；
 b)切换两个子视图，观察切换后视图层次的变化情况；
 (3)基于UIDynamicAnimtor实现简单的力学动画：
 a)可以掉落方块；
 b)有碰撞；
 可以反弹
 */
import UIKit

class ViewController: UIViewController {

    var firstView:UIView!
    var secondView:UIView!
    var animator: UIDynamicAnimator!
    var gravity = UIGravityBehavior()
    var collision = UICollisionBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        animation()
        transition()
        dynamicAnimation()
    }
    
    //改变视图大小 位置 转换的改变
    func animation(){
        let view = UIView(frame:CGRect(x:300, y:100, width:100, height:100))
        view.backgroundColor = UIColor.yellow
        self.view.addSubview(view)
        UIView.animate(withDuration: 3, delay: 0,  options: [.repeat, .autoreverse], animations: {
            view.frame = CGRect(x: 0, y: 50, width: 10, height: 10)
            view.backgroundColor = UIColor.gray
            view.transform = view.transform.rotated(by: CGFloat.pi)
        }, completion: nil)
    }
    
    //初始化两个UIView添加一个开始动画的按钮
    func transition() {
        let btn = UIButton(frame: CGRect(x: 0, y: 300, width: 100, height: 44))
        btn.setTitle("切换视图", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(changeView), for: .touchUpInside)
        self.view.addSubview(btn)
        
        firstView = UIView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        firstView.backgroundColor = UIColor.purple
        self.view.addSubview(firstView)
        
        secondView = UIView(frame: CGRect(x: 100, y: 300, width: 100, height: 100))
        secondView.backgroundColor = UIColor.brown
        self.view.addSubview(secondView)
        
    }
    
    @objc func changeView() {
        UIView.transition(from: secondView, to: firstView, duration: 3, options: [.transitionCurlUp], completion: nil)
    }
    
    func dynamicAnimation() {
        animator = UIDynamicAnimator(referenceView: self.view)
        
        animator.addBehavior(gravity)
        animator.addBehavior(collision)
        
        collision.translatesReferenceBoundsIntoBoundary = true
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { (t) in
            let x = CGFloat(arc4random() % (UInt32(self.view.frame.width) - 50))
            let view = UIView(frame: CGRect(x: x, y: 20, width: 50, height: 50))
            view.backgroundColor = UIColor.red
            view.layer.borderWidth = 1
            view.layer.cornerRadius = 10
            self.view.addSubview(view)
            self.gravity.addItem(view)
            self.collision.addItem(view)
        }
    }

}

