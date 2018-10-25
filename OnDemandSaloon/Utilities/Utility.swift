//
//  Utility.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 29/05/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import KRProgressHUD

let txtBlueColor = UIColor(red: 0.0/255.0, green: 102.0/255.0, blue: 176.0/255.0, alpha: 1.0)
let login = "login.php"
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let userDefaults = UserDefaults.standard
var timer = Timer()
let date = Date()
let window = UIApplication.shared.keyWindow!

let currentLocation = CLLocationManager()

//Static Arrays
let nameArray : [String] = ["Laura","Sana","Taylor "]
let lastArray : [String] = ["Michelle","Khan","Swift"]
let dateArray : [String] = ["12/8/2018","21/8/2018","30/8/2018"]
let numberArray : [String] = ["23476072346","7235478101","8725347519"]
var cityName: [String] = ["Abu Dhabi","Dubai","Jabel Ali"]

let areaArray : [String] = ["Ferrari World Abu Dhabi","jumerah","Yas Island","Yas Marina Circuit","Aldar Headquarters building"]
let timeArray : [String] = ["2:00PM","12:00PM","10:00AM"]
let emailArray: [String] = ["lauramichelle@gmail.com","sana@outlook.com","taylor1996@yahoo.com"]
let birthArray:[String] = ["12/12/1995","7/7/1985","4/7/1995"]

class Utility: NSObject {

    class func showAlert(vc: UIViewController, strMessage: String,alerttitle:String) {
        let alert = UIAlertController(style: .alert,title: alerttitle, message: strMessage)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        //vc.present(alert, animated: true, completion: nil)
        alert.show()
    }
    
    class func errorAlert(vc: UIViewController, strMessage: String,errortitle:String) {
        let alert = UIAlertController(style: .alert,title: errortitle, message: strMessage)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        //vc.present(alert, animated: true, completion: nil)
        alert.show()
        
    }
    
    func errorForInternet(vc: UIViewController, strMessage: String,errortitle:String){
        let alert = UIAlertController(style: .alert,title: errortitle, message: strMessage)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        //vc.present(alert, animated: true, completion: nil)
        alert.show()
        KRProgressHUD.dismiss()
    }
    
    class func sendClassFileToChild(className:String){
        let storyboard = UIStoryboard(name: "Child", bundle: nil)
        let objVC = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        objVC.getParentController = className
    }
    
    
    class func generateInfoPopUp(parentController:UIViewController?,  isPopView: Bool,parentVc:String?,isLogin:Bool,isService:Bool)  {
        let popUpStoryboard = UIStoryboard(name: "Child", bundle: nil)
        let objGeneralPopupController = popUpStoryboard.instantiateViewController(withIdentifier: "ChildPopUpViewController") as! ChildPopUpViewController
        parentController?.addChildViewController(objGeneralPopupController)
        parentController?.view.addSubview(objGeneralPopupController.view)
        objGeneralPopupController.isPop = isPopView
        objGeneralPopupController.getUserLogin = isLogin
        objGeneralPopupController.getServiceFlag = isService
        objGeneralPopupController.parentVC = parentVc!
        objGeneralPopupController.view.frame = (parentController?.view.frame)!
        parentController?.navigationController?.didMove(toParentViewController: objGeneralPopupController)
    }
 
    class func modifiedTabBar(tabBarController:UITabBarController){
        
        
        let storyBoard = UIStoryboard.init(name: "User", bundle:nil )
        let signInStoryBoard = UIStoryboard.init(name: "Child", bundle:nil )
        
        
        
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "UserHomeViewController") as! UserHomeViewController
        let searchVC =  storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let signIn = signInStoryBoard.instantiateViewController(withIdentifier: "ChildPopUpViewController") as! ChildPopUpViewController
        
        
        let navHomeVc = UINavigationController(rootViewController: homeVC)
        let navsearchVC = UINavigationController(rootViewController: searchVC)
        let navsignIn = UINavigationController(rootViewController: signIn)
        
        navHomeVc.isNavigationBarHidden = true
        navsearchVC.isNavigationBarHidden = true
        navsignIn.isNavigationBarHidden = true

        tabBarController.viewControllers = []
        tabBarController.tabBar.isTranslucent = false
        
        
        
        tabBarController.viewControllers = [navHomeVc,navsearchVC,navsignIn]
        tabBarController.selectedIndex = 0
        
        tabBarController.tabBar.items![0].image = #imageLiteral(resourceName: "userHome")
        tabBarController.tabBar.items![1].image = #imageLiteral(resourceName: "searchTab")
        tabBarController.tabBar.items![2].image = #imageLiteral(resourceName: "login")
        
        tabBarController.tabBar.barTintColor = UIColor.white
        
        //tabBarController.tabBar.tintColor = UIColor.blue
        
        tabBarController.tabBar.itemPositioning = .automatic
        
        tabBarController.tabBar.itemSpacing = 2.0
        
