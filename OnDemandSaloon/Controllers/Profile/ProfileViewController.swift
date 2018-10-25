//
//  ProfileViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 18/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD
import AVKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var btnSellServices: UIButton!
    
    @IBOutlet weak var imgUserProfile: UIImageView!
    
    @IBOutlet weak var txtFielduserName: UITextField!
    
    @IBOutlet weak var txtFieldEmail: UITextField!
    
    @IBOutlet weak var txtFieldNumber: UITextField!
    
    @IBOutlet weak var viewUserType: UIView!
    
    @IBOutlet weak var viewSubscription: UIView!
    
    @IBOutlet weak var btnUserType: UIButton!
    
    @IBOutlet weak var btnUserSubscription: UIButton!
    
    @IBOutlet weak var viewAccountDetails: UIView!
    
    @IBOutlet weak var viewSettings: UIView!
    
    @IBOutlet weak var viewReviws: UIView!
    
    @IBOutlet weak var viewNotification: UIView!
    @IBOutlet weak var viewUserRating: UIView!
 
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblUserEmail: UILabel!
    
    @IBOutlet weak var lblContactNumber: UILabel!
    
    @IBOutlet weak var lbluserType: UILabel!
    
    @IBOutlet weak var lblSubscription: UILabel!
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var packagesView: UIView!
    
    var flagForSign  = false
    
    var arraOfProfileData: ProfileAdd!
    
    let window = UIApplication.shared.keyWindow
    var tabbarController = ManageLoginTabBarController()
    override func viewDidLoad(){
        super.viewDidLoad()

        btnSellServices.layer.borderColor = UIColor.white.cgColor
        btnSellServices.layer.borderWidth = 1
        btnSellServices.layer.cornerRadius = 16

        Utility.setBoarderAndColorOfView(getview: logoutView)
        Utility.setBoarderAndColorOfView(getview: packagesView)
        Utility.setBoarderAndColorOfView(getview: viewAccountDetails)
        Utility.setBoarderAndColorOfView(getview: viewSettings)
        Utility.setBoarderAndColorOfView(getview: viewReviws)
        Utility.setBoarderAndColorOfView(getview: viewNotification)
        
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imgUserProfile.layer.cornerRadius = self.imgUserProfile.frame.size.height / 2
        self.imgUserProfile.clipsToBounds = true
        self.imgUserProfile.layer.borderWidth = 1
        self.imgUserProfile.layer.borderColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1).cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getprofile()
        
         Utility.chnageBtnTitle(btn: btnSellServices)
        
        if appDelegate.changeStoryBoard == true{
            appDelegate.changeStoryBoard = false
        }
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if appDelegate.changeStoryBoard == true{
            self.tabBarController?.tabBar.isHidden = true
        }else{
            self.tabbarController.tabBar.isHidden = false
        }
    }
    
    @IBAction func sellYourServicesAction(_ sender: UIButton) {

        if let getLogin = userDefaults.value(forKey: "pro_id") as? String{
            
                let sBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let vc = sBoard.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
                appDelegate.changeStoryBoard = true
                //tabBarController?.hidesBottomBarWhenPushed = true
                vc.hidesBottomBarWhenPushed = true
                vc.loadViewIfNeeded()
                userDefaults.set("provider", forKey: "lastLogin")
                tabBarController?.tabBar.isHidden = true
                self.navigationController?.pushViewController(vc, animated: false)
            
        }else{
            Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "ProfileViewController", isLogin: false, isService: true )
        }
    }
    
    @IBAction func logOutAction(_ sender: UIButton) {
        //Flag For Login
        userDefaults.set(false, forKey: "userLogin")
        userDefaults.set("none", forKey: "lastLogin")
        
        //userDefaults.set("", forKey: <#T##String#>)
        //Clear User Data
        userDefaults.removeObject(forKey: "user_email")
        userDefaults.removeObject(forKey: "user_phone")
        userDefaults.removeObject(forKey: "role")
        userDefaults.removeObject(forKey: "user_password")
        userDefaults.removeObject(forKey: "latitude")
        userDefaults.removeObject(forKey: "user_id")
        userDefaults.removeObject(forKey: "user_avatar")
        userDefaults.removeObject(forKey: "userFirstName")
        userDefaults.removeObject(forKey: "userLastName")
        
        userDefaults.synchronize()
        
        loadHomePage()
    }
    
    func loadHomePage() {
        Utility.modifiedTabBar(tabBarController: tabbarController)
        appDelegate.changeStoryBoard = true
        
        //self.window?.rootViewController = self.tabbarController
        if self.window?.rootViewController == self.tabbarController{
            self.didMove(toParentViewController: appDelegate.window?.rootViewController)
        }else{
            self.navigationController?.pushViewController(tabbarController, animated: false)
        }
        
    }
    
    
    func actionSheetAction(){
        
        let alert = UIAlertController(title: "Account Settings", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction((UIAlertAction(title: "Change Password", style: UIAlertActionStyle.default, handler: { (changePass) in
            
            let sBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
            let vc = sBoard.instantiateViewController(withIdentifier: "ChangePasswordVC")as! ChangePasswordVC
            self.flagForSign = true
            vc.profileObject = self.arraOfProfileData
            vc.isProvider = false
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.pushViewController(vc, animated: true)
        })))
        
        alert.addAction(UIAlertAction(title: "Edit Profile", style: UIAlertActionStyle.default, handler: { (updateProfile) in
            
            let sBoard = UIStoryboard.init(name: "User", bundle: nil)
            let vc = sBoard.instantiateViewController(withIdentifier: "UpdateProfileVC")as! UpdateProfileVC
            self.flagForSign = true
            vc.profileObj = self.arraOfProfileData
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (updateProfile) in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func accountDetailsAction(_ sender: UIButton) {
        
        actionSheetAction()
    }
    @IBAction func settingsAction(_ sender: UIButton) {
        
        let sBoard = UIStoryboard.init(name: "User", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        
        self.navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func reviewsAction(_ sender: UIButton) {
        let sBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "RatingReviewsVC")as! RatingReviewsVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getprofile(){
        
        KRProgressHUD.show()
        
        let profileParmiter = ["id":"\(userDefaults.value(forKey: "user_id") as! String)","role":"2"]
        
        ProfileManager.shared.profileApicall(parmas: profileParmiter) { (success, message, responseData) in
            
            if success == true{
                
                print(responseData)
                self.arraOfProfileData = responseData
                KRProgressHUD.show()
                let obj =  self.arraOfProfileData
                self.lblUserName.text =  obj?.strUserFname!
                self.lblUserEmail.text = obj?.strUserEmail
                self.lblContactNumber.text = obj?.strUserPhone
                self.imgUserProfile.sd_setImage(with: URL(string: (obj?.strUserAvatar)!), completed: nil)
                if obj?.strUserType! == "0"{
                    self.lbluserType.text! = "Basic"
                }
                
                if obj?.strSubscription! == "1"{
                    
                    self.lblSubscription.text! = "Free"
                }
                
               // self.lbluserType.text =
                KRProgressHUD.dismiss()
                
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
            }
            
            
        }
        
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
