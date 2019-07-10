//
//  AppDelegate.swift
//  temp1
//
//  Created by Rohlf W on 2019/3/1.
//  Copyright © 2019 Rohlf W. All rights reserved.
//


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    //ar_ViewController
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let sb=UIStoryboard(name: "Main", bundle: nil)
        let vc=sb.instantiateViewController(withIdentifier: "Launch_iden") as! UITabBarController
        vc.selectedIndex=1
        let homeVC = vc
        let nav = vc
        if UserDefaults.standard.string(forKey: "tag") != "0"&&UserDefaults.standard.string(forKey: "tag") != nil{
          window?.rootViewController = nav
        }
        else{
        window?.rootViewController = LaunchAnimationController()
        }
       
        window?.makeKeyAndVisible()
        launchExample01(homeVC)
        //launchExample04(homeVC)
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type == "com.rf.pics"{
            let storyBorad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initViewController  = storyBorad.instantiateViewController(withIdentifier: "pothotran") as! PictranVC
            initViewController.tag=2
            self.window?.rootViewController = initViewController
            self.window?.makeKeyAndVisible()
        }
        if shortcutItem.type == "com.rf.text"{
            let storyBorad : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let initViewController  = storyBorad.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
            initViewController.tag=2
            self.window?.rootViewController = initViewController
            self.window?.makeKeyAndVisible()
        }
    }
    
    
}







//首页 广告


extension AppDelegate {
    
    /// 本地图片
    func launchExample01(_ homeVC: UIViewController) {
        let adView = ZLaunchAd.create(showEnterForeground: true)
        let imageResource = ZLaunchAdImageResourceConfigure()
        imageResource.imageNameOrImageURL = "首页"
        imageResource.imageDuration = 3
        imageResource.imageFrame = UIScreen.main.bounds
        adView.setImageResource(imageResource, action: {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.yellow
            homeVC.navigationController?.pushViewController(vc, animated: true)
        })
    }
    /// 加载网络图片
    func launchExample02(_ homeVC: UIViewController) {
        let adView = ZLaunchAd.create(waitTime: 5)
        request { model in
            let buttonConfig = ZLaunchSkipButtonConfig()
            buttonConfig.skipBtnType = model.skipBtnType
            let imageResource = ZLaunchAdImageResourceConfigure()
            imageResource.imageNameOrImageURL = model.imgUrl
            imageResource.animationType = model.animationType
            imageResource.imageDuration = model.duration
            imageResource.imageFrame = CGRect(x: 0, y: 0, width: Z_SCREEN_WIDTH, height: Z_SCREEN_WIDTH*model.height/model.width)
            /// 设置图片、跳过按钮
            adView.setImageResource(imageResource, buttonConfig: buttonConfig, action: {
                let vc = UIViewController()
                vc.view.backgroundColor = UIColor.yellow
                homeVC.navigationController?.pushViewController(vc, animated: true)
            })
        }
    }
    
    /// 自定义通知控制启动页广告出现
    /// 如果通知控制显示不同的广告图片，网络请求需要写在`adNetRequest`闭包中
    /// 如果显示的是同一张图片，网络请求不需要写在闭包中，避免重复请求
    func launchExample03(_ homeVC: UIViewController) {
        ZLaunchAd.create(customNotificationName: "myNotification") { (adView) in
            self.request { model in
                let buttonConfig = ZLaunchSkipButtonConfig()
                buttonConfig.skipBtnType = model.skipBtnType
                let imageResource = ZLaunchAdImageResourceConfigure()
                imageResource.imageNameOrImageURL = model.imgUrl
                imageResource.animationType = model.animationType
                imageResource.imageDuration = model.duration
                imageResource.imageFrame = CGRect(x: 0, y: 0, width: Z_SCREEN_WIDTH, height: Z_SCREEN_WIDTH*model.height/model.width)
                
                adView.setImageResource(imageResource, buttonConfig: buttonConfig, action: {
                    let vc = UIViewController()
                    vc.view.backgroundColor = UIColor.yellow
                    homeVC.navigationController?.pushViewController(vc, animated: true)
                })
            }
        }
    }
    
    /// 进入前台时显示
    /// `showEnterForeground`需要设置为`true`，`timeForWillEnterForeground`为app进入后台到再次进入前台的时间
    /// 如果进入前台时加载不同的广告图片，网络请求需要写在`adNetRequest`闭包中
    /// 如果显示的是同一张图片，网络请求不需要写在闭包中，避免重复请求
    func launchExample04(_ homeVC: UIViewController) {
        ZLaunchAd.create(showEnterForeground: true, timeForWillEnterForeground: 10, adNetRequest: { adView in
            self.request { model in
                let buttonConfig = ZLaunchSkipButtonConfig()
                buttonConfig.skipBtnType = model.skipBtnType
                let imageResource = ZLaunchAdImageResourceConfigure()
                imageResource.imageNameOrImageURL = model.imgUrl
                imageResource.animationType = model.animationType
                imageResource.imageDuration = model.duration
                imageResource.imageFrame = CGRect(x: 0, y: 0, width: Z_SCREEN_WIDTH, height: Z_SCREEN_HEIGHT-75)
                
                adView.setImageResource(imageResource, buttonConfig: buttonConfig, action: {
                    let vc = UIViewController()
                    vc.view.backgroundColor = UIColor.red
                    homeVC.navigationController?.pushViewController(vc, animated: true)
                })
            }
        }).endOfCountDown {
            printLog("倒计时结束了-----")
        }
    }
}

//MARK: - 模拟请求数据，此处解析json文件
extension AppDelegate {
    func request(_ completion: @escaping (AdModel)->()) -> Void {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            if let path = Bundle.main.path(forResource: "data", ofType: "json") {
                let url = URL(fileURLWithPath: path)
                do {
                    let data = try Data(contentsOf: url)
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let dict = json as? [String: Any],
                        let dataArray = dict["data"] as? [[String: Any]] {
                        /// 随机显示
                        let idx = Int(arc4random()) % dataArray.count
                        let model = AdModel(dataArray[idx])
                        completion(model)
                    }
                } catch  {
                    print(error)
                }
            }
        }
    }
}
