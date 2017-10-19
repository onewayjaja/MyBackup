//
//  ViewController.swift
//  MyBackup
//
//  Created by 王偉 on 18/10/2017.
//  Copyright © 2017 王偉. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let scheduleUrl:String = "http://www.mocky.io/v2/59e6e7550f00005305ee97e6"

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configManager = ConfigManager()
        configManager.processConfigs(manager: configManager)
        
        let scheduleManager = ScheduleManager()
        scheduleManager.processSchedules(manager: scheduleManager)

        
        
    }
    
    struct Config {
        
        let ext:String
        let location:String
        let subDirectory:Bool
        let unit:String
        let remove:Bool
        let handler:String
        let destination:String
        let dir:String
        let connectionString:String
    }
    
    struct ConfigManager  {
        
        let configUrl:String = "http://www.mocky.io/v2/59e6d2c00f00007704ee97b6"
        
        var configs:Array<Config> = []
        var count:Int = 0
        
        func processConfigs(manager:ConfigManager){
            
            var manager = manager
            
            let requestUrl = URL(string:configUrl)
            let request = URLRequest(url:requestUrl!)
            let task = URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                if error == nil {
                
                    let json:NSDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    let jsonArray:Array<NSDictionary> = json["config"] as! Array<NSDictionary>
                    
                    let arry:NSMutableArray = NSMutableArray()
                    
                    for jsonData in jsonArray {
                        

                        let config = Config(ext: jsonData["ext"] as! String,
                                            location: jsonData["location"] as! String,
                                            subDirectory: jsonData["subDirectory"] as! Bool,
                                            unit: jsonData["unit"] as! String,
                                            remove: jsonData["remove"] as! Bool,
                                            handler: jsonData["handler"] as! String,
                                            destination: jsonData["destination"] as! String,
                                            dir: jsonData["dir"] as! String,
                                            connectionString: jsonData["connectionString"] as! String)
                        arry.add(config)
                        
                    }
                    
                    manager.configs = arry as! Array<ViewController.Config>
                    manager.count = manager.configs.count
                    
                }
            }

            task.resume()
        }
        
    }
    
    struct Schedule {
        
        let ext:String
        let time:String
        let interval:String
    }
    
    struct ScheduleManager  {
        
        let scheduleUrl:String = "http://www.mocky.io/v2/59e6e7550f00005305ee97e6"
        
        var schedules:Array<Schedule> = []
        var count:Int = 0
        
        func processSchedules(manager:ScheduleManager){
            
            var manager = manager
            
            let requestUrl = URL(string:scheduleUrl)
            let request = URLRequest(url:requestUrl!)
            let task = URLSession.shared.dataTask(with: request) {
                (data, response, error) in
                if error == nil {
                    
                    let json:NSDictionary = try! JSONSerialization.jsonObject(with: data!, options: []) as! NSDictionary
                    let jsonArray:Array<NSDictionary> = json["schedules"] as! Array<NSDictionary>
                    
                    let arry:NSMutableArray = NSMutableArray()
                    
                    for jsonData in jsonArray {
                        
                        
                        let schedule = Schedule(ext: jsonData["ext"] as! String,
                                              time: jsonData["time"] as! String,
                                              interval: jsonData["interval"] as! String)
                        arry.add(schedule)
                        
                    }
                    
                    manager.schedules = arry as! Array<ViewController.Schedule>
                    manager.count = manager.schedules.count
                    
                    print(manager.schedules)
                }
            }
            
            task.resume()
        }
        
    }

}

