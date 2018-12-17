//
//  MyViewController.swift
//  第五次作业代码
//
//  Created by student on 2018/10/24.
//  Copyright © 2018年 XJW. All rights reserved.
//
/*
 a)    删除storyboard和控制器代码；
 b)    新建控制器的子类，并完成相关代码；
 i.    代码中生成label（outlet）和button；
 ii.    将label和button加入根view中；
 iii.    button添加像self（target）发射action（selector）的操作；
 iv.    实现clicked响应代码（selector）
 c)    在app delegate中完成window和controller的创建；
 d)    自己制作一款Icon并添加Icon到程序中；
 e)    添加图片到程序中，并在程序中显示图片(可以Bundle定位)；
 f)    将自定制的视图添加到界面并显示；
 */

import UIKit
class MyViewController:UIViewController{

    //声明UILabel对象
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置根视图视图背景色
        self.view.backgroundColor = UIColor.white
        
        //创建UILabel对象
        label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 40))
        label.text = "hello world"
        label.backgroundColor = UIColor.yellow
        self.view.addSubview(label)
        
        //创建UIButton对象
        let btn = UIButton(frame: CGRect(x: 100, y: 250, width: 100, height: 40))
        btn.setTitle("click me", for: .normal)         //设置正常状态下按钮的标题
        btn.layer.borderWidth = 1                   //设置按钮边框宽度
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(clicked), for: .touchUpInside)    //给按钮添加target-action
        self.view.addSubview(btn)
        
        //创建UIImageView对象
        let imageView = UIImageView(frame: CGRect(x: 10, y: 400, width: self.view.frame.width - 20, height: (self.view.frame.width - 20) * 0.618))
        let path = Bundle.main.path(forResource: "micangliangzi", ofType: "jpg")        //获取图片资源路径
        let image = UIImage(contentsOfFile: path!)      //以该路径创建图片
        imageView.image = image                         //将图片加入到imageView中
        self.view.addSubview(imageView)                 //将imageView加入到控制器中
    }
    
    
    /// 按钮点击事件，改变label显示的文字
    @objc func clicked() {
        if label.text == "hello world" {
            label.text = "I'm clicked"
        } else {
            label.text = "hello world"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

