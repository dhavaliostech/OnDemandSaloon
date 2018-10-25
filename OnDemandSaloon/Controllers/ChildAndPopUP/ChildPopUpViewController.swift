//
//  ChildPopUpViewController.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 25/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD

class ChildPopUpViewController: UIViewController,UITextFieldDelegate {

    var parentVC = ""
    var getController = UIViewController()
    var isPop:Bool = false
    var getUserLogin:Bool!
    var getServiceFlag :Bool!
    var serviceParent : ServiceViewController!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var popUpview: UIView!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    //userDefaults variables
    var userLogin :Bool!
    var providerLogin :Bool!
    
    
    let window = UIApplication.shared.keyWindow
    let tabbarController = ManageLoginTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(parentVC)
        if isPop{
            getController = (parent?.navigationController?.getVC(viewController: parentVC))!

        }
        print(getController)
       
        self.popUpview.layer.cornerRadius = 5
        
        Utility.setBoarderAndColorOfView(getview: self.emailView)
        Utility.setBoarderAndColorOfView(getview: self.passwordView)
        
        self.emailView.layer.cornerRadius = 5
        self.passwordView.layer.cornerRadius = 5
        
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if let getLogIN = userDefaults.value(forKey: "userLogin") as? Bool{
            self.userLogin = getLogIN
        }
        
        if let grtlogin = userDefaults.value(forKey: "serviceProviderLogin") as? Bool{
            self.providerLogin = grtlogin
        }
        
