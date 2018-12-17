//
//  WeatherViewController.swift
//  ThireteenthWork_task3
//
//  Created by sakura on 2018/12/17.
//  Copyright © 2018年 2016110342. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var weather: String?
    var navTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.title = navTitle
        
        let label = UILabel(frame: CGRect(x: 10, y: 100, width: self.view.frame.width - 20, height: self.view.frame.height - 150))
        label.text = weather!
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 36)
        self.view.addSubview(label)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
