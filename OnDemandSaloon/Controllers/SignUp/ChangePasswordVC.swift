//
//  ChangePasswordVC.swift
//  demo1
//
//  Created by PS on 01/08/18.
//  Copyright © 2018 PS. All rights reserved.
//

import UIKit
import KRProgressHUD

class ChangePasswordVC: UIViewController {

    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtOldPassword: UITextField!
    @IBOutlet weak var btnChangePassword: UIButton!
    @IBOutlet weak var confirmPasswordbackView: UIView!
    @IBOutlet weak var oldPasswordBackView: UIView!
    @IBOutlet weak var newPasswordbackView: UIView!
    
    @IBOutlet weak var changeProviderBtn: UIButton!
    
    @IBOutlet weak var btnNormalUser: UIButton!
    var tabbarController = ManageLoginTabBarController()
    
    var profileObject :ProfileAdd!
    
    var isProvider :Bool!
    
    var tabbarcontroller = ManageLoginTabBarController()
    let window = UIApplication.shared.keyWindow
    
    override func viewDidLoad() {
        super.viewDidLoad()

        oldPasswordBackView.layer.borderWidth = 1
        oldPasswordBackView.layer.cornerRadius = 4
        oldPasswordBackView.clipsToBounds = true
        oldPasswordBackView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0,alpha: 1.0).cgColor
        
        newPasswordbackView.layer.borderWidth = 1
        newPasswordbackView.layer.cornerRadius = 4
        newPasswordbackView.clipsToBounds = true
        newPasswordbackView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0,alpha: 1.0).cgColor
        
        confirmPasswordbackView.layer.borderWidth = 1
        confirmPasswordbackView.layer.cornerRadius = 4
        confirmPasswordbackView.clipsToBounds = true
        confirmPasswordbackView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0,alpha: 1.0).cgColor
        changeProviderBtn.layer.cornerRadius = changeProviderBtn.frame.size.height / 2
        changeProviderBtn.layer.borderWidth = 1
        changeProviderBtn.layer.borderColor = UIColor.white.cgColor
        
        btnNormalUser.layer.cornerRadius = changeProviderBtn.frame.size.height / 2
        btnNormalUser.layer.borderWidth = 1
        btnNormalUser.layer.borderColor = UIColor.white.cgColor
        
        self.btnNormalUser.isHidden = true
        self.changeProviderBtn.isHidden = true
        
        self.btnNormalUser.layer.borderWidth = 1
        self.changeProviderBtn.layer.borderWidth = 1
        
        self.btnNormalUser.layer.cornerRadius = self.btnNormalUser.frame.size.height / 2
        self.changeProviderBtn.layer.cornerRadius = self.changeProviderBtn.frame.size.height / 2
        
        self.btnNormalUser.layer.borderColor = UIColor.white.cgColor
        self.changeProviderBtn.layer.borderColor = UIColor.white.cgColor
        
        self.changeProviderBtn.isHidden = true
        self.btnNormalUser.isHidden = true
        
        self.btnNormalUser.addTarget(self, action: #selector(btnUserAction(_:)), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if isProvider == false{
            self.btnNormalUser.isHidden = true
            self.changeProviderBtn.isHidden = false
            Utility.chnageBtnTitle(btn: changeProviderBtn)
        }else{
            self.changeProviderBtn.isHidden = true
            self.btnNormalUser.isHidden = false

        }
        tabBarController?.tabBar.isHidden = false
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if appDelegate.changeStoryBoard == true{
            tabBarController?.tabBar.isHidden = true
        }else{
            tabBarController?.tabBar.isHidden = false
        }
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func btnUserAction(_ sender:UIButton){
        
        if let userLoginFlag = userDefaults.value(forKey: "user_id") as? String{
    
            pushView()
        }else{
            loadHomePage()
        }
        
    }
    
    @objc func pushView(){
        let sBoard = UIStoryboard.init(name: "User", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "UserTabBar") as! UserTabBarController
        //        vc.hidesBottomBarWhenPushed = false
        vc.hidesBottomBarWhenPushed = true
        userDefaults.set("user", forKey: "lastLogin")
        appDelegate.changeStoryBoard = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func loadHomePage() {
        
        //let window = UIApplication.shared.keyWindow
        // var tabbarController = ManageLoginTabBarController()
        Utility.modifiedTabBar(tabBarController: tabbarController)
        appDelegate.changeStoryBoard = true
        tabbarcontroller.loadViewIfNeeded()
        userDefaults.set("none", forKey: "lastLogin")
        //self.window?.rootViewController = self.tabbarController
        if self.window?.rootViewController == self.tabbarcontroller{
            self.didMove(toParentViewController: appDelegate.window?.rootViewController)
        }else{
            self.navigationController?.pushViewController(tabbarcontroller, animated: false)
        }
        
    }
    
    
    @IBAction func btnSellServiceAction(_ sender: UIButton) {
        if let getLogin = userDefaults.value(forKey: "pro_id") as? String{
            
            gotoPrvider()
            
        }else{
            createPopUp()
        }
    }
    
    @objc func createPopUp(){
        Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "NotificationVC", isLogin: false, isService: true )
    }
    @objc func gotoPrvider(){
        let sBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
        appDelegate.changeStoryBoard = true
        //tabBarController?.hidesBottomBarWhenPushed = true
        userDefaults.set("provider", forKey: "lastLogin")
        vc.hidesBottomBarWhenPushed = true
        vc.loadViewIfNeeded()
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK Button Action
    
    @IBAction func btnChangePasswordaction(_ sender: UIButton) {
        if txtOldPassword.text?.isEmpty == true{
            Utility.errorAlert(vc: self, strMessage: "", errortitle: "Please enter your old password.")
        }else if txtNewPassword.text?.isEmpty == true{
            Utility.errorAlert(vc: self, strMessage: "", errortitle: "Please enter your password.")
        }else if txtConfirmPassword.text?.isEmpty == true {
            Utility.errorAlert(vc: self, strMessage: "", errortitle: "Please enter your confirm password.")
        }else if txtNewPassword.text != txtConfirmPassword.text{
            Utility.errorAlert(vc: self, strMessage: "", errortitle: "Password does not match.")
        }else
        {
            changePassword()
        }
        
    }
    
    // MARK ChangePassword API Calling
    func changePassword()  {
        
        KRProgressHUD.show()
        var params : [String:Any] = [:]
        if isProvider == false{
              params = ["user_old_password":"\(txtOldPassword.text!)","user_new_password":txtNewPassword.text!,"user_id":"\(profileObject.strId!))","role":"2"]
        }else{
             params = ["user_old_password":"\(txtOldPassword.text!)","user_new_password":txtNewPassword.text!,"user_id":"\(userDefaults.value(forKeyPath: "pro_id")!))","role":"1"]
        }
//        {"user_old_password":"admin1","user_new_password":"admin","user_id":"1","role":"1"}
       
        UserManager.shared.changePass(parametrs:params, completion: { (success,message) in
            if success == true{
                print("yes")
                KRProgressHUD.dismiss({
                    
                     let alert = UIAlertController(title: "Update Profile", message: "\(message!)", preferredStyle: UIAlertControllerStyle.actionSheet)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (updateProfile) in
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                })
                
            }else {
                print("no")
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: "\(message!)", alerttitle: "Update Profile")
                })
            }
        })
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
