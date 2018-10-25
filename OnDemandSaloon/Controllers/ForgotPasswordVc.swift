//
//  ForgotPasswordVc.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 31/05/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD

class ForgotPasswordVc: UIViewController {

    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var forgotPassView: UIView!
    
    @IBOutlet weak var forgotPasswordTxt: UITextField!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    var isUser :Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        outerView.clipsToBounds = false
//        outerView.layer.shadowColor = UIColor.black.cgColor
//        outerView.layer.shadowOpacity = 1
//        outerView.layer.shadowOffset = CGSize.zero
//        outerView.layer.shadowRadius = 10
//        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 10).cgPath
//
//        self.userImageView = UIImageView()
        self.userImageView.layer.cornerRadius = self.userImageView.frame.size.height / 2
        self.userImageView.clipsToBounds = true
        
        self.userImageView.layer.shadowColor = UIColor.black.cgColor
        self.userImageView.layer.shadowOpacity = 2
        self.userImageView.layer.shadowOffset = CGSize.zero
        self.userImageView.layer.shadowRadius = 5
//        self.userImageView.layer.shadowPath = UIBezierPath(roundedRect: self.userImageView.bounds, cornerRadius: self.userImageView.frame.size.height / 2).cgPath
        
       self.forgotPassView.layer.borderWidth = 1
        self.forgotPassView.layer.cornerRadius = 4
        
            self.forgotPassView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0, alpha: 1.0).cgColor
        forgotPasswordTxt.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: [NSAttributedStringKey.foregroundColor:txtBlueColor])
        // Do any additional setup after loading the view.
    }

    func forgotPassApi(){
        
        KRProgressHUD.show()
        let params :[String:String]!
        
        if isUser == true{
            params = ["user_email": "\(forgotPasswordTxt.text!)","role":"2"]
        }else{
            params = ["user_email": "\(forgotPasswordTxt.text!)","role":"1"]
        }
        
        
        UserManager.shared.forgotPass(parametrs: params) { (success,message) in
            
            if success == true {
                KRProgressHUD.dismiss()
                //AlertSingle(title: "Please check your email inbox for reset password.")
                
                let alert = UIAlertController(title: "", message: "Please check your email inbox for reset password.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
            }
            else
            {
                KRProgressHUD.dismiss()
                Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
//        let alert = UIAlertController(title: "", message: "Please check your email inbox for reset password.", preferredStyle: UIAlertControllerStyle.alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
//            self.navigationController?.popViewController(animated: true)
//        }))
//        self.present(alert, animated: true, completion: nil)
        forgotPassApi()
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
