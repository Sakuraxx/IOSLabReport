//
//  ViewController.swift
//  EigthhWork
//
//  Created by student on 2018/11/13.
//  Copyright © 2018年 2016110342. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var students = [Student]()
    var teachers = [Teacher]()
    //定义表头数组
    var tableTitle = ["Teacher","Student"]
    //定义一个表视图
    var table:UITableView!
    //右边按钮
    var rightButton:UIBarButtonItem!
    //弹出框
    var alert :UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //-------------------师生信息准备-----------------
        self.title = "师生信息表"
        self.view.backgroundColor = UIColor.cyan
        
        let t1 = Teacher(title: "教授", firstName: "yang", lastName: "tihua", age: 40, gender: Gender.male)
        let t2 = Teacher(title: "副教授", firstName: "xia", lastName: "xixi", age: 29, gender: Gender.female)
        let t3 = Teacher(title: "讲师", firstName: "liu", lastName: "lili", age: 22, gender: Gender.male)
        teachers.append(t1)
        teachers.append(t2)
        teachers.append(t3)
        
        let s1 = Student(stuNo: 2016110300, firstName: "qiu", lastName: "yueyue", age: 18, gender: Gender.female)
        let s2 = Student(stuNo: 2016110301, firstName: "wang", lastName: "qingqing", age: 19, gender: Gender.female)
        let s3 = Student(stuNo: 2016110302, firstName: "wu", lastName: "xixi", age: 19, gender: Gender.female)
        let s4 = Student(stuNo: 2016110303, firstName: "bai", lastName: "huan", age: 20, gender: Gender.male)
        students.append(s1)
        students.append(s2)
        students.append(s3)
        students.append(s4)
        
        //按全名排序
        teachers.sort { return $0.fullName < $1.fullName }
        students.sort { return $0.fullName < $1.fullName }
        
        //----------------表格布局生成------------------------
        //创建表视图 并设置代理和数据源
        table = UITableView(frame: self.view.bounds)
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
        
        //导航栏控制器右边的编辑按钮
        rightButton = UIBarButtonItem(title:"编辑", style: .plain, target: self, action: #selector(edit))
        self.navigationItem.rightBarButtonItem = rightButton
        
        //导航栏控制器左边的添加按钮
        let leftButton = UIBarButtonItem(title: "添加", style: .plain, target: self, action: #selector(addStudentDialog))
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    //添加学生提示框
    @objc func addStudentDialog(){
        alert = UIAlertController(title: "添加学生", message: "请输入要求中的信息 添加学生", preferredStyle: .alert)
        alert.addTextField{(textField) in
            textField.placeholder = "学生学号"
        }
        alert.addTextField{(textField) in
            textField.placeholder = "学生姓氏"
        }
        alert.addTextField{(textField) in
            textField.placeholder = "学生名字"
        }
        alert.addTextField{(textField) in
            textField.placeholder = "性别（男/女）"
        }
        alert.addTextField{(textField) in
            textField.placeholder = "学生年龄"
        }
        
        let OKBtn = UIAlertAction(title: "确定", style: .default){
            (alert) in
            self.add()
        }
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(OKBtn)
        alert.addAction(cancelBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
    //添加学生
    func add(){
        let sno = Int(alert.textFields![0].text!)
        let firstName = alert.textFields![1].text!
        let lastName = alert.textFields![2].text!
        let gender:Gender
        switch  alert.textFields![3].text!{
        case "男":
            gender = Gender.male
        case "女":
            gender = Gender.female
        default:
            gender = .unknow
        }
        let age = Int(alert.textFields![4].text!)
        let student = Student(stuNo: sno!, firstName: firstName, lastName: lastName, age: age!, gender: gender)
        students.append(student)
        //在表中加载数据
        table.reloadData()
    }
    
    // 编辑表视图
    @objc func edit() {
        if table.isEditing {
            rightButton.title = "编辑"
            table.isEditing = false
        } else {
            rightButton.title = "完成"
            table.isEditing = true
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    //在选择表某一项时显示选择的信息
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = tableTitle[indexPath.section]
        let name:String
        if indexPath.section == 0{
            name = teachers[indexPath.row].fullName
        }else{
            name = students[indexPath.row].fullName
        }
        let message = "你选择了的是\(category), 全名: \(name)"
        
        //弹框提示
        let alert = UIAlertController(title: "系统提示", message: message, preferredStyle: .alert)
        let OKBtn = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(OKBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
    //编辑
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if indexPath.section == 0 {
                teachers.remove(at: indexPath.row)
            } else {
                students.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if sourceIndexPath.section != destinationIndexPath.section {
            tableView.reloadData()
        } else {
            if sourceIndexPath.section == 0 {
                teachers.insert(teachers.remove(at: sourceIndexPath.row), at: destinationIndexPath.row)
            } else {
                students.insert(students.remove(at: sourceIndexPath.row), at: destinationIndexPath.row)
            }
        }
    }
    
    //表项数量
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableTitle[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return teachers.count
        } else {
            return students.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = tableTitle[indexPath.section]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            let style: UITableViewCell.CellStyle = (identifier == "Teacher") ? .subtitle : .default
            cell = UITableViewCell(style: style, reuseIdentifier: identifier)
            cell?.accessoryType = .disclosureIndicator
        }
        
        switch identifier {
        case "Teacher":
            cell?.textLabel?.text = teachers[indexPath.row].fullName
            cell?.detailTextLabel?.text = teachers[indexPath.row].title
        case "Student":
            cell?.textLabel?.text = students[indexPath.row].fullName
        default:
            break
        }
        
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

