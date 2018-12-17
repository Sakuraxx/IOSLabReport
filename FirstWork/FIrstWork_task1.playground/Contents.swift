
/*
 题目：输出1-10000之间的质数 将找出的质数存入可变数组，对数组进行正反排序并输出结果（使用5种以上方法）
 */

// 方法1: 传统的判断一个数是否为质数的方法 使用系统的sort方法正向排序和自定义方法逆序排序
var primesInit = [Int]()
for i in 2...100{
    var isPrime=true
    for j in 2..<i {
        if i%j == 0{
            isPrime = false
        }
    }
    if isPrime {
        primesInit.append(i)
    }
}
primesInit.append(3)                //添加几个质数，以反应后面到达排序的效果
primesInit.append(5)
primesInit.append(2)
print("未排序：", primesInit)

var primesOrder1 = primesInit
primesOrder1.sort()                   //正序
print("方法1正序：", primesOrder1)

func reverse(x : Int, y : Int)->Bool{
    return x > y
}
var primesReverse1 = primesInit.sorted(by: reverse)
print("方法1逆序：", primesReverse1)           //逆序
//方法2: 使用自定的排序方法
func positiveOrder(x : Int, y : Int)->Bool{
    return x < y
}
var primesOrder2 = primesInit.sorted(by: positiveOrder)
print("方法2正序：", primesOrder2)

//方法3: 闭包表达式
var primesReverse3 = primesInit.sorted(by: {(x:Int, y:Int)->Bool in return x>y})
var primesOrder3 = primesInit.sorted(by: {(x:Int, y:Int)->Bool in  return x<y})
print("方法3正序：", primesOrder3)
print("方法3逆序：", primesReverse3)
//方法4: 根据上下文推断类型的排序
var primesReverse4 = primesInit.sorted(by: {x, y in  return x>y})
var primesOrder4 = primesInit.sorted(by: {x, y in return x<y})
print("方法4正序：", primesOrder4)
print("方法4逆序：", primesReverse4)

//方法5: 单表达式闭包隐式返回
var primesReverse5 = primesInit.sorted(by: {x, y in x>y})
var primesOrder5 = primesInit.sorted(by: {x,y in x<y})
print("方法5正序：", primesOrder5)
print("方法5逆序：", primesReverse5)

//方法6: 名称缩写
var primesReverse6 = primesInit.sorted(by: {$0 > $1})
var primesOrder6 = primesInit.sorted(by: {$0 < $1})
print("方法6正序：", primesOrder6)
print("方法6逆序：", primesReverse6)
