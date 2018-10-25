//
//  SubscriptionViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 21/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD

class SubscriptionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var subbscriptionPlanTableView: UITableView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var btnFirst: UIButton!
    
    @IBOutlet weak var btnSecond: UIButton!
    
    @IBOutlet weak var btnThird: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var arrsubplan : [ListofSubscriptionPlan] = []
    var mySubScription:[MySubScriptionPlan]!
    var footerPlan = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subscriptionApiCall()
        
        self.subbscriptionPlanTableView.layer.borderWidth = 0.5
        self.subbscriptionPlanTableView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        self.heightConstraint.constant = tableViewHeight

        //subscriptionApiCall()
        // Do any additional setup after loading the view.
    }

    
    var tableViewHeight:CGFloat{
        
        self.subbscriptionPlanTableView.layoutIfNeeded()
        return subbscriptionPlanTableView.contentSize.height
    }
    
   
    
    @IBAction func selectSubscriptionPlanAction(_ sender: UIButton) {
        let firstObj = arrsubplan[0]
        let secondObj = arrsubplan[1]
        let thirdObj = arrsubplan[2]
        
        if sender.tag == 1{
            footerPlan = firstObj.sp_id!
        }else if sender.tag == 2{
            footerPlan = secondObj.sp_id!
        }else if sender.tag == 3{
            footerPlan = thirdObj.sp_id!
        }
        
        self.subbscriptionPlanTableView.reloadData()
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)

    }
    
    func subscriptionApiCall(){
        
        KRProgressHUD.show()
        
        let params = ["provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        SignUpProvider.shared.subscriptionPlanApicall(parmas: params) { (success, error, responseData,mySP) in
            
            if success ==  true{
                self.arrsubplan =  responseData
                self.mySubScription = mySP
                self.subbscriptionPlanTableView.reloadData()
                print(self.arrsubplan)
                self.heightConstraint.constant = self.tableViewHeight
                KRProgressHUD.dismiss()
            }
            else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(error!)", errortitle: "")
                })
            }
            
        }
    }
    
    func postSubSCriptionPlan(){
        
        KRProgressHUD.show()
        let params = ["plan_id":"\(footerPlan)","provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        SignUpProvider.shared.subscriptionPlanPost(parmas: params) { (success, message) in
            
            if success == true{
                
                if self.appDelegate.serviceProviderLogin == false{
                    Utility.storeServiceFlag(flag:true)
                }
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
                KRProgressHUD.show()
            }else{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: "\(message!)", alerttitle: "")
                })
            }
            
        }
    }
    
    @IBAction func continueAction(_ sender: UIButton) {
        
        guard footerPlan != "" else {
            Utility.errorAlert(vc: self, strMessage: "Select Your Subscription Plan.", errortitle: "")
            return
        }
        
        postSubSCriptionPlan()

    }
    
    func returnImage(text:String)->UIImage{
        
        let rightImage = #imageLiteral(resourceName: "smallRight")
        let wrongImage = #imageLiteral(resourceName: "wrong")
        
        if text == "Yes"{
           return rightImage
        }else{
            return wrongImage
        }
    }
    
    
    //Tableview Method
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.arrsubplan.count == 0{
            return 0
        }else{
            return 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.arrsubplan.count == 0{
            return 0
        }else{
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subscriptionCell") as! SubscriptionPlanTableViewCell
        cell.selectionStyle = .none
        
        print(indexPath.row)
        
        if oddEven(value: Int(indexPath.row)){
            cell.backView.backgroundColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        }else{
            cell.backView.backgroundColor = UIColor.white
        }
        
        let firstObj = arrsubplan[0]
        let secondObj = arrsubplan[1]
        let thirdObj = arrsubplan[2]
       
        if indexPath.row == 0{
            cell.lblFirstMonth.text! = firstObj.sp_add_employee!
            cell.lblSecond.text! = secondObj.sp_add_employee!
            cell.lblThirdMonth.text! = thirdObj.sp_add_employee!
            cell.lblSubscription.text = "Add Employee"
        }else if indexPath.row == 1 {
            cell.lblFirstMonth.text! = firstObj.sp_personalized_setting!
            cell.lblSecond.text! = secondObj.sp_personalized_setting!
            cell.lblThirdMonth.text! = thirdObj.sp_personalized_setting!
            cell.lblSubscription.text = "Personalize Settings"
        }else if indexPath.row == 2 {
            cell.lblFirstMonth.text! = firstObj.sp_add_category!
            cell.lblSecond.text! = secondObj.sp_add_category!
            cell.lblThirdMonth.text! = thirdObj.sp_add_category!
            cell.lblSubscription.text = "Add Categories"
        }else if indexPath.row == 3 {
            cell.lblFirstMonth.text! = firstObj.sp_add_services!
            cell.lblSecond.text! = secondObj.sp_add_services!
            cell.lblThirdMonth.text! = thirdObj.sp_add_services!
            cell.lblSubscription.text = "Add Services"
        }else if indexPath.row == 4 {
            cell.lblFirstMonth.text! = firstObj.sp_duration!
            cell.lblSecond.text! = secondObj.sp_duration!
            cell.lblThirdMonth.text! = thirdObj.sp_duration!
            cell.lblSubscription.text = "Duration"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableCell(withIdentifier: "footerCell") as! SubscriptionFooterCell
        let firstObj = arrsubplan[0]
        let secondObj = arrsubplan[1]
        let thirdObj = arrsubplan[2]
        if footerPlan != ""{
            if footerPlan == firstObj.sp_id!{
                footerView.imgFirst.image = #imageLiteral(resourceName: "blueCheck")
                footerView.imgSecond.image = #imageLiteral(resourceName: "blankCheck")
                footerView.imgThird.image = #imageLiteral(resourceName: "blankCheck")
            }else if footerPlan == secondObj.sp_id!{
                footerView.imgFirst.image = #imageLiteral(resourceName: "blankCheck")
                footerView.imgSecond.image = #imageLiteral(resourceName: "blueCheck")
                footerView.imgThird.image = #imageLiteral(resourceName: "blankCheck")
            }else if footerPlan == thirdObj.sp_id!{
                footerView.imgFirst.image = #imageLiteral(resourceName: "blankCheck")
                footerView.imgSecond.image = #imageLiteral(resourceName: "blankCheck")
                footerView.imgThird.image = #imageLiteral(resourceName: "blueCheck")
            }
        }else{
            footerView.imgFirst.image = #imageLiteral(resourceName: "blankCheck")
            footerView.imgSecond.image = #imageLiteral(resourceName: "blankCheck")
            footerView.imgThird.image = #imageLiteral(resourceName: "blankCheck")
        }
        return footerView
    }
    
    func oddEven(value:Int) -> Bool{
        
        var status = false
        
        if value % 2 == 0{
            
            status = true
            return status
        }else {
            status = false
            return status
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! SubScriptionHeaderCell
        
        
        cell.selectionStyle = .none
        tableView.tableFooterView = UIView()
        
        let firstObj = arrsubplan[0]
        let secondObj = arrsubplan[1]
        let thirdObj = arrsubplan[2]
        
        cell.firstPrice.text! = firstObj.sp_price!
        cell.secondPrice.text! = secondObj.sp_price!
        cell.thirdPrice.text! = thirdObj.sp_price!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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
