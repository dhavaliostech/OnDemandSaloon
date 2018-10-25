//
//  LoginVC.swift
//  OnDemandSaloon
//
//  Created by Pratik Zankat on 29/05/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD
class LoginVC: UIViewController {

    @IBOutlet var passwordBackView: UIView!
    @IBOutlet var emailBcackView: UIView!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var icon_User: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailBcackView.layer.borderWidth = 1
        emailBcackView.layer.cornerRadius = 4
        emailBcackView.clipsToBounds = true
        emailBcackView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0, alpha: 1.0).cgColor
        passwordBackView.layer.borderWidth = 1
        passwordBackView.layer.cornerRadius = 4
        passwordBackView.clipsToBounds = true
        passwordBackView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0, alpha: 1.0).cgColor
        txtEmail.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedStringKey.foregroundColor:txtBlueColor])
        txtPassword.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor:txtBlueColor])
        
        

        // Do any additional setup after loading the view.
    }

    @IBAction func btnCloseaction(_ sender: UIButton) {
       self.navigationController?.popViewController(animated: true)
        
    }
    
   
    
    @IBAction func btnLoginaction(_ sender: UIButton) {
        if txtEmail.text?.isEmpty == true
        {
            //AlertSingle(title: "Please enter your email address")
            Utility.errorAlert(vc: self, strMessage: "Please enter your email address", errortitle: "Authentication Error")
        }
        else if isValidEmail(testStr: txtEmail.text!) == false
        {
            //AlertSingle(title: "Please enter proper email address")
            Utility.errorAlert(vc: self, strMessage: "Please enter proper email address", errortitle: "Authentication Error")
        }
        else if txtPassword.text?.isEmpty == true
        {
            //AlertSingle(title: "Please enter your password")
            Utility.errorAlert(vc: self, strMessage: "Please enter your password", errortitle: "Authentication Error")
        }
        else
        {
            //user_Login()
        }
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
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
//        if segue.identifier == "gotoHome"
//        {
//            let des = segue.destination as!
//        }
    }
    

}
