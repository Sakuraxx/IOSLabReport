//
//  InsertViewController.swift
//  TwelfthWork_task2
//
//  Created by sakura on 2018/12/16.
//  Copyright © 2018年 2016110342. All rights reserved.
//

import UIKit
import CoreData

class InsertViewController: UIViewController {
    //保存前一个界面传入的点击的cell的下标
    var row:Int?
    var nameTextField:UITextField!
    var ageTextField:UITextField!
    var nameLabel:UILabel!
    var ageLabel:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: 100, width: 100, height: 44))
        nameLabel.text = "姓名："
        nameLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(nameLabel)
        
        nameTextField = UITextField(frame: CGRect(x: 100, y: 100, width: 300, height: 44))
        nameTextField.layer.borderWidth = 1
        self.view.addSubview(nameTextField)
        
        ageLabel = UILabel(frame: CGRect(x: 0, y: 200, width: 100, height: 44))
        ageLabel.text = "年龄"
        ageLabel.textAlignment = NSTextAlignment.center
        self.view.addSubview(ageLabel)
        
        ageTextField = UITextField(frame: CGRect(x: 100, y: 200, width: 300, height: 44))
        ageTextField.layer.borderWidth = 1
        self.view.addSubview(ageTextField)
        
        let btn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        self.navigationItem.rightBarButtonItem = btn
        
        if row == nil {
            self.title = "添加"
        } else {
            self.title = "编辑"
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request: NSFetchRequest<Person> = Person.fetchRequest()
            if let persons = try? context.fetch(request) {
                nameTextField.placeholder = persons[row!].name
                ageTextField.placeholder = String(persons[row!].age)
            }
        }
    }
    
    @objc func done() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let name = self.nameTextField.text!
        let age = Int16(self.ageTextField.text!)
        
        if row == nil {
            if !name.isEmpty && age != nil {
                let person = Person(context: context)
                person.name = name
                person.age = age!
            }
        } else {
            let request: NSFetchRequest<Person> = Person.fetchRequest()
            if let persons = try? context.fetch(request) {
                if !name.isEmpty {
                    persons[row!].name = name
                }
                if age != nil {
                    persons[row!].age = age!
                }
            }
        }
        appDelegate.saveContext()
        self.navigationController?.popViewController(animated: true)
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
