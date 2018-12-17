//
//  ViewController.swift
//  ThirteenWork_task2
//
//  Created by RPZ on 2018/12/16.
//  Copyright © 2018年 XJW. All rights reserved.
//

/*
 (2)Web浏览器;
 a)使用WebView控件写成一个简易的浏览器，有浏览器的基本功能；
 */
import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var webView: WKWebView!
    var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white
        
        let width = self.view.frame.width
        let height = self.view.frame.height
        let buttonHeight: CGFloat = 40
        let buttonWidth: CGFloat = width / 5
        
        webView = WKWebView(frame: CGRect(x: 0, y: (buttonHeight + 10) * 2, width: width, height: height - (buttonHeight + 10) * 2))
        self.view.addSubview(webView)
        loadURL(path: "www.baidu.com")
        
        textField = UITextField(frame: CGRect(x: 10, y: buttonHeight + 20, width: width / 5 * 4, height: buttonHeight))
        textField.placeholder = "www.baidu.com"
        textField.layer.borderWidth = 1
        textField.delegate = self
        textField.returnKeyType = .done
        self.view.addSubview(textField)
        
        let goBtn = UIButton(frame: CGRect(x: buttonWidth * 4 + 10, y: buttonHeight + 20, width: buttonWidth - 10, height: buttonHeight))
        goBtn.setTitle("GO", for: .normal)
        goBtn.setTitleColor(UIColor.black, for: .normal)
        goBtn.setTitleColor(UIColor.brown, for: .highlighted)
        goBtn.addTarget(self, action: #selector(goWeb), for: .touchUpInside)
        self.view.addSubview(goBtn)
        
        let backBtn = UIButton(frame: CGRect(x: 10, y: 20, width: buttonWidth, height: buttonHeight))
        backBtn.setTitle("<", for: .normal)
        backBtn.setTitleColor(UIColor.gray, for: .normal)
        backBtn.setTitleColor(UIColor.brown, for: .highlighted)
        backBtn.addTarget(self, action: #selector(backWeb), for: .touchUpInside)
        self.view.addSubview(backBtn)
        
        let forwardBtn = UIButton(frame: CGRect(x: 20 + buttonWidth, y: 20, width: buttonWidth, height: buttonHeight))
        forwardBtn.setTitle(">", for: .normal)
        forwardBtn.setTitleColor(UIColor.gray, for: .normal)
        forwardBtn.setTitleColor(UIColor.brown, for: .highlighted)
        forwardBtn.addTarget(self, action: #selector(forwardWeb), for: .touchUpInside)
        self.view.addSubview(forwardBtn)
        
        let freshBtn = UIButton(frame: CGRect(x: 30 + buttonWidth * 2, y: 20, width: buttonWidth, height: buttonHeight))
        freshBtn.setTitle("⟳", for: .normal)
        freshBtn.setTitleColor(UIColor.gray, for: .normal)
        freshBtn.setTitleColor(UIColor.brown, for: .highlighted)
        freshBtn.addTarget(self, action: #selector(freshWeb), for: .touchUpInside)
        self.view.addSubview(freshBtn)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func freshWeb() {
        webView.reload()
    }
    
    @objc func forwardWeb() {
        webView.goForward()
    }
    
    @objc func backWeb() {
        webView.goBack()
    }
    
    @objc func goWeb() {
        let path = textField.text ?? ""
        loadURL(path: path)
    }
    
    func loadURL(path: String) {
        let url: URL?
        if path.hasPrefix("http://") {
            url = URL(string: path)
        } else {
            url = URL(string: "http://\(path)")
        }
        if url != nil {
            let request = URLRequest(url: url!)
            webView.load(request)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

