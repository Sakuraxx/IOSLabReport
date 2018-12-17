//
//  ViewController.swift
//  TwelfthWork_task2
//
//  Created by sakura on 2018/12/16.
//  Copyright © 2018年 2016110342. All rights reserved.
//

/*
 (2)采用多MVC和SQLite或Core Data构造一个Person信息维护程序，要求：
 a)可插入新数据；
 b)可删除修改原数据；
 c)可查询特定数据；
 */
import UIKit
import CoreData



class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    //视图中的表
    var tableView:UITableView!
    //保存数据库中的数据
    var personArray = [Person]()
    //应用代理
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Persons"
        self.view.backgroundColor = UIColor.gray
        
        tableView = UITableView(frame: self.view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        let searchBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(search))
        self.navigationItem.leftBarButtonItem = searchBtn
        
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    @objc func search() {
        let viewController = SearchViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func add() {
        let viewController = InsertViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            cell?.accessoryType = .disclosureIndicator
        }
        
        cell?.textLabel?.text = personArray[indexPath.row].name
        cell?.detailTextLabel?.text = String(personArray[indexPath.row].age)
        
        return cell!
    }
    
    //在每一次界面即将显示时就会调用一次 利用此重新加载数据
    override func viewWillAppear(_ animated: Bool) {
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        
        if let persons = try? context.fetch(request) {
            personArray = persons
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = InsertViewController()
        viewController.row = indexPath.row
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            personArray.remove(at: indexPath.row)
            tableView.reloadData()
            
            //多线程的方式删除数据库中的数据，这样可以减少界面的卡顿
            DispatchQueue.global().async {
                let context = self.appDelegate.persistentContainer.viewContext
                
                let request: NSFetchRequest<Person> = Person.fetchRequest()
                if let persons = try? context.fetch(request) {
                    context.delete(persons[indexPath.row])
                    self.appDelegate.saveContext()
                }
            }
        }
    }
    
}