        tabBarController.tabBarItem.title = nil
        if let items = tabBarController.tabBar.items {
            for item in items {
                item.title = ""
                if item.image == #imageLiteral(resourceName: "userHome"){
                    item.title = "Home"
                }else if item.image == #imageLiteral(resourceName: "searchTab"){
                    item.title = "Search"
                }else if item.image == #imageLiteral(resourceName: "accounts"){
                    item.title = "Login"
                }
                
                item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
            }
        }
   
    }

    class func showTabBArWhenComming(isShow:Bool,tabbarController:UITabBarController){
        if isShow == true{
            tabbarController.tabBar.isHidden = false
        }else{
            tabbarController.tabBar.isHidden = true

        }
    }
    
    class func manageSideMenu( boolValue:Bool, childController:UIViewController)->Bool{
        
        let controller :SideMenuViewController!
        
        if !boolValue {
            //boolValue = true
            UIView.animate(withDuration: 0.3)
            {
              
                
                if UIDevice.current.userInterfaceIdiom == .pad {
                    childController.view.frame = CGRect(x:  0, y: 64, width: childController.view.frame.size.width/2 - 40, height: childController.view.frame.size.height)
                }
                else {
                    childController.view.frame = CGRect(x: 0  , y: 0, width: (childController.view.frame.size.width - 60), height: childController.view.frame.size.height)
                    
                }
                
                //                self.objectProfile.view.addSubview(self.backgroundView)
            }
            return true
        }
        else {
            //boolValue = false
            UIView.animate(withDuration: 0.3, animations: {
                
                if UIDevice.current.userInterfaceIdiom == .pad {
                    childController.view.frame = CGRect(x:  -(childController.view.frame.size.width/2   - 40), y: 64, width: childController.view.frame.size.width/2 - 40, height: childController.view.frame.size.height)
                }
                else {
                    childController.view.frame = CGRect(x:  -(childController.view.frame.size.width - 40) , y: 0, width: (childController.view.frame.size.width - 60), height: childController.view.frame.size.height)
                }
                
                
                
            }, completion: { (completeAnimation) in
                childController.view.isHidden = true
            })
            return false
        }
    }
    
    class func storeUserFlag(flag:Bool){
        userDefaults.set(flag, forKey: "userLogin")
        userDefaults.set("user", forKey: "lastLogin")
        userDefaults.set(true, forKey: "introFlag")
        userDefaults.synchronize()
    }
    
    class func storeServiceFlag(flag:Bool){
        userDefaults.set(flag, forKey: "serviceProviderLogin")
        userDefaults.set("provider", forKey: "lastLogin")
        userDefaults.set(true, forKey: "introFlag")
        userDefaults.synchronize()
    }
    
    class func chnageBtnTitle(btn:UIButton?){
    
        if let getUserLogin = userDefaults.value(forKey: "pro_id") as? String{
            
                btn?.setTitle("Business Service", for: UIControlState.normal)
            
        }
    }
    
   
    
   class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    
    
    class func customDateFormatter(date: String?,fromDateFormat:String,toDateFormat:String)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "\(fromDateFormat)"
        let getdate = dateFormatter.date(from: date!)
        dateFormatter.dateFormat = "\(toDateFormat)"
        
//        if getdate == nil{
//            return ""
//        }
        return  "\(dateFormatter.string(from: getdate!))"
    }
    
    class func convertDateFormater(_ date: String,dateFormat:String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "\(dateFormat)"
        
        print(dateFormatter.string(from: date!))
        
        return  dateFormatter.string(from: date!)
        
    }
    
    class func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss z"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "h:mm a"
        
        print(dateFormatter.string(from: date!))
        
        return  dateFormatter.string(from: date!)
    }
    
    class func setBoarderAndColorOfView(getview:UIView){
        getview.layer.borderWidth = 1
        getview.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
    }
    
    class func setTexField(txtField:UITextField,placeHolderName:String?){
        txtField.attributedPlaceholder = NSAttributedString(string: placeHolderName!, attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)])
    }  
    
}

extension UINavigationController {
    
    func backToViewController(viewController: Any) {
        // iterate to find the type of vc
        for element in viewControllers as Array {
            if "\(type(of: element)).Type" == "\(type(of: viewController))" {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
    
    
    
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[kCTForegroundColorAttributeName as NSAttributedStringKey: newValue!])
        }
    }
}

extension String {
    
    func daywidthlable(constraintedWidth height: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: .greatestFiniteMagnitude, height: height))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.width
    }
    
}


//func AlertSingle(title:String)
//{
//    let alert = UIAlertController(style: .alert, title: "On Demand Saloon", message: title)
//    alert.addAction(title: "Ok", style: .default)
//    //alert.addAction(title: "Cancel", style: .cancel)
//    //alert.addAction(title: "Destructive", style: .destructive)
//    alert.show()
//}


