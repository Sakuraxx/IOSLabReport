/*
 （1）    给定一个Dictionary，Dictionary包含key值name和age，用map函数返回age字符串数组;
 （2）    给定一个String数组，用filter函数选出能被转成Int的字符串
 （3）    用reduce函数把String数组中元素连接成一个字符串，以逗号分隔
 （4）    用 reduce 方法一次求出整数数组的最大值、最小值、总数和
 （5）    新建一个函数数组，函数数组里面保存了不同函数类型的函数，要求从数组里找出参数为一个整数，返回值为一个整数的所有函数；
 （6）    扩展Int，增加sqrt方法，可以计算Int的Sqrt值并返回浮点数，进行验证；
 （7）    实现一个支持泛型的函数，该函数接受任意个变量并返回最大和最小值，分别传入整数值、浮点数值、字符串进行验证。
 */

import UIKit 

//1
let infoDict = [["name":"Sakura", "age":20],["name":"Rose", "age":21],["name":"Mike", "age":22]]
let infoAge = infoDict.map( {$0["age"]!} )
print("用map函数返回age字符串数组为：",infoAge)

//2
let strArr = ["123", "sakura", "12345ww", "98765"]
let strToInt = strArr.filter( {Int($0) != nil} )   //先将字符串强转为Int 若是失败则过滤掉该字符串
print("用filter函数选出能被转成Int的字符串:",strToInt)
//map和filter的区别：filter函数不改变元素的值，而map函数会改变元素的值

//3
let initialStr = ["sakura", "yell", "goodbye"]
var mergedStr = initialStr.reduce("", {$0+","+$1})
mergedStr.remove(at: mergedStr.startIndex)      //合并后的字符串前面多了一个逗号  最后去掉该逗号
print("用reduce函数把String数组中元素连接成一个字符串，以逗号分隔:",mergedStr)

//4
let intArr = [12,2,1,-3,98,100]
let requiredNum = intArr.reduce((max:intArr[0], min:intArr[0],sum:0), {(max:max($0.max,$1),min:min($0.min,$1), sum:$0.sum+$1)})
print("整数数组的最大值、最小值、总数和分别为:",requiredNum)

//5
//函数类型为(Int, Int)->Int
func f1(x:Int, y:Int)->Int{
    return x-y
}

//函数类型为(Int)->Int
func f2(x:Int)->Int{
    return x
}

//函数类型为(Int)->void
func f3(x:Int){
}

//函数类型为(String)->Int
func f4(x:String)->Int{
    return Int(x)!
}

//函数类型为()->Int
func f5()->Int{
    return 0
}

let funcArr:[Any] = [f1, f2, f3, f4, f5]
for(index, value) in funcArr.enumerated(){
    if value is (Int)->Int{
        print("函数类型为(Int)->Int的函数是第",index+1,"个")
    }
}

//6
extension Int{
    func sqrt()->Double{
        return Foundation.sqrt(Double(self))
    }
}
print("扩展Int，增加sqrt方法，4的平方根是：",4.sqrt())

//7
func getMaxAndMin<T:Comparable>(arr:T...)->(T,T){
    var max = arr[0]
    var min = arr[1]
    for item in arr{
        if item>max{
            max = item
        }
        if item < min {
            min = item
        }
    }
    return (max, min)
}
print("(1,3,-2,8,19)中最大值和最小值分别为:",getMaxAndMin(arr:1,3,-2,8,19))
print("(3.1,4.9,-2.9,-10.1,1.0)中最大值和最小值分别为:",getMaxAndMin(arr:3.1,4.9,-2.9,-10.1,1.0))
print("(abce,aghj,sakura,zxy)中最大值和最小值分别为:",getMaxAndMin(arr:"abce","aghj","sakura","zxy"))
