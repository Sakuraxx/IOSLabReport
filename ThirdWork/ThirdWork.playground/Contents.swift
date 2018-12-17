/*
 1.显示当前准确的中文时间，包括北京、东京、纽约、伦敦，格式为（2016年9月28日星期三 上午10:25）
 a)显示中文需要设置locale
 2.处理字符串
 a)新建字符串：“Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS.”；
 b)返回字符串从第6个字符到第20个字符的子串；
 c)删除其中所有的OS字符；
 3.将1、2题的时间和字符串存入一个字典中，并存入沙盒中的Document某文件中；
 4.从网上下载一张照片并保存到本地沙盒的Document的某文件中；
 5.从网上查找访问一个JSon接口文件，并采用JSONSerialization和字典对其进行简单解析；
 */


//(1)
import UIKit
import Foundation

func getDate(date: Date, zone: Int = 0) -> String {
    let formatter = DateFormatter()  //实例化格式化类
    formatter.dateFormat = "yyyy年MM月dd日EEEE aa KK:mm"  //指定格式化的格式
    formatter.locale = Locale(identifier: "zh_CN")  //设置当前位置，可以将对应的星期数和12小时制的上下午设置为中文
    if zone >= 0 { //当传入的为正数时，在东半区
        formatter.timeZone = TimeZone(abbreviation: "UTC+\(zone):00")
    } else {  //当传入的为负数时，在西半区
        formatter.timeZone = TimeZone(abbreviation: "UTC\(zone):00")
    }
    
    let dateString = formatter.string(from: date)  //将传入的日期格式化为字符串
    return dateString
}

let currentDate = Date()

let Beijing = getDate(date: currentDate, zone: +8)  //获取当前北京的时间
print("北京时间: \(Beijing)")  //输出: 北京: 2017年09月19日星期二 下午 10:56
let Tokyo = getDate(date: currentDate, zone: 9)  //获取当前东京的时间
print("东京时间: \(Tokyo)")  //输出: 东京: 2017年09月19日星期二 下午 11:56
let NewYork = getDate(date: currentDate, zone: -5)  //获取当前纽约的时间
print("纽约时间: \(NewYork)")  //输出: 纽约: 2017年09月19日星期二 上午 09:56
let London = getDate(date: currentDate)  ////获取当前伦敦的时间
print("伦敦时间: \(London)")  //输出: 伦敦: 2017年09月19日星期二 下午 02:56
//(2)
var str = "Swift is a powerful and intuitive programming language for iOS, OS X, tvOS, and watchOS.";
let sIndex = str.index(str.startIndex, offsetBy:6)  //返回字符串从第6个字符到第20个字符的子串
let eIndex = str.index(str.startIndex, offsetBy:20)
let subString = str[sIndex...eIndex]
print("字符串从第6个字符到第20个字符的子串:",subString)
print("原字符串为：",str)
print("删除其中所有的OS字符",str.replacingOccurrences(of:"OS", with:""))

//(3)
let dict = ["date": ["Beijing": Beijing, "Tokyo": Tokyo, "NewYork": NewYork, "London":NewYork, "string": subString]] as AnyObject  //将字典转换为任意类型，便于后面写入文件
let defaultDoc = FileManager.default  //获取默认工作路径
//获取工作路径下的Document文件夹
if var path = defaultDoc.urls(for: .documentDirectory, in: .userDomainMask).first?.path{
    print("默认路径defaultDoc是：",path)
    path.append("/dict.txt")        //在文件夹路径下增加一个dict.txt
    print("写入是否成功：",dict.write(toFile: path, atomically: true))        //在dict.txt中将数据写入
}

//（4）
let image = try Data(contentsOf: URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1538987316279&di=2eeac879254c6380a44666a1b634cb29&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fpic%2Fitem%2F29a0a7efa8264f0ffdfa3cd9.jpg")!) // 通过指定的URL获取图片 然后将图片转换为二进制数据
if var url = defaultDoc.urls(for: .documentDirectory, in: .userDomainMask).first{
    url.appendPathComponent("image.png")
    try image.write(to: url)
}

//（5）
let urlWeather = URL(string: "http://www.weather.com.cn/data/sk/101270102.html")!  //成都龙泉驿的天气API路径
let weatherData = try Data(contentsOf: urlWeather)         //将json数据转换为二进制数据
let jsonDate = try JSONSerialization.jsonObject(with: weatherData, options: .allowFragments)    //序列化转换为二进制后的json数据
//解析jsonhs数据
if let dict = jsonDate as? [String: Any]{
    if let weather = dict["weatherinfo"] as? [String: Any]{
        let city = weather["city"]!
        let temp = weather["temp"]!
        let wd   = weather["WD"]!
        let ws   = weather["WS"]!
        print("城市：\(city)， 温度：\(temp)， 风向：\(wd)，风力：\(ws)")
    }
}

