enum Gender{
    case male, female
}
class Person:CustomStringConvertible {
    var firstName:String
    var lastName:String
    var age:Int
    var gender:Gender
    var fullName:String { return firstName+lastName }
    init(firstName:String, lastName:String, age:Int, gender:Gender) {
        self.firstName=firstName
        self.lastName=lastName
        self.age=age
        self.gender=gender
    }
    convenience init(firstName:String){         //便利构造函数
        self.init(firstName: firstName, lastName:"", age:18, gender:Gender.female)
    }
    
    //实现CustomStringConvertible协议中的计算属性，就可以使用print直接输出对象内容
    var description:String {
        return "fullName:\(fullName), age:\(age), gender:\(gender)"
    }
    
    //Person增加run方法
    func run(){
        print("Person ", fullName, " is running")
    }
    
}

var person1 = Person(firstName: "xia", lastName: "jingwen", age:20, gender:Gender.female)
var person2 = Person(firstName: "yang")
var person3 = person1
print("--------------使用print直接输出Person类实例---------------")
print("person1:",person1)
print("person2:",person2)

//重写等于和不等于运算符
func == (p1:Person, p2:Person)->Bool{
    if p1.fullName == p2.fullName && p1.gender==p2.gender && p1.age == p2.age{
        return true
    }
    return false
}

func != (p1:Person, p2:Person)->Bool{
    if (p1.fullName != p2.fullName) || (p1.gender != p2.gender) || (p1.age != p2.age){
        return true
    }
    return false
}

print("--------------利用==和!=判断对象是否相等---------------")
print("person1:",person1)
print("person2:",person2)
print("person3:",person3)
if person1 != person2{
    print("person1和person2不相等")
}else{
    print("person1和person2相等")
}
if person1==person3{
    print("person1和person3相等")
}else{
    print("person1和person3不相等")
}


//Department枚举
enum Department{
    case dongyuan, xiyuan
}

//SchoolProtocol 协议
protocol SchoolProtocol{
    var department: Department {get set}
    func lendBook()
}

print("--------------Person的子类Teacher和Student---------------")
//Teacher类
class Teacher:Person,SchoolProtocol {
    var title:String
    var department:Department       //添加新属性department以实现协议中的Department枚举
    
    init(firstName: String, lastName: String, age: Int, gender: Gender, title:String, department:Department) {
        self.title=title
        self.department = department
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    
    override var description:String {
        return "fullName:\(fullName), age:\(age), gender:\(gender)" + ", title:\(title)" + ", department:\(department)"
    }
    
    override func run(){
        print("Teacher  \(self.fullName)  is running")
    }
    
    func lendBook(){
        print("Teacher  \(self.fullName) lend a book")
    }
}
var teacher1 = Teacher(firstName: "yang", lastName: "tihua", age: 50, gender: Gender.male, title:"professor", department:Department.dongyuan)
print("teacher1:",teacher1)


//Student类
class Student: Person,SchoolProtocol{
    var stuNo:String
    var department:Department
    
    init(firstName: String, lastName: String, age: Int, gender: Gender, stuNo:String,department:Department) {
        self.stuNo = stuNo
        self.department = department
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    
    override var description:String {
        return "fullName:\(fullName), age:\(age), gender:\(gender)" + ", stuNo:\(stuNo)"+", department:\(department)"
    }
    
    override func run(){
        print("Student \(self.fullName) is running")
    }
    
    //实现协议中的方法
    func lendBook(){
        print("Student \(self.fullName) lend a book")
    }
}
var student1 = Student(firstName: "xia", lastName: "jingwen", age: 20, gender: Gender.female, stuNo: "2016110342",department:Department.dongyuan)
print("student1:",student1)

//构造多个Person、Teacher和Student对象，并将这些对象存入同一个数组中
var container = [Person]()
var person4 = Person(firstName: "li")
var person5 = Person(firstName: "yang", lastName: "fei", age: 20, gender: Gender.male)
container.append(person1)
container.append(person2)
container.append(person3)
container.append(person4)
container.append(person5)

var teacher2 = Teacher(firstName: "wang", lastName: "xiaoling", age: 44, gender: Gender.female, title:"Lecturer",department:Department.xiyuan)
var teacher3 = Teacher(firstName: "huang", lastName: "xiao", age: 28, gender: Gender.female, title:"associate professor",department:Department.dongyuan)
var teacher4 = Teacher(firstName: "he", lastName: "ping", age: 35, gender: Gender.female, title:"professor",department:Department.dongyuan)
container.append(teacher1)
container.append(teacher2)
container.append(teacher3)
container.append(teacher4)

var student2 = Student(firstName: "sui", lastName: "yuan", age: 19, gender: Gender.female, stuNo: "2016110333",department:Department.xiyuan)
var student3 = Student(firstName: "yang", lastName: "huimiao", age: 18, gender: Gender.female, stuNo: "201611031",department:Department.dongyuan)
container.append(student1)
container.append(student2)
container.append(student3)


var countPerson:Int = 0
var counTeacher:Int = 0
var countStudent:Int = 0

for item in container{
    if item is Teacher{
        counTeacher = counTeacher+1
    }else if item is Student{
        countStudent = countStudent + 1
    }else{
        countPerson = countPerson+1
    }
}
print("---------------Person Teacher Student 的个数--------------")
var objNumDict:[String:Int] = ["Person":countPerson, "Teacher":counTeacher, "Student":countStudent]
for (key, value) in objNumDict{
    print("类：\(key), 个数：\(value)")
}

//对数组按age升序输出
print("---------------按age升序--------------")
var container1 = container.sorted(by: {$0.age < $1.age})
for value in container1{
    print(value)
}


//对数组按fullName升序输出
print("---------------按fullName升序--------------")
var container2 = container.sorted(by: {$0.fullName < $1.fullName})
for value in container2{
    print(value)
}

//重载< 可以用于Gender判断
func < (g1:Gender, g2:Gender)->Bool{
    if(g1==Gender.female && g2==Gender.male){
        return true
    }else{
        return false
    }
}

//对数组按gender+age升序输出
print("---------------按gender+age升序--------------")
var container3 = container.sorted(by: {
    if $0.gender < $1.gender{
        return true;
    }else if $0.gender==$1.gender{
        return $0.age<$1.age
    }else{
        return false;
    }
})
for value in container3{
    print(value)
}

//对数组进行穷举 调用每个对象的run()和满足协议SchoolProtocol对象的lendBook方法
print("--------调用每个对象的run()和满足协议SchoolProtocol对象的lendBook方法--------")
for item in container {
    item.run()
    if let teacher = item as? Teacher{
        teacher.lendBook()
    }else if let student = item as? Student{
        student.lendBook()
    }
}