        print("service \(providerLogin)")
        print("user \(userLogin)")
        print("get from popup service \(getServiceFlag)")
        print("get from popup user \(getUserLogin)")
        
    }
    @IBAction func closeActiion(_ sender: UIButton) {
        if isPop {
            self.parent?.navigationController?.backToViewController(viewController: getController.self)
            
        }
        
        if getUserLogin == true{
            getUserLogin = false
        }
        
        if getServiceFlag == true{
            getServiceFlag = false
        }
        
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    @IBAction func forgotPassAction(_ sender: UIButton) {

        let sBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
        let gotoUserVc = sBoard.instantiateViewController(withIdentifier: "ForgotPasswordVc") as! ForgotPasswordVc
        
        if getUserLogin{
            gotoUserVc.isUser = true
        }else{
            gotoUserVc.isUser = false
        }
        
        
        navigationController?.pushViewController(gotoUserVc, animated: false)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtPassword{
            if range.location < 4{
                return true
            }else{
                return false
            }
        }
        
        return true
    }
    
    func loginAPI(){
        KRProgressHUD.show()
        
        var params = [String:Any]()
        
        if getUserLogin{
            params = ["user_email":txtEmail.text!, "user_password":txtPassword.text!, "role":"2","device_token":"ahvblkjbflj","device_type":"2"]
        }else{
            params = ["user_email":txtEmail.text!, "user_password":txtPassword.text!, "role":"1","device_token":"business_token","device_type":"2"]
        }
        
        UserManager.shared.login(parametrs: params ) { (success,message,response)  in
            
            if success == true{
               
                //sriRam123@gmail.com
                
                //self.navwigateAction()
                let responseData = response
                if let getServiceType = responseData["service_pro_reg_status"] as? String{
                    
                    if getServiceType == "1"{
                        
                        let sBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
                        let vc = sBoard.instantiateViewController(withIdentifier: "Work_day_VC") as! Work_day_VC
                        
                        vc.loadViewIfNeeded()
                        self.tabBarController?.tabBar.isHidden = true
                        vc.hidesBottomBarWhenPushed = true
                        appDelegate.changeStoryBoard = true
                        vc.loadViewIfNeeded()
                        self.navigationController?.pushViewController(vc, animated: true)
                        KRProgressHUD.dismiss()
                        return
                        
                    }else if getServiceType == "2"{
                        
                        let sBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
                        let vc = sBoard.instantiateViewController(withIdentifier: "AddServicesCategoryVC") as! AddServicesCategoryVC
                        
                        vc.loadViewIfNeeded()
                        self.tabBarController?.tabBar.isHidden = true
                        vc.hidesBottomBarWhenPushed = true
                        appDelegate.changeStoryBoard = true
                        vc.loadViewIfNeeded()
                        self.navigationController?.pushViewController(vc, animated: true)
                        KRProgressHUD.dismiss()
                        return
                        
                    }else if getServiceType == "3"{
                        let sBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
                        let vc = sBoard.instantiateViewController(withIdentifier: "Prices&ServicesViewController") as! Prices_ServicesViewController
                        
                        vc.loadViewIfNeeded()
                        self.tabBarController?.tabBar.isHidden = true
                        vc.hidesBottomBarWhenPushed = true
                        appDelegate.changeStoryBoard = true
                        vc.loadViewIfNeeded()
                        self.navigationController?.pushViewController(vc, animated: true)
                        KRProgressHUD.dismiss()
                        return
                        
                    }else if getServiceType == "4"{
                        //SubscriptionViewController
                        
                        let sBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
                        let vc = sBoard.instantiateViewController(withIdentifier: "SubscriptionViewController") as! SubscriptionViewController
                        vc.loadViewIfNeeded()
                        self.tabBarController?.tabBar.isHidden = true
                        vc.hidesBottomBarWhenPushed = true
                        appDelegate.changeStoryBoard = true
                        vc.loadViewIfNeeded()
                        self.navigationController?.pushViewController(vc, animated: true)
                        KRProgressHUD.dismiss()
                        return
                    }
                    
                }
                KRProgressHUD.dismiss()
                self.navigateAction()
                
            }
            else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message)", errortitle: "Authentication Error")
                })
                
            }
        }
        
    }
    
    
    @IBAction func signInAction(_ sender: UIButton) {
 
        guard txtEmail.text! != "" else {
            Utility.showAlert(vc: self, strMessage: "Please enter your email address.", alerttitle: "")
            return
        }
        
        guard Utility.isValidEmail(testStr: txtEmail.text!) else {
             Utility.showAlert(vc: self, strMessage: "Please enter your email address properly.", alerttitle: "")
            return
        }
        
//        guard matchString(get: "\(txtEmail.text!)") else{
//            Utility.showAlert(vc: self, strMessage: "Please enter correct email.", alerttitle: "")
//            return
//        }
        
        guard txtPassword.text! != "" else {
            Utility.showAlert(vc: self, strMessage: "Please enter your password.", alerttitle: "")
            return
        }

//        guard  passMatchString(get: "\(txtPassword.text!)") else {
//             Utility.showAlert(vc: self, strMessage: "Please enter correct password.", alerttitle: "")
//            return
//        }
        
        //
        //navigateAction()
        loginAPI()
        
        
    }
    
    func matchString(get:String?)-> Bool{
        
        if getUserLogin == true{
            if "\(get!)" == "test1@gmail.com"{
                return true
            }else{
                return false
                
            }
        }else if getServiceFlag == true{
            if "\(get!)" == "test2@gmail.com"{
                return true
            }else{
                return false
                
            }
        }
        
        return false
    }
    
    func passMatchString(get:String?)-> Bool{
        
        if getUserLogin == true{
            if "\(get!)" == "test1"{
                return true
            }else{
                return false
                
            }
        }else if getServiceFlag == true{
            if "\(get!)" == "test2"{
                return true
            }else{
                return false
                
            }
        }
        
        return false
    }
    
    func navigateAction(){

        if isPop {
            self.parent?.navigationController?.backToViewController(viewController: getController.self)
            
        }else{
            self.parent?.navigationController?.backToViewController(viewController: getController.self)
            tabbarController.fromUserSigniN = true
        }
        
//        if let getFlag = UserDefaults.standard.value(forKey: "lastLogin") as? String{
//            if getFlag == "provider"{
//
//                if window?.rootViewController == self.tabbarController{
//                    window?.rootViewController = nil
//                }
//
//                Utility.storeServiceFlag(flag:true)
//                gotoServiceProvider()
//                appDelegate.serviceProviderLogin = true
//            }else {
//
//            }
//        }
        //        if getServiceFlag == true{
        //            if providerLogin == false{
        //                Utility.storeServiceFlag(flag:true)
        //
        //                self.gotoServiceProvider()
        //            }
        //        }
        //
        //        else if getUserLogin == true{
        //
        //            if userLogin == false{
        //                Utility.storeUserFlag(flag:true)
        //
        //                self.gotoUserStoryBoard()
        //
        //            }
        //        }
        
        if isPop == true{
            
            if getServiceFlag == true{
                if providerLogin == false{
                    
                    gotoServiceProvider()
                    
                }
            }
                
            else if getUserLogin == true{
                
                if userLogin == false{
                    
                    appDelegate.changeStoryBoard = true
                    
                    self.gotoUserStoryBoard()
                    appDelegate.userLogin = true
                    
                }
            }
            
        }else{
            if getUserLogin == true{
                
                if userLogin == false{
                    
                    //appDelegate.changeStoryBoard = true
                    
                    self.gotoUserStoryBoard()
                   // appDelegate.userLogin = true
                    
                }
            }
        }
    }
    
    func gotoUserStoryBoard(){
        
            let storyBoard = UIStoryboard.init(name: "User", bundle: nil)
            let gotoUserVc = storyBoard.instantiateViewController(withIdentifier: "UserTabBar") as! UserTabBarController
            appDelegate.changeStoryBoard = true
            Utility.storeUserFlag(flag:true)
           // gotoUserVc.loadViewIfNeeded()
//            gotoUserVc.loadViewIfNeeded()
            //gotoUserVc.hidesBottomBarWhenPushed = true
        
       if isPop{
        
            gotoUserVc.selectedIndex = 0
            appDelegate.userLogin = true
            self.parent?.navigationController?.pushViewController(gotoUserVc, animated: false)

       }else{
            gotoUserVc.hidesBottomBarWhenPushed = true
            appDelegate.changeStoryBoard = true
            gotoUserVc.loadViewIfNeeded()
            appDelegate.isLogin = true
            self.parent?.navigationController?.pushViewController(gotoUserVc, animated: false)
        }


    }
    
    func gotoServiceProvider(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let gotoUserVc = storyBoard.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
    
        gotoUserVc.hidesBottomBarWhenPushed = true
        gotoUserVc.loadViewIfNeeded()
        Utility.storeServiceFlag(flag:true)
        appDelegate.serviceProviderLogin = true
        appDelegate.changeStoryBoard = true
        navigationController?.pushViewController(gotoUserVc, animated: false)
    }
    
   
    @IBAction func createAccountAction(_ sender: UIButton) {
  
        if getServiceFlag == true{
            let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
            //tabBarController.hidesBottomBarWhenPushed = true
            //vc.hidesBottomBarWhenPushed = true
            //vc.loadViewIfNeeded()
            tabBarController?.tabBar.isHidden = true
            vc.hidesBottomBarWhenPushed = true
            appDelegate.changeStoryBoard = true
            vc.loadViewIfNeeded()
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
        else if getUserLogin == true{
            let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AppointmentBookingViewController") as! AppointmentBookingViewController

            tabBarController?.tabBar.isHidden = true
            appDelegate.changeStoryBoard = true
            
            self.parent?.navigationController?.pushViewController(vc, animated: false)
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UINavigationController {
        
    func getVC(viewController:String?) -> UIViewController {
        for element in viewControllers as Array {
            if "\(type(of: element)).Type" == "\(type(of: viewController))" {
                return element
                //self.popToViewController(element, animated: true)
                //break
            }
        }
        return UIViewController()
    }
    
}
