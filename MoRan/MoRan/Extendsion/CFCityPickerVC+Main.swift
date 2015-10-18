//
//  CFCityPickerVC+Main.swift
//  CFCityPickerVC
//
//  Created by 冯成林 on 15/7/30.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation
import UIKit


extension CFCityPickerVC {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.hotCities = ["北京","上海","广州","成都","杭州","重庆"]
        
        
        //解析字典数据
        let cityModels = cityModelsPrepare()
        self.cityModels = cityModels
        
        
        //选中了城市
        self.selectedCityModel = { (cityModel: CFCityPickerVC.CityModel) in
            
            
            print("您选中了城市： \(cityModel.name)")
            
        }
        
        
        /** 返回按钮 */
        dismissBtnPrepare()
        
        /** 为tableView准备 */
        tableViewPrepare()
        
        /** 处理label */
        labelPrepare()
        
        self.tableView.sectionIndexColor = CFCityPickerVC.cityPVCTintColor
        
        /** headerView */
        headerviewPrepare()
        
        /** 定位处理 */
        locationPrepare()
        
        //通知处理
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notiAction:", name: CityChoosedNoti, object: nil)
    }
    
    /** 返回按钮 */
    func dismissBtnPrepare(){
        
        dismissBtn.setImage(UIImage(named: "img.bundle/cancel"), forState: UIControlState.Normal)
        dismissBtn.addTarget(self, action: "dismiss", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: dismissBtn)
    }
    
    func dismiss(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /** 解析字典数据，由于swift中字典转模型工具不完善，这里先手动处理 */
    func cityModelsPrepare() -> [CFCityPickerVC.CityModel]{
        
        //加载plist，你也可以加载网络数据
        let plistUrl = NSBundle.mainBundle().URLForResource("City", withExtension: "plist")!
        let cityArray = NSArray(contentsOfURL: plistUrl) as! [NSDictionary]
        
        var cityModels: [CFCityPickerVC.CityModel] = []
        
        for dict in cityArray{
            let cityModel = parse(dict)
            cityModels.append(cityModel)
        }
        
        return cityModels
    }
    
    func parse(dict: NSDictionary) -> CFCityPickerVC.CityModel{
        
        let id = dict["id"] as! Int
        let pid = dict["pid"] as! Int
        let name = dict["name"] as! String
        let spell = dict["spell"] as! String
        
        let cityModel = CFCityPickerVC.CityModel(id: id, pid: pid, name: name, spell: spell)
        
        let children = dict["children"]
        
        if children != nil { //有子级
            
            var childrenArr: [CFCityPickerVC.CityModel] = []
            for childDict in children as! NSArray {
                
                let childrencityModel = parse(childDict as! NSDictionary)
                
                childrenArr.append(childrencityModel)
            }
            
            cityModel.children = childrenArr
        }
        
        
        return cityModel
    }

}