//
//  RatingViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 18/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD
import FloatRatingView
import SDWebImage

class RatingViewController: UIViewController,UITextViewDelegate {
    @IBOutlet weak var imgSalon: UIImageView!
    
    @IBOutlet weak var viewDetails: UIView!
    
    @IBOutlet weak var btnSellServices: UIButton!
    
    @IBOutlet weak var salonNameLable: UILabel!
   
    
    
    @IBOutlet weak var lblCityName: UILabel!
    
    @IBOutlet weak var qualityRatingView: FloatRatingView!
    
    @IBOutlet weak var txtViewcomment: UITextView!
 
    @IBOutlet weak var ontimeRatingView: FloatRatingView!
    
    @IBOutlet weak var safetyRatingView: FloatRatingView!
    
    @IBOutlet weak var resultRatingView: FloatRatingView!
    
    @IBOutlet weak var professionalismRatingView: FloatRatingView!
    
    @IBOutlet weak var rewardingRatingView: FloatRatingView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    var getSlectedOBj :SalonDetailsBasedOnId!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtViewcomment.textColor = UIColor.lightGray
        self.txtViewcomment.text! = "Comments"
        self.txtViewcomment.layer.borderWidth = 1
        self.txtViewcomment.layer.cornerRadius = 5
        self.txtViewcomment.layer.borderColor = UIColor.lightGray.cgColor
        
        self.btnSellServices.layer.borderColor = UIColor.white.cgColor
        self.btnSellServices.layer.borderWidth = 1
        self.btnSellServices.layer.cornerRadius = 15
        
        self.lblCityName.text! = getSlectedOBj.user_location!
        self.salonNameLable.text! = getSlectedOBj.business_name!
        self.imgSalon.sd_setImage(with: URL(string: getSlectedOBj.banner_name!), completed: nil)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Utility.chnageBtnTitle(btn: btnSellServices)
        tabBarController?.tabBar.isHidden = false
        if appDelegate.changeStoryBoard == true{
            appDelegate.changeStoryBoard = false
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if appDelegate.changeStoryBoard == true{
            tabBarController?.tabBar.isHidden = true
        }else{
            tabBarController?.tabBar.isHidden = false   

        }
        
        
    }
    
    @IBAction func btnSellYourServiceAction(_ sender: UIButton) {
        
        if let getLogin = userDefaults.value(forKey: "pro_id") as? String{
           
            self.perform(#selector(gotoServiceProvider), with: nil, afterDelay: 0.3)
            
        }else{
            self.perform(#selector(createPopUp), with: nil, afterDelay: 0.3)

        }
    }
    
    @objc func createPopUp(){
         Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "RatingViewController", isLogin: false, isService: true )
    }
    
    @objc func gotoServiceProvider(){
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtViewcomment.text! == "Comments"{
            txtViewcomment.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
            txtViewcomment.text! = ""
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if txtViewcomment.text! == ""{
            txtViewcomment.text! = "Comments"
            txtViewcomment.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func btnSaveAction(_ sender: UIButton) {
        KRProgressHUD.show()
        //self.perform(#selector(self.addRatingOfAll), with: nil, afterDelay: 1)
       addRatingOfAll()
    }
    
    @objc func addRatingOfAll(){

        let userReview = ["rat_time":"\(ontimeRatingView.rating)","rat_quality":"\(qualityRatingView.rating)","rat_safety":"\(safetyRatingView.rating)","rat_result":"\(resultRatingView.rating)","rat_proffesnalism":"\(professionalismRatingView.rating)","rat_discription":"\(txtViewcomment.text!)","rat_user_id":"\(userDefaults.value(forKey: "user_id")!)","rat_service_pro_id":"\(getSlectedOBj.serviceProviderId!)","rat_role":"2","rat_rewarding":"\(rewardingRatingView.rating)"]
        
        UserManager.shared.userRateReview(param: userReview) { (success) in
            
            if success {
                
                    KRProgressHUD.dismiss({
                        
                        let alert = UIAlertController(style: .alert,title: "Add Review", message: "Reviews are added successfuly.")
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                            self.navigationController?.popViewController(animated: true)
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
  
                    })
                
                
            }else{
                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                    KRProgressHUD.dismiss({
                        
                        Utility.showAlert(vc: self, strMessage: "Something went wrong.", alerttitle: "Add Review.")
                    })
                }
         
            }
            
            
        }
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
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
