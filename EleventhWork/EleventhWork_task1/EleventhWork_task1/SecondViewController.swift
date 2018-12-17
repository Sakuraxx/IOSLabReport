//
//  SecondViewController.swift
//  EleventhWork_task1
//
//  Created by student on 2018/12/15.
//  Copyright © 2018年 XJW. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    var name = ""
    var num = ""
    //设置代理 依赖协议
    var delegate: StudentProtocol?
    @IBOutlet weak var tfNum: UITextField!
    @IBOutlet weak var tfName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tfNum.text = num
        tfName.text = name

        // Do any additional setup after loading the view.
    }
    

    @IBAction func back(_ sender: Any) {
        num = tfNum.text!
        name = tfName.text!
        delegate?.change(name: name, num: num)
        navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
