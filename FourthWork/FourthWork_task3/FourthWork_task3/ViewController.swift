//
//  ViewController.swift
//  FourthWork_task3
//
//  Created by student on 2018/12/10.
//  Copyright © 2018年 XJW. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var label:UILabel!
    var button:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //指定label位置
        label = UILabel(frame: CGRect(x: 200, y: 100, width: 200, height: 150))
        label.text = "Hello World"
        label.textColor = UIColor.red
        self.view.addSubview(label)
        
        //指定button位置
        button = UIButton(frame: CGRect(x: 200, y: 500, width: 100, height: 50))
        button.setTitle("Click me", for: .normal)
        button.backgroundColor = UIColor.blue
        button.setTitleColor(UIColor.black, for: .highlighted)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    @IBAction func click(){
        if label.text! == "Button Clicked"{
            label.text = "Hello World"
            button.setTitle("Click me", for: .normal)
        }else{
            label.text = "Button Clicked"
            button.setTitle("Click me", for: .normal)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

