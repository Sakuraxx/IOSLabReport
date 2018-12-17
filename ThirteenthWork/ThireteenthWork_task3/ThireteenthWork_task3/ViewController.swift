//
//  ViewController.swift
//  ThireteenthWork_task3
//
//  Created by sakura on 2018/12/17.
//  Copyright © 2018年 2016110342. All rights reserved.
//
/*
 (3)使用网络库进行天气Json数据的解析
 a)APP有两个界面，第一个界面：tableview显示一个城市列表
 b)第二个界面，显示选择城市的天气数据
 c)使用第三方网络Alamofire进行网络的连接，获取网络天气数据；
 d)对获取到的网络数据进行Json的解析；
 */

import UIKit
//要先运行一下工程编译一下才可以导入
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    let citise = ["北京": 101010100, "上海": 101020100, "天津": 101030100, "重庆": 101040100, "哈尔滨": 101050101, "长春": 101060101, "沈阳": 101070101, "呼和浩特": 101080101, "石家庄": 101090101, "太原": 101100101, "西安": 101110101, "济南": 101120101, "乌鲁木齐": 101130101, "拉萨": 101140101, "西宁": 101150101, "兰州": 101160101, "银川": 101170101, "郑州": 101180101, "南京": 101190101, "武汉": 101200101, "杭州": 101210101, "合肥": 101220101, "福州": 101230101, "南昌": 101240101, "长沙": 101250101, "贵阳": 101260101, "成都": 101270101, "广州": 101280101, "昆明": 101290101, "南宁": 101300101, "海口": 101310101, "香港": 101320101, "澳门": 101330101, "台北县": 101340101]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.white
        self.title = "城市天气"
        
        tableView = UITableView(frame: self.view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let city = "\(citise[Array(citise.keys)[indexPath.row]]!)"
        let site = "http://www.weather.com.cn/data/sk/" + city + ".html"
      //  let city="成都"
       // let site = "https://www.sojson.com/open/api/weather/json.shtml?city="+city
        let url = URL(string: site)
        Alamofire.request(url!).responseJSON { (response) in
            if let json = try? JSON(data: response.data!) {
                let dict = json["weatherinfo"]
                let city = dict["city"].string!
                let temp = dict["temp"].string!
                let wd = dict["WD"].string!
                let ws = dict["WS"].string!
                var weather = "温度: \(temp)\n"
                weather += "风向: \(wd)\n"
                weather += "风力: \(ws)"
                
                let viewController = WeatherViewController()
                viewController.navTitle = city
                viewController.weather = weather
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citise.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
            cell?.accessoryType = .disclosureIndicator
        }
        
        cell?.textLabel?.text = Array(citise.keys)[indexPath.row]
        
        return cell!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

