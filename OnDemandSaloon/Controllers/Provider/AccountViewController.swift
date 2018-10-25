//
//  AccountViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 22/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD

class AccountViewController: UIViewController {

    @IBOutlet weak var logoutBackView: UIView!
    @IBOutlet weak var companyInfoView: UIView!
    
    @IBOutlet weak var lblCompanyInfo: UILabel!
    
    @IBOutlet weak var categoeyView: UIView!
    
    @IBOutlet weak var lblCategory: UILabel!
    
    @IBOutlet weak var lblServices: UILabel!
    @IBOutlet weak var servicesView: UIView!
    
    @IBOutlet weak var employeeView: UIView!
    
    @IBOutlet weak var accountTypeView: UIView!
    @IBOutlet weak var txtFieldEmployee: UITextField!
    
    @IBOutlet weak var lblAccountType: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    
    @IBOutlet weak var reviewView: UIView!
    
    @IBOutlet weak var addOffersView: UIView!
    
    @IBOutlet weak var lblSettings: UILabel!
    @IBOutlet weak var lblAddOffers: UILabel!
    
    @IBOutlet weak var employeeTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var employeeViewheight: NSLayoutConstraint!
    @IBOutlet weak var settingsView: UIView!
    
    @IBOutlet weak var btnUser: UIButton!
    
    let window = UIApplication.shared.keyWindow
     var tabbarController = ManageLoginTabBarController()
    
    var flagForSignUp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        flagForSignUp = false
        self.companyInfoView.layer.borderWidth = 0.5
        self.categoeyView.layer.borderWidth = 0.5
        self.servicesView.layer.borderWidth = 0.5
        self.employeeView.layer.borderWidth = 0.5
        self.reviewView.layer.borderWidth = 0.5
        self.settingsView.layer.borderWidth = 0.5
        self.logoutBackView.layer.borderWidth = 0.5
        self.accountTypeView.layer.borderWidth = 0.5
        setView()
        self.btnUser.addTarget(self, action: #selector(btnUserAction(_:)), for: UIControlEvents.touchUpInside)
        
        self.btnUser.layer.borderWidth = 1
        self.btnUser.layer.borderColor = UIColor.white.cgColor
        self.btnUser.layer.cornerRadius = 15
        self.employeeViewheight.constant = 45
        if let getServiceTyper = userDefaults.value(forKey: "reg_service_type") as? String{
            
            if getServiceTyper == "1"{
                self.lblAccountType.text = "Freelancer"
               self.employeeViewheight.constant = 0
                self.employeeTopConstraint.constant = 0
            }else{
                self.lblAccountType.text = "Saloons"
                self.employeeTopConstraint.constant = 15
                self.employeeViewheight.constant = 45
            }
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func setView(){
         Utility.setBoarderAndColorOfView(getview: self.addOffersView)
         Utility.setBoarderAndColorOfView(getview: self.settingsView)
         Utility.setBoarderAndColorOfView(getview: self.reviewView)
         Utility.setBoarderAndColorOfView(getview: self.employeeView)
         Utility.setBoarderAndColorOfView(getview: self.servicesView)
         Utility.setBoarderAndColorOfView(getview: self.categoeyView)
         Utility.setBoarderAndColorOfView(getview: self.logoutBackView)
         Utility.setBoarderAndColorOfView(getview: self.companyInfoView)
        Utility.setBoarderAndColorOfView(getview: self.accountTypeView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = false
        flagForSignUp = false
        if appDelegate.changeStoryBoard == true{
            appDelegate.changeStoryBoard = false
        }

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        if flagForSignUp == true{
            tabBarController?.tabBar.isHidden = true
        }else if appDelegate.changeStoryBoard == true{
            tabBarController?.tabBar.isHidden = true
        }else{
            tabBarController?.tabBar.isHidden = false

        }
   
    }
    
    @IBAction func btnCompanyInfoAction(_ sender: UIButton) {
        performSegue(withIdentifier: "companyInfo", sender: nil)
    }
    @IBAction func btnServicesAction(_ sender: UIButton) {
        let sBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "Prices&ServicesViewController") as! Prices_ServicesViewController
        self.flagForSignUp = true
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCategoryAction(_ sender: UIButton) {
        let sBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "AddServicesCategoryVC") as! AddServicesCategoryVC
        self.flagForSignUp = true
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadHomePage() {
        
        //let window = UIApplication.shared.keyWindow
        // var tabbarController = ManageLoginTabBarController()
        Utility.modifiedTabBar(tabBarController: tabbarController)
        appDelegate.changeStoryBoard = true
        tabbarController.loadViewIfNeeded()
        userDefaults.set("none", forKey: "lastLogin")
        //self.window?.rootViewController = self.tabbarController
        if self.window?.rootViewController == self.tabbarController{
            self.didMove(toParentViewController: appDelegate.window?.rootViewController)
        }else{
            self.navigationController?.pushViewController(tabbarController, animated: false)
        }
        
    }
    
    @IBAction func logoutAction(_ sender: UIButton) {
        
        userDefaults.removeObject(forKey: "pro_email")
        userDefaults.removeObject(forKey: "pro_phone")
        userDefaults.removeObject(forKey: "pro_role")
        userDefaults.removeObject(forKey: "pro_password")
        userDefaults.removeObject(forKey: "pro_id")
        userDefaults.removeObject(forKey: "pro_buissnes_name")
        userDefaults.removeObject(forKey: "pro_city")
        userDefaults.removeObject(forKey: "business_full_address")
        userDefaults.removeObject(forKey: "pro_country")
        userDefaults.removeObject(forKey: "pro_avatar")
        userDefaults.removeObject(forKey: "pro_location")
        userDefaults.removeObject(forKey: "business_full_address")
        userDefaults.removeObject(forKey: "service_pro_reg_status")
        userDefaults.removeObject(forKey: "reg_service_type")
        
        userDefaults.synchronize()
        
        if userDefaults.value(forKey: "userLogin") as? Bool == true{
            userDefaults.set(false, forKey: "serviceProviderLogin")
            userDefaults.synchronize()
            let sBoard = UIStoryboard.init(name: "User", bundle: nil)
            let vc = sBoard.instantiateViewController(withIdentifier: "UserTabBar") as! UserTabBarController
            appDelegate.changeStoryBoard = true
            vc.loadViewIfNeeded()
            tabBarController?.tabBar.isHidden = true
            self.navigationController?.pushViewController(vc, animated: false)
        }else{
            userDefaults.set(false, forKey: "serviceProviderLogin")
            userDefaults.set("none", forKey: "lastLogin")
            userDefaults.synchronize()
            loadHomePage()
            
        }
 
    }
    
    
    
    
    @IBAction func btnReviewAction(_ sender: UIButton) {
        let sBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "RatingReviewsVC")as! RatingReviewsVC
        self.flagForSignUp = true
        vc.providerFlag = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func addEmployeeAction(_ sender: UIButton) {
         performSegue(withIdentifier: "empoyeeListSegue", sender: nil)
    }
    @IBAction func btnSettingsAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Settings", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction(title: "Account Settings", style: UIAlertActionStyle.default, handler: { (updateProfile) in
            self.performSegue(withIdentifier: "settingSegue", sender: nil)

        }))
        alert.addAction(UIAlertAction(title: "Opening Hours", style: UIAlertActionStyle.default, handler: { (updateProfile) in
            let sBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
            let vc = sBoard.instantiateViewController(withIdentifier: "Work_day_VC")as! Work_day_VC
            self.flagForSignUp = true
            appDelegate.changeStoryBoard = true
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        alert.addAction((UIAlertAction(title: "Change Password", style: UIAlertActionStyle.default, handler: { (changePass) in
            
            let sBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
            let vc = sBoard.instantiateViewController(withIdentifier: "ChangePasswordVC")as! ChangePasswordVC
            self.flagForSignUp = true
            vc.isProvider = true
            appDelegate.changeStoryBoard = true

            self.navigationController?.pushViewController(vc, animated: true)
        })))
        
        alert.addAction(UIAlertAction(title: "View Subscription Plan", style: UIAlertActionStyle.default, handler: { (updateProfile) in
            let sBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
            let vc = sBoard.instantiateViewController(withIdentifier: "SubscriptionViewController")as! SubscriptionViewController
            appDelegate.changeStoryBoard = true

            self.flagForSignUp = true
            
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (updateProfile) in

        }))
       
        
        self.present(alert, animated: true, completion: nil)
        

    }
    
    @IBAction func btnAddOffersAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Offers", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction(title: "Add Offers", style: UIAlertActionStyle.default, handler: { (updateProfile) in
            self.performSegue(withIdentifier: "addOfferSegue", sender: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "View Offers", style: UIAlertActionStyle.default, handler: { (updateProfile) in
            self.performSegue(withIdentifier: "viewOfferSegue", sender: nil)
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (updateProfile) in
            
        }))

        self.present(alert, animated: true, completion: nil)
 
    }
    
