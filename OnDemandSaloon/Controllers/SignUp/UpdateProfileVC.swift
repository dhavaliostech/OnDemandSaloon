//
//  updateProfileVC.swift
//  demo1
//
//  Created by PS on 01/08/18.
//  Copyright © 2018 PS. All rights reserved.
//

import UIKit
import KRProgressHUD
import SDWebImage

class UpdateProfileVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var mobileNoBackView: UIView!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var lastNameBackView: UIView!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var firstNameBackView: UIView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var emailBackView: UIView!
    @IBOutlet weak var imgUserProfile: UIImageView!
    
    @IBOutlet weak var btnSellYourService: UIButton!
    
    
    var profileObj :ProfileAdd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utility.chnageBtnTitle(btn: btnSellYourService)
        self.imgUserProfile.layer.cornerRadius = self.imgUserProfile.frame.size.height / 2
        self.imgUserProfile.clipsToBounds = true
        self.imgUserProfile.layer.borderWidth = 1
        self.imgUserProfile.layer.borderColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1).cgColor
        emailBackView.layer.borderWidth = 1
        emailBackView.layer.cornerRadius = 4
        emailBackView.clipsToBounds = true
        emailBackView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0,alpha: 1.0).cgColor
        
        firstNameBackView.layer.borderWidth = 1
        firstNameBackView.layer.cornerRadius = 4
        firstNameBackView.clipsToBounds = true
        firstNameBackView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0, alpha: 1.0).cgColor
        
        lastNameBackView.layer.borderWidth = 1
        lastNameBackView.layer.cornerRadius = 4
        lastNameBackView.clipsToBounds = true
        lastNameBackView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0, alpha: 1.0).cgColor
        
        mobileNoBackView.layer.borderWidth = 1
        mobileNoBackView.layer.cornerRadius = 4
        mobileNoBackView.clipsToBounds = true
        mobileNoBackView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0, alpha: 1.0).cgColor
        
    
        self.txtEmail.text! = "\(profileObj.strUserEmail!)"
        self.txtFirstName.text! = "\(profileObj.strUserFname!)"
        self.txtLastName.text! = "\(profileObj.strUserLname!)"
        self.txtMobileNo.text! = "\(profileObj.strUserPhone!)"
        self.imgUserProfile.sd_setImage(with: URL(string: "\(profileObj.strUserAvatar!)"), completed: nil)
        
        self.btnSellYourService.layer.cornerRadius = self.btnSellYourService.frame.size.height / 2
        
        self.btnSellYourService.layer.borderColor = UIColor.white.cgColor
        self.btnSellYourService.layer.borderWidth = 1
        
        // Do any additional setup after loading the view.
    }

    func getUapadteProfile(){
        
        KRProgressHUD.show()

        let updateParmiter = ["id":"\(profileObj.strId!)","user_fname": "\(txtFirstName.text!)","user_lname": "\(txtLastName.text!)","user_phone": "\(txtMobileNo.text!)", "role": "2", "device_type": "2"]
        
        ProfileManager.shared.editProfile(parmas: updateParmiter, image: imgUserProfile.image!) { (success) in
            
            if success{
                
                let alert = UIAlertController(title: "", message: "Your profile is successfully updated.", preferredStyle: UIAlertControllerStyle.alert)
 
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (updateProfile) in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                
            }else{
                Utility.errorAlert(vc: self, strMessage: "Something went wrong, Please try again.", errortitle: "")
            }
            KRProgressHUD.dismiss()
        }
        
    }
    
    @IBAction func sellYourServicesAction(_ sender: UIButton) {
        
        if let getLogin = userDefaults.value(forKey: "pro_id") as? String{
            
            moveToProvider()
            
        }else{
            createPopUpp()
            
        }
    }
    
    @objc func createPopUpp(){
        Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "UpdateProfileVC", isLogin: false, isService: true )
    }
    
    @objc func moveToProvider(){
        let sBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
        appDelegate.changeStoryBoard = true
        userDefaults.set("provider", forKey: "lastLogin")
        //tabBarController?.hidesBottomBarWhenPushed = true
        vc.hidesBottomBarWhenPushed = true
        vc.loadViewIfNeeded()
        
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK :- Button Action
    
    @IBAction func btnUpdateAction(_ sender: UIButton)
    {
       
       getUapadteProfile()
        
//        if txtFirstName.text != nil{
//
//        }else if txtLastName.text != nil
//        {
//
//        }else if (txtMobileNo.text?.count)! > 14 && (txtMobileNo.text?.count)! < 10
//        {
//            print("Not Validte")
//        }
//        else {
//            print("Success")
//            getUapadteProfile()
//        }
       
    }
    
    @IBAction func btnAddPhotoaction(_ sender: UIButton) {
        selectImages()
    }
    
    // MARK:- func Choose images
    func selectImages(){
        let actionSheet = UIAlertController(title: "Choose Image option", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { (action) in
            
            if(UIImagePickerController.isSourceTypeAvailable(.camera)){
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .camera
                imagePicker.delegate = self
                
                self.present(imagePicker, animated: true, completion: nil)
                
            }
            else {
                
                let alertView = UIAlertController(title: "Camera Not Available", message: "Please use a device which is capable to take a picture", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                }))
                self.present(alertView, animated: true, completion: nil)
            }
            
        }))
        
       
        let action = UIAlertAction(title: "Select Photo From Gallery", style: .default, handler: {(action) in
            
            let imagePicker = UIImagePickerController();
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.mediaTypes = ["public.image"]
            self.present(imagePicker, animated: true, completion: nil)
            
        })
        actionSheet.addAction(action)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            
        }))
        if UIDevice.current.userInterfaceIdiom == .pad{
            if let popoverController = actionSheet.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.frame.size.width/3, y: self.view.frame.size.height/4, width: self.view.frame.size.width/4, height: self.view.frame.size.height/4)
                popoverController.sourceView?.center = (self.view?.center)!
            }
            self.present(actionSheet, animated: true, completion: nil)
        }
        else{
            
            self.present(actionSheet, animated: true, completion: nil)
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imgUserProfile.image = pickedimage
             picker.dismiss(animated: true, completion: nil)
        }else{
             picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
