/*
 （1）实现Person类：
 a)    要求具有firstName,  lastName，age，gender等存储属性,fullName计算属性；其中gender是枚举类型（male，female）；
 b)    具有指定构造函数和便利构造函数；
 c)    两个Person实例对象可以用==和!=进行比较；
 d)    Person实例可以直接用print输出；
 （2）    从Person分别派生Teacher类和Student类：
 a)    Teacher类增加属性title，实例可以直接用print输出；
 b)    Student类增加属性stuNo，实例可以直接用print输出；
 （3）    分别构造多个Person、Teacher和Student对象，并将这些对象存入同一个数组中；
 （4）    对数组执行以下要求：
 a)    分别统计Person、Teacher和Student对象的个数并放入一字典中，统计完后输出字典内容；
 b)    对数组按以下要求排序并输出：age、fullName、gender+age；
 */
enum Gender{
    case male, female
}
class Person{
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
    func description() -> String {
        return "name:\(fullName), age:\(age), gender:\(gender)"
    }
}

var person1 = Person(firstName: "xia", lastName: "jingwen", age:20, gender:Gender.female)
var person2 = Person(firstName: "yang")
var person3 = person1
print("--------------使用print直接输出Person类实例---------------")
print(person1.description())
print(person2.description())

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
print("person1：",person1.description())
print("person2：",person2.description())
print("person3：",person3.description())
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

print("--------------Person的子类Teacher和Student---------------")
//Person类的子类 Teacher
class Teacher:Person{
    var title:String
    init(firstName: String, lastName: String, age: Int, gender: Gender, title:String) {
        self.title=title
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    override func description() -> String {
        return super.description()+", title:\(title)"
    }
}
var teacher1 = Teacher(firstName: "yang", lastName: "tihua", age: 50, gender: Gender.male, title:"professor")
print(teacher1.description())

class Student: Person{
    var stuNo:String
    init(firstName: String, lastName: String, age: Int, gender: Gender, stuNo:String) {
        self.stuNo = stuNo
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    override func description() -> String {
        return super.description()+", stuNo:\(stuNo)"
    }
}
var student1 = Student(firstName: "xia", lastName: "jingwen", age: 20, gender: Gender.female, stuNo: "2016110342")
print(student1.description())

//构造多个Person、Teacher和Student对象，并将这些对象存入同一个数组中
var container = [Person]()
var person4 = Person(firstName: "li")
var person5 = Person(firstName: "yang", lastName: "fei", age: 20, gender: Gender.male)
container.append(person1)
container.append(person2)
container.append(person3)
container.append(person4)
container.append(person5)

var teacher2 = Teacher(firstName: "wang", lastName: "xiaoling", age: 44, gender: Gender.female, title:"Lecturer")
var teacher3 = Teacher(firstName: "huang", lastName: "xiao", age: 28, gender: Gender.female, title:"associate professor")
var teacher4 = Teacher(firstName: "he", lastName: "ping", age: 35, gender: Gender.female, title:"professor")
container.append(teacher1)
container.append(teacher2)
container.append(teacher3)
container.append(teacher4)

var student2 = Student(firstName: "sui", lastName: "yuan", age: 19, gender: Gender.female, stuNo: "2016110333")
var student3 = Student(firstName: "yang", lastName: "huimiao", age: 18, gender: Gender.female, stuNo: "201611031")
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
    print(value.description()+"\n")
}


//对数组按fullName升序输出
print("---------------按fullName升序--------------")
var container2 = container.sorted(by: {$0.fullName < $1.fullName})
for value in container2{
    print(value.description()+"\n")
}

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
    print(value.description()+"\n")
}
