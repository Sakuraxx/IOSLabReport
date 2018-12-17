//
//  ViewController.swift
//  NinthWork_task2
//
//  Created by student on 2018/12/15.
//  Copyright © 2018年 XJW. All rights reserved.
//

/*
 (2)    实现UIAlertController交互
 a)    显示ActionSheet并进行交互；
 b)    显示Login Alert并进行交互；
 */
import UIKit

class ViewController: UIViewController {

    //用于改变背景颜色
    var myview:UIView!
    //保存用户输入的用户名和密码
    var label :UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //向view视图中添加lable
        title = "Alert提示框"
        self.view.backgroundColor = UIColor.gray
        label = UILabel(frame: CGRect(x: 0, y: 500, width: self.view.bounds.width, height: 70))
        label.textColor = UIColor.red
        label.numberOfLines = 0
        label.textAlignment = .center
        self.view.addSubview(label)
        
        //向view视图中添加myView子视图
        myview = UIView(frame: CGRect(x: 150, y: 200, width: 100, height: 100))
        myview.backgroundColor = UIColor.cyan
        self.view.addSubview(myview)
        
        // 向导航栏左右添加两个按钮
        let rightBtn = UIBarButtonItem(title: "弹出对话框", style: .plain, target: self, action: #selector(alertLogin))
        self.navigationItem.rightBarButtonItem = rightBtn
        
        let leftBtn = UIBarButtonItem(title: "改变子视图颜色", style: .plain, target: self, action: #selector(actionSheet))
        self.navigationItem.leftBarButtonItem = leftBtn
    }
    
    //登陆对话框
    @objc func alertLogin() {
        let alert = UIAlertController(title: "请填写你的信息", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (tf) in
            tf.placeholder = "用户名："
        }
        alert.addTextField { (tf) in
            tf.placeholder = "密码："
        }
        
        let OKBtn = UIAlertAction(title: "确定", style: .default) { _ in
            let username = alert.textFields![0].text ?? ""
            let password = alert.textFields![1].text ?? ""
            let string = "用户名: \(username)\n密码: \(password)"
            self.label.text = string
        }
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        alert.addAction(OKBtn)
        alert.addAction(cancelBtn)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //选择颜色
    @objc func actionSheet() {
        let action = UIAlertController(title: "选择颜色", message: nil, preferredStyle: .actionSheet)
        
        let redBtn = UIAlertAction(title: "红色", style: .default) { (_) in
            self.myview.backgroundColor = UIColor.red
        }
        let greenBtn = UIAlertAction(title: "绿色", style: .default) { (_) in
            self.myview.backgroundColor = UIColor.green
        }
        let blueBtn = UIAlertAction(title: "蓝色", style: .default) { (_) in
            self.myview.backgroundColor = UIColor.blue
        }
        let yellowBtn = UIAlertAction(title: "黄色", style: .default) { (_) in
            self.myview.backgroundColor = UIColor.yellow
        }
        let blackBtn = UIAlertAction(title: "黑色", style: .default) { (_) in
            self.myview.backgroundColor = UIColor.black
        }
        let grayBtn = UIAlertAction(title: "灰色", style: .default) { (_) in
            self.myview.backgroundColor = UIColor.gray
        }
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        
        action.addAction(redBtn)
        action.addAction(greenBtn)
        action.addAction(blueBtn)
        action.addAction(yellowBtn)
        action.addAction(blackBtn)
        action.addAction(grayBtn)
        action.addAction(cancelBtn)
        
        self.present(action, animated: true, completion: nil)
    }
    
}

