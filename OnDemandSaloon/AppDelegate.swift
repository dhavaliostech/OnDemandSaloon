//
//  AppDelegate.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 29/05/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GooglePlaces
import Braintree

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let userDefaults = UserDefaults.standard
    
    var isLogin = false
    
    var userLogin = false

    var serviceProviderLogin = false
    
    var introFlag = false
    
    var rateLogin = false
    
    let userDefault = UserDefaults.standard
    
    var service = ""
    var price = ""
    var time = ""
    var tabbarController = ManageLoginTabBarController()

    var changeStoryBoard = false
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        IQKeyboardManager.shared.enable = true
 
       GMSPlacesClient.provideAPIKey("AIzaSyD2_aGJlbUbwV_7E7sXojEsTaFJFjpZwo0")
        let myText = "\""
        print("the result " + myText)
    
        BTAppSwitch.setReturnURLScheme("mac-pro.OnDemand.payment")
        
        
    if let lastLogin = userDefaults.value(forKey: "lastLogin") as? String{
        
        print(lastLogin)

            if  lastLogin == "user"{
            
                let storyboard = UIStoryboard(name: "User", bundle: nil)
                let objVC = storyboard.instantiateViewController(withIdentifier: "UserTabBar") as! UserTabBarController
                (self.window?.rootViewController as? UINavigationController)?.pushViewController(objVC, animated: false)
                userDefaults.set(false, forKey: "serviceProviderLogin")
                 userDefaults.set(true, forKey: "userLogin")
                userDefaults.synchronize()
                //serviceProviderLogin
            }
            else if lastLogin == "provider"{

                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let objVC = storyboard.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
                (self.window?.rootViewController as? UINavigationController)?.pushViewController(objVC, animated: false)
                userDefaults.set(false, forKey: "userLogin")
                userDefaults.set(true, forKey: "serviceProviderLogin")
                userDefaults.synchronize()
                //userLogin
            }else {
//                self.userDefaults.set(false, forKey: "userLogin")
//                self.userDefaults.set(false, forKey: "serviceProviderLogin")
                self.userDefaults.synchronize()
                
        }
    }else {
        
//        self.userDefaults.set(false, forKey: "userLogin")
//        self.userDefaults.set(false, forKey: "serviceProviderLogin")
        self.userDefaults.synchronize()
    
    }
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if  url.scheme?.localizedCaseInsensitiveCompare("mac-pro.OnDemand.payment") == .orderedSame{
            return BTAppSwitch.handleOpen(url, options: options)
        }
        return false
        
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


}

