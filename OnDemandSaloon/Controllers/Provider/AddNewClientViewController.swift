//
//  AddNewClientViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 22/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD
import SDWebImage

class AddNewClientViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imgClient: UIImageView!
    
    @IBOutlet weak var txtFieldName: UITextField!
    
    @IBOutlet weak var txtFieldLastName: UITextField!
    
    @IBOutlet weak var txtFlieldEmail: UITextField!
    @IBOutlet weak var txtFieldPhoneNumber: UITextField!
    
    @IBOutlet weak var txtFieldBirthDate: UITextField!
    
    @IBOutlet weak var tctFieldPostalCode: UITextField!
    @IBOutlet weak var txtFieldCity: UITextField!
    @IBOutlet weak var txtFieldStreet: UITextField!
    
    @IBOutlet weak var streetBackView: UIView!
    @IBOutlet weak var cityBackView: UIView!
    
    @IBOutlet weak var postalCodeBackView: UIView!
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnUser: UIButton!
    
    
    
    var name = ""
    var location = ""
    var number = ""
    var email = ""
    var birth = ""
    var last = ""
    var area = ""
    var isShow = false
    let window = UIApplication.shared.keyWindow
    var tabbarController = ManageLoginTabBarController()
    
    var getObject :ClientLisiting!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.firstCode()
        
