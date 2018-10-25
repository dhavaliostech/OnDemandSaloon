//
//  RatingReviewsVC.swift
//  demo1
//
//  Created by PS on 31/07/18.
//  Copyright © 2018 PS. All rights reserved.
//

import UIKit
import KRProgressHUD

class RatingReviewsVC: UIViewController {

    @IBOutlet weak var ratingTableView: UITableView!
    
    var arrayOfListUserRateAndReview :[UserRateReviews] = []
    var proviedrList:[ProviderRateAndReviewList] = []
    var providerFlag = false
    
    @IBOutlet weak var btnSellYourService: UIButton!
    @IBOutlet weak var btnNormalUser: UIButton!
    
    var tabbarController = ManageLoginTabBarController()
    let window = UIApplication.shared.keyWindow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnNormalUser.layer.borderWidth = 1
        self.btnSellYourService.layer.borderWidth = 1

        self.btnNormalUser.layer.cornerRadius = self.btnNormalUser.frame.size.height / 2
        self.btnSellYourService.layer.cornerRadius = self.btnSellYourService.frame.size.height / 2
        
        self.btnNormalUser.layer.borderColor = UIColor.white.cgColor
        self.btnSellYourService.layer.borderColor = UIColor.white.cgColor
        
        self.btnSellYourService.isHidden = true
        self.btnNormalUser.isHidden = true

        if providerFlag == false{
            self.btnSellYourService.isHidden = false
            Utility.chnageBtnTitle(btn: self.btnSellYourService)
            self.getUserRateAndReview()
        }else{
            self.btnNormalUser.isHidden = false
            providerRatingAndReviewList()
        }

        self.btnNormalUser.addTarget(self, action: #selector(btnUserAction(_:)), for: .touchUpInside)
        ratingTableView.tableFooterView = UIView()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        if appDelegate.changeStoryBoard == true{
            self.tabBarController?.tabBar.isHidden = true

        }else{
            self.tabBarController?.tabBar.isHidden = false

        }
        
    }
    
    func getUserRateAndReview(){
      
        let params = ["user_id":"\(userDefaults.value(forKey: "user_id")!)","rat_role":"2"]
     

        KRProgressHUD.show()
        UserManager.shared.reteAndReviewAPI(param: params) { (success, responseData, message) in
            
            if success == true{
                self.arrayOfListUserRateAndReview = responseData
  
                self.ratingTableView.reloadData()
                KRProgressHUD.dismiss()
            }else{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: "\(message!)", alerttitle: "")
                })
            }
            //UserRateReviews
            
        }
        
    }
    
    func providerRatingAndReviewList(){
    
        KRProgressHUD.show()
            
        let params = ["provider_id":"1"]
        
        ProviderManager.shared.providerRatingList(parmas: params) { (success, message, response) in
            
            if success == true{
                self.proviedrList = response
                self.ratingTableView.reloadData()
            }else{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: "\(message!)", alerttitle: "")
                })
            }
            KRProgressHUD.dismiss()
        }
        
    }
    
    @IBAction func btnBackaction(_ sender: UIButton) {
        
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
        vc.hidesBottomBarWhenPushed = true
        tabBarController?.tabBar.isHidden = true
        vc.loadViewIfNeeded()
        userDefaults.set("user", forKey: "lastLogin")
        appDelegate.changeStoryBoard = true
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
        Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "NotificationVC", isLogin: false, isService: true )
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "reviewSegue"{
            let obj = segue.destination as! RatingReviewsUpateVC
            tabBarController?.tabBar.isHidden = false
            obj.provider = providerFlag
            if providerFlag == false{
                obj.userReviewObj = sender as! UserRateReviews
            }else{
                obj.providerReviewObj = sender as! ProviderRateAndReviewList
            }
            
        }
        
    }
 

}
extension RatingReviewsVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if providerFlag == false{
            return arrayOfListUserRateAndReview.count
        }else{
            return proviedrList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsRatingCell") as! ReviewsRatingCell
        
        if providerFlag == false{
            let obj = arrayOfListUserRateAndReview[indexPath.row]
            
            cell.lblNameOfSaloon.text = obj.ratSalonName!
            cell.lblDate.text = Utility.customDateFormatter(date: obj.ratCreatedTime!, fromDateFormat: "yyyy-mm-dd HH:mm:ss", toDateFormat: "dd-mmm-yyyy")
            cell.lblComments.text = obj.ratDiscription!
            cell.RatingView.rating = Double(obj.ratOutOf5!)!
            
        }else{
            let obj = proviedrList[indexPath.row]
            
            cell.lblNameOfSaloon.text = "\(obj.user_fname!) \(obj.user_lname!)"
            cell.lblDate.text = Utility.customDateFormatter(date: obj.rat_created_time!, fromDateFormat: "yyyy-mm-dd HH:mm:ss", toDateFormat: "dd-mmm-yyyy")
            cell.lblComments.text = obj.rat_discription!
            cell.RatingView.rating = Double(obj.rat_out_of_5!)!
        }

        cell.backView.layer.shadowOpacity = 0.18
        cell.backView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.backView.layer.shadowRadius = 2
        cell.backView.layer.shadowColor = UIColor.black.cgColor
        cell.backView.layer.masksToBounds = false
        
        cell.backView.layer.cornerRadius = 8
        //cell.backView.clipsToBounds = true
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        var userObj:UserRateReviews!
        var providerObj :ProviderRateAndReviewList!
        if providerFlag == false{
            userObj = arrayOfListUserRateAndReview[indexPath.row]
            self.performSegue(withIdentifier: "reviewSegue", sender: userObj)
        }else{
              providerObj = proviedrList[indexPath.row]
            self.performSegue(withIdentifier: "reviewSegue", sender: providerObj)
        }
        
        
    }
    
    
}
