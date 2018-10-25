//
//  PaymentCompleteVC.swift
//  SalonApp
//
//  Created by MANISH CHAUHAN on 7/18/18.
//  Copyright © 2018 MANISH CHAUHAN. All rights reserved.
//

import UIKit
import Braintree
import KRProgressHUD


class PaymentCompleteVC: UIViewController,BTAppSwitchDelegate,BTViewControllerPresentingDelegate {

    @IBOutlet var btnPayNow: UIButton!
    @IBOutlet weak var btnServices: UIButton!

    @IBOutlet weak var lblPrice: UILabel!
    var braintreeClient: BTAPIClient!
    
    var amount = ""
    var providerId = ""
    var date = ""
    var time = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnServices.layer.cornerRadius = self.btnServices.frame.size.height / 2
        
        self.btnServices.layer.borderColor = UIColor.white.cgColor
        self.btnServices.layer.borderWidth = 1
        
        self.lblPrice.text! = "AED\(amount)"
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Utility.chnageBtnTitle(btn: btnServices)
        if appDelegate.changeStoryBoard == true{
            appDelegate.changeStoryBoard = false
        }
        tabBarController?.tabBar.isHidden = true
        //tabBarController?.hidesBottomBarWhenPushed = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if appDelegate.changeStoryBoard == true{
            self.tabBarController?.tabBar.isHidden = true
        }else{
            self.tabBarController?.tabBar.isHidden = true
        }
        
        
    }
    
    func appSwitcherWillPerformAppSwitch(_ appSwitcher: Any) {
        
    }
    
    func appSwitcher(_ appSwitcher: Any, didPerformSwitchTo target: BTAppSwitchTarget) {
        
    }
    
    func appSwitcherWillProcessPaymentInfo(_ appSwitcher: Any) {
        
    }
    
    func paymentDriver(_ driver: Any, requestsPresentationOf viewController: UIViewController) {
        
    }
    
    func paymentDriver(_ driver: Any, requestsDismissalOf viewController: UIViewController) {
        
    }
    
    
    @IBAction func btnPayNowAction(_ sender: UIButton) {
        
        //self.payCheckOut()
        self.performSegue(withIdentifier: "CompletePaymentSegue", sender: nil)
    }

    
    func payCheckOut(){
        
        let braintreeClient = BTAPIClient(authorization: "sandbox_5vq7vvw3_b5xz9bj4nqycpkf4")
        let payPayDriver = BTPayPalDriver(apiClient: braintreeClient!)
        payPayDriver.viewControllerPresentingDelegate = self
        payPayDriver.appSwitchDelegate = self
        
        let request = BTPayPalRequest.init(amount: "\(amount)")
        request.currencyCode = "USD"
        
        payPayDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
            
            if let tokenizedPayPalAccount = tokenizedPayPalAccount{
                print("Got a nonce: \(tokenizedPayPalAccount.nonce)")
                self.payMentComplete(getNonce:"\(tokenizedPayPalAccount.nonce)")
                print(tokenizedPayPalAccount)
                let email = tokenizedPayPalAccount.email
                let firstName = tokenizedPayPalAccount.firstName
                let lastName = tokenizedPayPalAccount.lastName
                let phone = tokenizedPayPalAccount.phone
                
                let billingAddress = tokenizedPayPalAccount.billingAddress
                let shippingAddress = tokenizedPayPalAccount.shippingAddress
                
            }else if let responseErrror = error{
                print(error?.localizedDescription)
            }else{
                print(error?.localizedDescription)
            }
            
        }
    }
    
    @IBAction func sellYourServicesAction(_ sender: UIButton) {
        
        if let getLogin = userDefaults.value(forKey: "pro_id") as? String{
                moveToProvider()
        }else{
            createPopUpp()
            
        }
    }
    
    func payMentComplete(getNonce:String?){
        
        let params = ["Nounce":"\(getNonce!)","Amount":"\(amount)","Date":"\(date)","Time":"\(time)","P_id":"\(providerId)","User_Id":"\(userDefaults.value(forKey: "user_id")!)","Role":"2"]
        
        KRProgressHUD.show()
        
        UserManager.shared.paymentAPI(parmas:params) { (success, message) in
            
            if success == true{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: message!, alerttitle: "")
                })
            }else{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: message!, alerttitle: "")
                })
            }
            
        }
        
    }
    
    @objc func createPopUpp(){
        Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "PaymentCompleteVC", isLogin: false, isService: true )
    }
    
    @objc func moveToProvider(){
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "CompletePaymentSegue"{
            let vc = segue.destination as! Payment_ConfirmedVC
        }
        
    }
 

}