//        let picker = UIDatePicker()
//        picker.datePickerMode = .date
//        picker.addTarget(self, action: #selector(updateDateField(sender:)), for: .valueChanged)
        
        // If the date field has focus, display a date picker instead of keyboard.
        // Set the text to the date currently displayed by the picker.
        //self.txtFieldBirthDate.inputView = picker
        //self.txtFieldBirthDate.text = formatDateForDisplay(date: picker.date)
        
        if isShow{
            btnSave.setTitle("Update", for: UIControlState.normal)
            
        }else{
            btnSave.setTitle("Save", for: UIControlState.normal)
        }
        
        self.btnUser.addTarget(self, action: #selector(btnUserAction(_:)), for: UIControlEvents.touchUpInside)
        
        self.btnUser.layer.borderWidth = 1
        self.btnUser.layer.borderColor = UIColor.white.cgColor
        self.btnUser.layer.cornerRadius = 15
        tabBarController?.tabBar.isHidden = false
        
        self.addorCleaData()
        
        // Do any additional setup after loading the view.
    }
    
    func addorCleaData(){
        if isShow == true{
            self.txtFieldCity.text = getObject.strClCity
            self.txtFieldName.text = getObject.strClFname
            self.txtFieldStreet.text = getObject.strClStreet
            self.txtFlieldEmail.text = getObject.strClEmail
            self.txtFieldLastName.text = getObject.strClLName
            self.txtFieldBirthDate.text = getObject.strClBirthday
            self.txtFieldPhoneNumber.text = getObject.strClPhone
            self.tctFieldPostalCode.text = getObject.strClPostcode
            self.imgClient.sd_setImage(with: URL(string: getObject.strClImage!), completed: nil)
        }else {
            self.txtFieldCity.text = ""
            self.txtFieldName.text = ""
            self.txtFieldStreet.text = ""
            self.txtFlieldEmail.text = ""
            self.txtFieldLastName.text = ""
            self.txtFieldBirthDate.text = ""
            self.txtFieldPhoneNumber.text = ""
            self.tctFieldPostalCode.text = ""

        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if appDelegate.changeStoryBoard == true{
            self.tabBarController?.tabBar.isHidden = true
            
        }else{
            self.tabBarController?.tabBar.isHidden = false
            
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.imgClient.layer.cornerRadius = self.imgClient.frame.size.height / 2
        self.imgClient.clipsToBounds = true
        self.imgClient.layer.borderWidth = 1
        self.imgClient.layer.borderColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1).cgColor
    }
    
    @objc func btnUserAction(_ sender:UIButton){
        
        if let userLoginFlag = userDefaults.value(forKey: "user_id") as? String{
            
            let sBoard = UIStoryboard.init(name: "User", bundle: nil)
            let vc = sBoard.instantiateViewController(withIdentifier: "UserTabBar") as! UserTabBarController
            //        vc.hidesBottomBarWhenPushed = false
            vc.hidesBottomBarWhenPushed = true
            vc.loadViewIfNeeded()
            appDelegate.changeStoryBoard = true
            userDefaults.set("user", forKey: "lastLogin")
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            loadHomePage()
        }
 
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func updateDateField(sender: UIDatePicker) {
        self.txtFieldBirthDate.text = formatDateForDisplay(date: sender.date)
    }
    fileprivate func formatDateForDisplay(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveAction(_ sender: UIButton) {
        
        guard txtFieldName.text! != "" else {
            Utility.showAlert(vc: self, strMessage: "Please enter client first name.", alerttitle: "")
            return
        }
        
        guard txtFieldLastName.text! != "" else {
            Utility.showAlert(vc: self, strMessage: "Please enter client last name.", alerttitle: "")
            return
        }
        
        guard txtFieldPhoneNumber.text! != "" else {
            Utility.showAlert(vc: self, strMessage: "Please enter phone number.", alerttitle: "")
            return
        }
        guard Utility.isValidEmail(testStr: txtFlieldEmail.text!) else {
            
            Utility.showAlert(vc: self, strMessage: "Please enter email properly.", alerttitle: "")
            return
        }
        guard txtFieldBirthDate.text! != "" else {
            Utility.showAlert(vc: self, strMessage: "Please enter birth date.", alerttitle: "")
            return
        }
        
        guard txtFieldCity.text! != "" else {
            Utility.showAlert(vc: self, strMessage: "Please enter city.", alerttitle: "")
            return
        }
        
        guard txtFieldCity.text! != "" else {
            Utility.showAlert(vc: self, strMessage: "Please enter street.", alerttitle: "")
            return
        }
        
        guard txtFieldCity.text! != "" else {
            Utility.showAlert(vc: self, strMessage: "Please enter city.", alerttitle: "")
            return
        }
        
        
        if isShow{
            self.editClientCallAPI()
        }else{
            self.addClent()
        }
      
    }
    
    
    func firstCode(){
        self.postalCodeBackView.layer.borderWidth = 0.5
        self.postalCodeBackView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        
        self.streetBackView.layer.borderWidth = 0.5
        self.streetBackView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        
        self.cityBackView.layer.borderWidth = 0.5
        self.cityBackView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
    
        
        //placeholder Color
        Utility.setTexField(txtField: self.txtFlieldEmail, placeHolderName: "Email")
        Utility.setTexField(txtField: self.txtFieldPhoneNumber, placeHolderName: "Phone Number")
        Utility.setTexField(txtField: self.txtFieldBirthDate, placeHolderName: "Birthday")
        Utility.setTexField(txtField: self.txtFieldStreet, placeHolderName: "Street")
        Utility.setTexField(txtField: self.txtFieldCity, placeHolderName: "City")
        Utility.setTexField(txtField: self.tctFieldPostalCode, placeHolderName: "Postalcode")
        Utility.setTexField(txtField: self.txtFieldName, placeHolderName: "Name")
        Utility.setTexField(txtField: self.txtFieldLastName, placeHolderName: "Last Name")
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == tctFieldPostalCode{
            if range.location < 6{
                return true

            }else{
                return false
            }
        }
        return true
    }
    
    
    func addClent(){
        KRProgressHUD.show()
        let addClentParmas = ["cl_fname":"\(txtFieldName.text!)","cl_lname":"\(txtFieldLastName.text!)","cl_phone":"\(txtFieldPhoneNumber.text!)","cl_email":"\(txtFlieldEmail.text!)","cl_birthday":"\(txtFieldBirthDate.text!)","cl_street":"\(txtFieldStreet.text!)","cl_city":"\(txtFieldCity.text!)","cl_postcode":"\(tctFieldPostalCode.text!)","cl_provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        ProviderManager.shared.addOREditClient(parmas: addClentParmas, image: self.imgClient.image!, api: addClient) { (success, message) in
            if success == true{
                KRProgressHUD.dismiss({
                    let alert = UIAlertController(title: "Add Client", message: "\(message!)", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                })
                
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
                
            }
        }
        
    }
    
    func editClientCallAPI(){
        KRProgressHUD.show()
        let editClentParmas = ["cl_fname":"\(txtFieldName.text!)","cl_lname":"\(txtFieldLastName.text!)","cl_phone":"\(txtFieldPhoneNumber.text!)","cl_email":"\(txtFlieldEmail.text!)","cl_birthday":"\(txtFieldBirthDate.text!)","cl_street":"\(txtFieldStreet.text!)","cl_city":"\(txtFieldCity.text!)","cl_postcode":"\(tctFieldPostalCode.text!)","client_image":"","cl_provider_id":"\(userDefaults.value(forKey: "pro_id")!)","cl_id":"\(getObject.strClId!)"]
        
        ProviderManager.shared.addOREditClient(parmas: editClentParmas, image: self.imgClient.image!, api: editClient) { (success, message) in
            if success == true{
                KRProgressHUD.dismiss({
                    
                    let alert = UIAlertController(title: "Add Client", message: "\(message!)", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                })
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
                
            }
        }
        
    }
    
    func checkBlankText(txt:UITextField,alertMessage:String?){
        guard txt.text! != "" else {
             Utility.showAlert(vc: self, strMessage: "\(alertMessage)", alerttitle: "")
            return
        }
       
    }
    
    @IBAction func editImageAction(_ sender: UIButton) {
        selectImages()
    }
    
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
            self.imgClient.image = pickedimage
            picker.dismiss(animated: true, completion: nil)
        }else{
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "addNewEmployee"{
            let obj = segue.destination as! AddNewClientViewController
            tabBarController?.tabBar.isHidden = false
        }
    }
 

}
