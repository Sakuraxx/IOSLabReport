//
//  Person.swift
//  EigthWork
//
//  Created by student on 2018/11/13.
//  Copyright © 2018年 2016110342. All rights reserved.
//

import Foundation

//性别的枚举
enum Gender:Int{
    case female
    case male
    case unknow
    
    //重载 > 操作符 方便排序
    static func > (g1:Gender, g2:Gender)->Bool{
        return g1.rawValue < g2.rawValue
    }
}

//公寓
enum Department{
    case one, two, three
}

//继承CustomStringConvertible协议 可以实现自定义文本输出
class Person:CustomStringConvertible{
    var firstName:String
    var lastName:String
    var age:Int
    var gender:Gender
    var fullName:String{
        get{
            return firstName+lastName
        }
    }
    
    //实现CustomStringConvertible中的计算属性description 可以使用print直接输出
    var description: String{
        return "fullName:\(self.fullName),age:\(self.age),gender:\(self.gender)"
    }
    
    //构造方法
    init(firstName: String, lastName: String, age: Int, gender: Gender) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender
    }
    
    //便利构造函数
    convenience init(firstName: String, age: Int, gender: Gender) {
        self.init(firstName: firstName, lastName: "", age: age, gender: gender)
    }
    
    convenience init(firstName: String) {
        self.init(firstName: firstName, age: 0, gender: Gender.unknow)
    }
    
    required convenience init() {
        self.init(firstName: "")
    }
    
    //重载==
    static func ==(p1:Person, p2:Person)->Bool{
        return p1.fullName==p2.fullName && p1.age==p2.age && p1.gender==p2.gender
    }
    
    //重载=
    static func !=(p1:Person,p2:Person)->Bool{
        return !(p1==p2)
    }
}

//教师类
class Teacher:Person{
    var title:String  //教师级别
    
    //构造方法
    init(title: String, firstName: String, lastName: String, age: Int, gender: Gender) {
        self.title = title
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    
    init(title: String) {
        self.title = title
        super.init(firstName: "", lastName: "", age: 0, gender: .unknow)
    }
    
    convenience required init() {
        self.init(title: "")
    }
    
    //重写父类的description属性
    override var description: String {
        return "title: \(self.title), fullName: \(self.fullName), age: \(self.age), gender: \(self.gender)"
    }
}

//学生类
class Student:Person{
    var stuNo:Int //学号
    
    //构造方法
    init(stuNo: Int, firstName: String, lastName: String, age: Int, gender: Gender) {
        self.stuNo = stuNo
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    
    init(stuNo: Int) {
        self.stuNo = stuNo
        super.init(firstName: "", lastName: "", age: 0, gender: Gender.unknow)
    }
    
    required convenience init() {
        self.init(stuNo: 0)
    }
    
    //重写父类的计算属性
    override var description: String {
        return "stuNo: \(self.stuNo), fullName: \(self.fullName), age: \(self.age), gender: \(self.gender)"
    }
    
}







