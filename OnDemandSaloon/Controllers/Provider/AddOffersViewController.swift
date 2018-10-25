//
//  AddOffersViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 08/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD

class AddOffersViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var txtTitleView: UITextView!
    
    @IBOutlet weak var discriptionView: UIView!
    
    @IBOutlet weak var txtDiscriptionView: UITextView!
    
    @IBOutlet weak var btnstartDate: UIButton!
    
    @IBOutlet weak var btnEnddate: UIButton!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var btnOffer: UIButton!
    
    @IBOutlet weak var btnUser: UIButton!
    let window = UIApplication.shared.keyWindow
    var tabbarControllerCreated = ManageLoginTabBarController()
    let shapeLayer = CAShapeLayer()
    
    var tabbarController = ManageLoginTabBarController()
    
    var isViewOffer = false
    
    
    var addOffersArray:[AddOffersData] = []
    var editOffersArray:ViewOffersData!
    var editarr:[AddOffersData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnUser.addTarget(self, action: #selector(btnUserAction(_:)), for: UIControlEvents.touchUpInside)
        self.btnUser.layer.borderWidth = 1
        self.btnUser.layer.borderColor = UIColor.white.cgColor
        self.btnUser.layer.cornerRadius = self.btnUser.frame.size.height / 2
        
        self.discriptionView.layer.cornerRadius = 5
        self.discriptionView.layer.borderWidth = 1
        self.discriptionView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
//        self.txtTitleView.text = "Title"
        //self.txtTitleView.textColor = UIColor.lightGray
        
        self.titleView.layer.cornerRadius = 5
        self.titleView.layer.borderWidth = 1
        self.titleView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        //self.txtDiscriptionView.text = "Discription"
        //self.txtDiscriptionView.textColor = UIColor.lightGray
        
        if isViewOffer == true{
            
            self.txtTitleView.text! = self.editOffersArray.off_name!
            self.txtDiscriptionView.text! = self.editOffersArray.off_desc!
            self.btnstartDate.setTitle(self.editOffersArray.off_start_date!, for: .normal)
            self.btnEnddate.setTitle(self.editOffersArray.off_end_date!, for: .normal)
            self.btnOffer.setTitle("Update", for: UIControlState.normal)
        }else{
            
            
            self.btnOffer.setTitle("Add Offer", for: UIControlState.normal)
        }
        
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
//        if textView == txtTitleView{
//            if txtTitleView.text == "Title" {
//
//                txtTitleView.text = ""
//                txtTitleView.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
//
//            }
//        }
//
//        if textView == txtDiscriptionView{
//            if txtDiscriptionView.text == "Discription"{
//                txtDiscriptionView.text = ""
//                txtDiscriptionView.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
//
//            }
//        }
        
    }
    
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
//        if textView == txtTitleView{
//            if txtTitleView.text == "" {
//
//                txtTitleView.text = "Title"
//                txtTitleView.textColor = UIColor.lightGray
//
//            }
//        }
//
//        if textView == txtDiscriptionView{
//            if txtDiscriptionView.text == ""{
//                txtDiscriptionView.text = "Discription"
//                txtDiscriptionView.textColor = UIColor.lightGray
//            }
//        }
       
    }
    
//    {"off_name": "Dummy","off_desc": "Dummy","off_start_date": "2018-08-19","off_end_date": "2018-09-19","off_services_id": "1"}
    
    @objc func btnUserAction(_ sender:UIButton){
        
        if let userLoginFlag = userDefaults.value(forKey: "user_id") as? Bool{
            loadHomePage()
        }else{
            pushView()
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
        tabbarController.loadViewIfNeeded()
        userDefaults.set("none", forKey: "lastLogin")
        //self.window?.rootViewController = self.tabbarController
        if self.window?.rootViewController == self.tabbarController{
            self.didMove(toParentViewController: appDelegate.window?.rootViewController)
        }else{
            self.navigationController?.pushViewController(tabbarController, animated: false)
        }
        
    }
    
    
    //Add Offers Api Call
    func addOffers(){
        
        KRProgressHUD.show()
        
        let startTime = btnstartDate.titleLabel?.text
        
        let endTime = btnEnddate.titleLabel?.text
        
        let paramter = ["off_name":"\(txtTitleView.text!)","off_desc":"\(txtDiscriptionView.text!)","off_start_date":"\(startTime!)","off_end_date":"\(endTime!)","off_services_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        ProviderManager.shared.addOffersAPIcall(params: paramter) { (success, message) in
            
            if success == true{
                
                
                KRProgressHUD.dismiss({
                    let alert = UIAlertController(title: "Add Offer", message: "\(message!)", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                })
                
            }
            else {
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "Add Offer")
                })
            }
            
        }
    }
    func editOffers(){
        
        KRProgressHUD.show()
        
        let startTime = btnstartDate.titleLabel?.text
        
        let endTime = btnEnddate.titleLabel?.text
        
        let parmter = ["off_name":"\(txtTitleView.text!)","off_desc":"\(txtDiscriptionView.text!)","off_start_date":"\(startTime!)","off_end_date":"\(endTime!)","off_services_id":"\(userDefaults.value(forKey: "pro_id")!)","off_id":"\(self.editOffersArray.off_id!)"]
        
        ProviderManager.shared.editOffersAPIcall(params: parmter) { (success, message) in
            
            if success == true{
                
                
                
                KRProgressHUD.dismiss({
                    let alert = UIAlertController(title: "Edit Offer", message: "\(message!)", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    self.present(alert, animated: true, completion: nil)
                })
                
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "Add Offer")
                })
            }
            
        }
    }
    
    @IBAction func btnAddOfferAction(_ sender: UIButton) {
        
        guard self.txtTitleView.text! != "" else {
            Utility.errorAlert(vc: self, strMessage: "Please enter offer title.", errortitle: "")
            return
        }
        guard self.txtDiscriptionView.text! != "" else {
            Utility.errorAlert(vc: self, strMessage: "Please enter offer discription.", errortitle: "")
            return
        }
        
        if isViewOffer == false{
            addOffers()
        }else{
            editOffers()
        }
        
        
    }
    
    @IBAction func btnStartDateAction(_ sender: UIButton) {
        
        let alert = UIAlertController(style: .actionSheet, title: "", message: "Select Date")
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            Log(date)
            print(date)
            
            let stringDate = "\(date)"
            self.btnstartDate.setTitle(Utility.convertDateFormater(stringDate, dateFormat: "dd-MM-yyyy"), for: .normal)
        }
        alert.addAction(title: "Done", style: .cancel)
        
        alert.show()
        
    }
    
    @IBAction func btnEndDateAction(_ sender: UIButton) {
        let alert = UIAlertController(style: .actionSheet, title: "", message: "Select Date")
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            Log(date)
            print(date)
            
            let stringDate = "\(date)"
            self.btnEnddate.setTitle(Utility.convertDateFormater(stringDate, dateFormat: "dd-MM-yyyy"), for: .normal)
        }
        alert.addAction(title: "Done", style: .cancel)
        
        alert.show()
        
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
        
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
