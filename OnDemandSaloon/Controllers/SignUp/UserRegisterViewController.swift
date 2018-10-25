//
//  UserRegisterViewController.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 12/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD

class UserRegisterViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtFieldEmail: UITextField!
    
    @IBOutlet weak var txtFieldFirstName: UITextField!
    
    @IBOutlet weak var txtFieldLastName: UITextField!
    
    @IBOutlet weak var txtFieldPhoneNumber: UITextField!
    
    @IBOutlet weak var txtFieldPassword: UITextField!
    
    var userEmailId:String!
 
    let window = UIApplication.shared.keyWindow!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.txtFieldEmail.text = userEmailId

        Utility.setTexField(txtField: txtFieldEmail, placeHolderName: "Email")
        Utility.setTexField(txtField: txtFieldFirstName, placeHolderName: "First Name")
        Utility.setTexField(txtField: txtFieldLastName, placeHolderName: "Last Name")
        Utility.setTexField(txtField: txtFieldPhoneNumber, placeHolderName: "Phone Number")
        Utility.setTexField(txtField: txtFieldPassword, placeHolderName: "Password(4 Digits)")

        
        // Do any additional setup after loading the view.
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtFieldPassword{
            
            if range.location < 4{
                return true
            }else{
                return false
            }
            
        }
        
        return true
    }
    

    @IBAction func closeAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtn(_ sender: UIButton) {
        
                guard Utility.isValidEmail(testStr: txtFieldEmail.text!) && txtFieldEmail.text! != "" else {
        
                    if txtFieldEmail.text! == ""{
                        Utility.errorAlert(vc: self, strMessage: "", errortitle: "Please enter your email address.")
                    }else {
                        Utility.errorAlert(vc: self, strMessage: "", errortitle: "Please enter your email address properly.")
                    }
        
                    return
                }
        
                guard txtFieldFirstName.text! != "" else {
                    Utility.errorAlert(vc: self, strMessage: "", errortitle: "Please enter your first name.")
                    return
                }
        
                guard txtFieldLastName.text! != "" else {
                    Utility.errorAlert(vc: self, strMessage: "", errortitle: "Please enter your last name.")
                    return
                }
                guard  txtFieldPhoneNumber.text! != "" else {
                    Utility.errorAlert(vc: self, strMessage: "", errortitle: "Please enter your phone number.")
                    return
                }
        
                guard  txtFieldPassword.text! != "" else {
                    Utility.errorAlert(vc: self, strMessage: "", errortitle: "Please enter your password.")
                    return
                }
        
            register()

    }
    
    //Move to User Home tabbar
    
    func moveToUserHome(){
        if let userLogin = userDefaults.value(forKey: "userLogin") as? Bool{
            if userLogin == false{
                
                appDelegate.userLogin = true
                appDelegate.changeStoryBoard = true
                Utility.storeUserFlag(flag:true)
                userDefaults.set(true, forKey: "userLogin")
                userDefaults.synchronize()
                
                let storieBoard = UIStoryboard.init(name: "User", bundle: nil)
                let vc = storieBoard.instantiateViewController(withIdentifier: "UserTabBar") as! UITabBarController
                vc.loadViewIfNeeded()
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    
    // MARK User Register Api calling
    
    func register()  {

        KRProgressHUD.show()
        
        let params = ["user_fname":"\(txtFieldFirstName.text!)","user_lname":"\(txtFieldLastName.text!)","user_phone":"\(txtFieldPhoneNumber.text!)","user_email":"\(txtFieldEmail.text!)","user_password":"\(txtFieldPassword.text!)","latitude":"123","longitude":"123","role":"2","device_token":"abc","device_type":"2"]
        
        UserManager.shared.register(parametrs: params, completion:{ (success,message)  in
            if success == true{
                print("success")
                if success == false{

                    self.moveToUserHome()
                    
                    KRProgressHUD.dismiss()
                }
            }else{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: "\(message!)", alerttitle: "")
                })
            }
        })
        
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
