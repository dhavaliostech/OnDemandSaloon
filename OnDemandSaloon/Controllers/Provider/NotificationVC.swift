//
//  NotificationVC.swift
//  OnDemandSaloon
//
//  Created by PS on 06/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD
class NotificationVC: UIViewController {

 
    @IBOutlet var OnOffSwitch: UISwitch!
    
    @IBOutlet var lblNotification: UILabel!
    
    @IBOutlet var bgview: UIView!
    
    @IBOutlet var lblTitle: UILabel!
    
    @IBOutlet var lblProxiay: UILabel!
    
    @IBOutlet weak var btnSellYourServices: UIButton!
    
    @IBOutlet var secondbgView: UIView!
    
    
    var arrAnwer:[NotificationData] = []
    
    var questionId:[[String:Any]] = []
    
    var proximity:NotificationData!
    var reminder:NotificationData!
    
    var myAnswers:SelectedQuestionData!
    var reminderValue = ""
    var getQueId = ""
    var getMyProxymity = ""
    
    var selectedQuestion:[[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Utility.chnageBtnTitle(btn: btnSellYourServices)
        btnSellYourServices.layer.cornerRadius = btnSellYourServices.frame.size.height / 2
        btnSellYourServices.layer.borderWidth = 1
        btnSellYourServices.layer.borderColor = UIColor.white.cgColor
        btnSellYourServices.clipsToBounds = true
        
        
        OnOffSwitch.layer.cornerRadius = OnOffSwitch.frame.size.height / 2
        OnOffSwitch.clipsToBounds = true
        OnOffSwitch.layer.borderWidth =   1
        OnOffSwitch.layer.borderColor = UIColor.lightGray.cgColor
        
        
        self.bgview.layer.borderWidth = 0.5
        self.secondbgView.layer.borderWidth = 0.5
        
        self.bgview.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        self.secondbgView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        
        accountSettingsApicall()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func accountSettingsApicall(){
        
        KRProgressHUD.show()
        
        let params = ["user_id":"\(userDefaults.value(forKey: "user_id")!)"]
        
        UserManager.shared.accountSettings(parmas: params) { (success, message , response,getMyAnswers) in

            if success == true{
                self.arrAnwer = response
                self.myAnswers = getMyAnswers
                print(self.arrAnwer)
                
                self.proximity = self.arrAnwer[1]
                self.reminder = self.arrAnwer[0]
                self.lblNotification.text = self.reminder.anserList[0].strSetAnswerList!
                if self.myAnswers != nil{
                    let getReminder = self.myAnswers.bookingReminder!
                    
                    if getReminder == "1"{
                        self.OnOffSwitch.setOn(true, animated: true)
                        self.OnOffSwitch.isOn = true
                    }else{
                        self.OnOffSwitch.setOn(false, animated: true)
                        self.OnOffSwitch.isOn = false
                    }
                    
                    self.reminderValue = self.myAnswers.bookingReminder!
                    self.lblProxiay.text! = self.myAnswers.nearByProxymity!
                }else{
                    
                    self.lblProxiay.text! = self.proximity.anserList[0].strSetAnswerList!
                }
                KRProgressHUD.dismiss()

            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
            }
        }
    }
    
    @IBAction func btnProxiayAction(_ sender: UIButton) {
        
        var secondArray:[String] = []
        
        for i in self.proximity.anserList{
            secondArray.append(i.strSetAnswerList!)
        }
        
        guard secondArray.count != 0 else {
            return
        }
        
            self.lblProxiay.text = secondArray[0]
            let alert = UIAlertController(style: .actionSheet, title: "", message: "Proximity")
            let pickerViewValues: [String] = secondArray
            // let frameSizes: [CGFloat] = (150...400).map { CGFloat($0) }
            let index = secondArray.first
            let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: secondArray.index(of: index!) ?? 0)
            
            alert.addPickerView(values: [pickerViewValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
                self.lblProxiay.text = secondArray[index.row]
                self.getQueId = self.proximity.anserList[index.row].strSetAnswerQueId!
                self.getMyProxymity = self.lblProxiay.text!
                
                alert.dismiss(animated: true, completion: nil)
                self.postAccountSettings()
            }
        
            alert.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.default, handler: { (action) in
                
            }))
        
            alert.show()
        
        
    }
    @IBAction func switchAction(_ sender: UISwitch) {
    
        if sender.isOn == true{
            sender.tintColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
            
        }
        else{
            sender.tintColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
            
        }
        
    
    }
    
    @IBAction func btnNotificatioAaction(_ sender: UIButton) {
        UIView.transition(with: sender, duration: 0.3, options: UIViewAnimationOptions.curveEaseInOut, animations: {

            if self.OnOffSwitch.isOn == true{
                self.OnOffSwitch.setOn(false, animated: true)
                self.reminderValue = "0"
            }
            else {
                self.OnOffSwitch.setOn(true, animated: true)
                self.reminderValue = "1"
            }
            
        }, completion: nil)

        self.postAccountSettings()
    }
    func postAccountSettings(){
     //{"get_reminder":"0","get_proximity":"20","user_id":"50"}
        KRProgressHUD.show()
        if OnOffSwitch.isOn == true{
            self.reminderValue = "1"
        }else{
            self.reminderValue = "0"
        }
        
        let params = ["get_reminder":"\(self.reminderValue)","get_proximity":"\(self.lblProxiay.text!)","user_id":"\(userDefaults.value(forKey: "user_id")!)"] as [String:Any]
        //postAccountSettings
        
        UserManager.shared.postAccountSettings(parmas: params) { (success, message) in
            
            if success == true{
                
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
            }
            self.perform(#selector(self.delayAction), with: nil, afterDelay: 1.3)
        }
        
    }
    
    @objc func delayAction(){
        KRProgressHUD.dismiss()
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
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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

