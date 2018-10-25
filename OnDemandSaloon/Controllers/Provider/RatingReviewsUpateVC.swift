//
//  RatingReviewsUpateVC.swift
//  demo1
//
//  Created by PS on 01/08/18.
//  Copyright © 2018 PS. All rights reserved.
//

import UIKit
import FloatRatingView
class RatingReviewsUpateVC: UIViewController {

    @IBOutlet weak var commentBackView: UIView!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var txtCommentd: UITextView!
    @IBOutlet weak var lblRewarding: UILabel!
    @IBOutlet weak var lbllProfession: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var lblSafety: UILabel!
    @IBOutlet weak var lblQualityofServices: UILabel!
    @IBOutlet weak var lblOneTime: UILabel!
    
    @IBOutlet weak var rewardingRatingView: FloatRatingView!
    @IBOutlet weak var professionRatingView: FloatRatingView!
    @IBOutlet weak var resultRatingView: FloatRatingView!
    @IBOutlet weak var safetyRatingView: FloatRatingView!
    @IBOutlet weak var qualityofServicesRatingView: FloatRatingView!
    @IBOutlet weak var oneTimeRatingView: FloatRatingView!
    
    @IBOutlet weak var salonName: UILabel!
    
    @IBOutlet weak var lblRateDate: UILabel!
    var provider = false
    
    @IBOutlet weak var btnSellYourService: UIButton!
    @IBOutlet weak var btnNormalUser: UIButton!
    var userReviewObj :UserRateReviews!
    var providerReviewObj:ProviderRateAndReviewList!
    
    var tabbarController = ManageLoginTabBarController()
    let window = UIApplication.shared.keyWindow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if provider == false{
            self.rewardingRatingView.rating = Double(userReviewObj.rat_rewarding!)!
            self.professionRatingView.rating = Double(userReviewObj.rat_proffesnalism!)!
            self.resultRatingView.rating = Double(userReviewObj.rat_result!)!
            self.safetyRatingView.rating = Double(userReviewObj.rat_safety!)!
            self.qualityofServicesRatingView.rating = Double(userReviewObj.rat_quality!)!
            self.oneTimeRatingView.rating = Double(userReviewObj.rat_time!)!
            self.salonName.text! = "\(userReviewObj.ratSalonName!)"
            self.lblRateDate.text! = Utility.customDateFormatter(date: userReviewObj.ratCreatedTime!, fromDateFormat: "yyyy-mm-dd HH:mm:ss", toDateFormat: "dd-MM-yyyy")
            self.txtCommentd.text! = "\(userReviewObj.ratDiscription!)"
        }else{
            self.rewardingRatingView.rating = Double(providerReviewObj.rat_rewarding!)!
            self.professionRatingView.rating = Double(providerReviewObj.rat_proffesnalism!)!
            self.resultRatingView.rating = Double(providerReviewObj.rat_result!)!
            self.safetyRatingView.rating = Double(providerReviewObj.rat_safety!)!
            self.qualityofServicesRatingView.rating = Double(providerReviewObj.rat_quality!)!
            self.oneTimeRatingView.rating = Double(providerReviewObj.rat_time!)!
            self.salonName.text! = "\(providerReviewObj.user_fname!) \(providerReviewObj.user_lname!)"
            self.lblRateDate.text! = Utility.customDateFormatter(date: providerReviewObj.rat_created_time!, fromDateFormat: "yyyy-mm-dd HH:mm:ss", toDateFormat: "dd-MM-yyyy")
            self.txtCommentd.text! = "\(providerReviewObj.rat_discription!)"
            self.txtCommentd.isUserInteractionEnabled = false
            self.btnUpdate.isHidden = true
        }
        self.txtCommentd.isUserInteractionEnabled = false
        self.commentBackView.layer.borderWidth = 1
        self.commentBackView.layer.cornerRadius  = 4
        self.commentBackView.clipsToBounds = true
        
        self.commentBackView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        self.commentBackView.layer.borderWidth = 1
        
        if self.txtCommentd.text! == ""{
            self.txtCommentd.text = "Comment"
            self.txtCommentd.textColor = UIColor.lightGray
        }
        self.btnNormalUser.layer.borderWidth = 1
        self.btnSellYourService.layer.borderWidth = 1
        
        self.btnNormalUser.layer.cornerRadius = self.btnNormalUser.frame.size.height / 2
        self.btnSellYourService.layer.cornerRadius = self.btnSellYourService.frame.size.height / 2
        
        self.btnNormalUser.layer.borderColor = UIColor.white.cgColor
        self.btnSellYourService.layer.borderColor = UIColor.white.cgColor

        self.btnSellYourService.isHidden = true
        self.btnNormalUser.isHidden = true
        self.btnNormalUser.addTarget(self, action: #selector(btnUserAction(_:)), for: .touchUpInside)
        
        Utility.chnageBtnTitle(btn: btnSellYourService)
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewDidDisappear(true)
        
        if appDelegate.changeStoryBoard == true{
            
            tabBarController?.tabBar.isHidden = true
        }else{
            tabBarController?.tabBar.isHidden = false
        }
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
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
        tabBarController?.hidesBottomBarWhenPushed = true
        
        vc.loadViewIfNeeded()
        userDefaults.set("user", forKey: "lastLogin")
        appDelegate.changeStoryBoard = true
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: false)
        
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
    
    
    @IBAction func btnSellServiceAction(_ sender: UIButton) {
        if let getLogin = userDefaults.value(forKey: "pro_id") as? String{
            
                gotoPrvider()

        }else{
            createPopUp()
        }
    }
    
    @objc func createPopUp(){
        Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "RatingReviewsUpateVC", isLogin: false, isService: true )
    }
    @objc func gotoPrvider(){
        let sBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
        appDelegate.changeStoryBoard = true
        //tabBarController?.hidesBottomBarWhenPushed = true
        vc.hidesBottomBarWhenPushed = true
        vc.loadViewIfNeeded()
        userDefaults.set("provider", forKey: "lastLogin")
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK Button Action
    @IBAction func btnUpdateaction(_ sender: UIButton) {
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
