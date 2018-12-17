//
//  ViewController.swift
//  ThriteenthWork_task1
//
//  Created by sakura on 2018/12/16.
//  Copyright © 2018年 2016110342. All rights reserved.
//

/*
 (1)采用多线程技术，实现一个大数加程序。
 a)正确理解DispatchQueue的使用
 b)从1 到 9999999
 c)不能阻塞UI主线程
 */

import UIKit

class ViewController: UIViewController {
    
    //显示计算结果
    var label:UILabel!
    
    //显示主线程现状
    var count = 0
    var timerLabel:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white
        
        //点击该按钮进行大数计算ß
        let btn = UIButton(frame: CGRect(x:20, y:100, width: 100, height:40))
        btn.setTitle("开始计算", for:.normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.setTitleColor(UIColor.brown, for: .highlighted)
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(startCal), for: .touchUpInside)
        self.view.addSubview(btn)
        
        //显示计算结果
        label = UILabel(frame: CGRect(x: 20, y: 50, width: 300, height: 40))
        label.text="1"
        label.textColor = UIColor.black
        self.view.addSubview(label)
        
        //显示主线程有没有被阻塞
                timerLabel = UILabel(frame: CGRect(x: 10, y: 200, width: 200, height: 100))
                timerLabel.textColor = UIColor.black
                timerLabel.textAlignment = .center
                timerLabel.layer.borderWidth = 1
                timerLabel.font = UIFont.systemFont(ofSize:40)
                self.view.addSubview(timerLabel)
        
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                    self.count += 1
                    self.timerLabel.text = "\(self.count)"
                    }.fire()
    }
    
    @objc func startCal() {
        //在其他线程中进行计算
        DispatchQueue.global().async {
            var number = 0
            for num in 1...9999999 {
                number += num
                //在主线程中改变label显示的值
                DispatchQueue.main.async {
                    self.label.text = "\(number)"
                }
            }
        }
    }
    
    
}

