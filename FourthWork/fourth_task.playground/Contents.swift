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
import UIKit
func getDate(date : Date,zone : Int = 0)-> String {
    let dateformat = DateFormatter()    //格式化类
    dateformat.dateFormat = "yyyy年MM月dd日EEEE aa KK:mm"      //指定格式
    dateformat.locale = Locale.current          //根据当前环境设置显示时间
    if zone >= 0 {
        dateformat.timeZone = TimeZone(abbreviation: "UTC+\(zone):00")
    } else {
        dateformat.timeZone = TimeZone(abbreviation: "UTC\(zone):00")
    }
    let dateFromString = dateformat.string(from: date)
    return  dateFromString
}

//(1)
let now = Date()  //获取当前时间日期
let Beijing = getDate(date: now, zone: +8)  //获取当前北京的时间
print("北京: \(Beijing)")

let Tokyo = getDate(date: now, zone: 9)  //获取当前东京的时间
print("东京: \(Tokyo)")

let NewYork = getDate(date: now, zone: -5)  //获取当前纽约的时间
print("纽约: \(Tokyo)")

let London = getDate(date: now)  //获取当前伦敦的时间
print("伦敦: \(London)")

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









