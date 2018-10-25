//
//  SiginInWithEmailViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 12/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class SiginInWithEmailViewController: UIViewController {

    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var txtFieldEmail: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0, alpha: 1.0).cgColor
        self.emailView.layer.borderWidth = 1
        self.emailView.layer.cornerRadius = 5
        
        
        
//        self.txtFieldEmail.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)])
        // Do any additional setup after loading the view.
    }

    @IBAction func btnSubmitAction(_ sender: UIButton) {
        
//        guard Utility.isValidEmail(testStr: txtFieldEmail.text!) && txtFieldEmail.text! != "" else {
//
//            if txtFieldEmail.text! == ""{
//                Utility.errorAlert(vc: self, strMessage: "", errortitle: "Please enter your email address.")
//            }else {
//                Utility.errorAlert(vc: self, strMessage: "", errortitle: "Please enter your email address properly.")
//            }
//
//            return
//        }
        if txtFieldEmail.text?.isEmpty == true{
            Utility.errorAlert(vc: self, strMessage: "", errortitle: "Please enter your email address.")
        }
        else if Utility.isValidEmail(testStr: txtFieldEmail.text!) == false{
            Utility.errorAlert(vc: self, strMessage: "", errortitle: "Please enter your valid email address.")
        }else{
            let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
            let disVC = storyboard.instantiateViewController(withIdentifier: "UserRegisterViewController") as? UserRegisterViewController
            disVC?.userEmailId = txtFieldEmail.text
            self.navigationController?.pushViewController(disVC!, animated: true)
        }
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