    @IBAction func changeAccountTypeAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Select Account Type", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        alert.addAction(UIAlertAction(title: "Freelancer", style: UIAlertActionStyle.default, handler: { (updateProfile) in
            self.lblAccountType.text! = "Freelancer"
            self.changeAccountServiceType(type: "1")
        }))
        alert.addAction(UIAlertAction(title: "Saloons", style: UIAlertActionStyle.default, handler: { (updateProfile) in
                self.lblAccountType.text! = "Saloons"
                self.changeAccountServiceType(type: "2")
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (updateProfile) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
   
    }
    
    @objc func btnUserAction(_ sender:UIButton){
        if let userLoginFlag = userDefaults.value(forKey: "user_id") as? Bool{
            loadHomePage()
        }else{
            let sBoard = UIStoryboard.init(name: "User", bundle: nil)
            let vc = sBoard.instantiateViewController(withIdentifier: "UserTabBar") as! UserTabBarController
            //        vc.hidesBottomBarWhenPushed = false
            vc.hidesBottomBarWhenPushed = true
            vc.loadViewIfNeeded()
            userDefaults.set("user", forKey: "lastLogin")
            appDelegate.changeStoryBoard = true
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func changeAccountServiceType(type:String?){
        KRProgressHUD.show()
        
        
        let params = ["reg_service_type":"\(type!)","service_pro_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        ProviderManager.shared.changeAccountType(params: params) { (success, message) in
            
            if success == true{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: message!, alerttitle: "")
                })
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: message!, errortitle: "")
                })
            }
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "companyInfo"{
            let obj = segue.destination as! ServiceProviderProfileViewController
            tabBarController?.tabBar.isHidden = false
        }else if segue.identifier == "empoyeeListSegue"{
            let obj = segue.destination as! EmployeeListViewController
            tabBarController?.tabBar.isHidden = false

        }else if segue.identifier == "settingSegue"{
            let obj = segue.destination as! ClientAppointmentTimeViewController
            tabBarController?.tabBar.isHidden = false

        }else if segue.identifier == "rateReviewSegue"{
            let obj = segue.destination as! RatingReviewsVC
            tabbarController.tabBar.isHidden = true
        }else if segue.identifier == "addOfferSegue"{
            let obj = segue.destination as! AddOffersViewController
            tabbarController.tabBar.isHidden = false
        }else if segue.identifier == "viewOfferSegue"{
            let obj = segue.destination as! ViewOffresAdminVC
            tabbarController.tabBar.isHidden = false
        }
        
    }
 

}
