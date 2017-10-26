//
//  ViewController.swift
//  MyBackup
//
//  Created by 王偉 on 18/10/2017.
//  Copyright © 2017 王偉. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
override func viewDidLoad() {
        super.viewDidLoad()
    
   let mybackUp =  MyBackupService()
    mybackUp.processJsonConfigs()
    mybackUp.doBackup()
}

class JsonManager{

    
    func getJsonObject(fileName:String)->Any?{
            
        do {
            if let file = Bundle.main.url(forResource:fileName, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
               
                return json;
            }
            
        } catch {
            print(error.localizedDescription)

        }
        
        return nil
    }

    
    func processJsonConfig(){
        
    }
}
    
    
struct MyBackupService {
        
        private var managers:NSMutableArray = []
    
        init(){
            self.managers.add(ConfigManager());
            self.managers.add(ScheduleManager());
        }
    
    
        func doBackup(){
            
       
            
        }
        
        func processJsonConfigs(){
            
            for manager in managers {
                
                let jsonManger:JsonManager = manager as! JsonManager
                jsonManger.processJsonConfig()
            }
            
        }
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
    
    class ConfigManager:JsonManager{
        
        let configUrl:String = "http://www.mocky.io/v2/59e6d2c00f00007704ee97b6"
        let fileName:String = "config"
        
        private var configs:Array<Config> = []
        private var count:Int = 0
        
            override func processJsonConfig(){
        
            
                if let json:NSDictionary  = self.getJsonObject(fileName:fileName) as? NSDictionary{
                
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
                
                    self.configs = arry as! Array<ViewController.Config>
                    self.count = self.configs.count
                }
                
            }
    }

    struct Schedule {
        
        let ext:String
        let time:String
        let interval:String
    }
    
    class ScheduleManager:JsonManager{

        let scheduleUrl:String = "http://www.mocky.io/v2/59e6e7550f00005305ee97e6"
        let fileName:String = "schedules"
        private var schedules:Array<Schedule> = []
        private var count:Int = 0

            override func processJsonConfig(){

                if let json:NSDictionary  = self.getJsonObject(fileName:fileName) as? NSDictionary{
                    
                    let jsonArray:Array<NSDictionary> = json["schedules"] as! Array<NSDictionary>
                    let arry:NSMutableArray = NSMutableArray()

                    for jsonData in jsonArray {


                        let schedule = Schedule(ext: jsonData["ext"] as! String,
                                              time: jsonData["time"] as! String,
                                              interval: jsonData["interval"] as! String)
                        arry.add(schedule)

                    }

                    self.schedules = arry as! Array<ViewController.Schedule>
                    self.count = self.schedules.count
                }
            }

    }

}
