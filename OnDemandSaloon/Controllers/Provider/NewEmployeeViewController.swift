//
//  NewEmployeeViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 22/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD

class NewEmployeeViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SendCatToEmployee,SendHourToEmployee {

    @IBOutlet weak var imgEmployee: UIImageView!
    
    @IBOutlet weak var txtFieldName: UITextField!
    
    @IBOutlet weak var txtFieldLastName: UITextField!
    
    @IBOutlet weak var selectCategoryView: UIView!
    
    @IBOutlet weak var selectedHourView: UIView!
    
    
    @IBOutlet weak var txtFieldPhoneNumber: UITextField!
    
    @IBOutlet weak var txtFieldEmail: UITextField!
    
    @IBOutlet weak var txtFieldBirthDate: UITextField!
    
    
    @IBOutlet weak var lblSelectedHour: UILabel!
    
    @IBOutlet weak var lblSelectedCategory: UILabel!
    @IBOutlet weak var btnUser: UIButton!
    
    @IBOutlet weak var lblAddCategory: UILabel!
    @IBOutlet weak var lblAddWorkingHours: UILabel!
    
    var empoyeeObj:EmployeeList!
    
    var isEdit  = false
    
    var catArray : [ProviderCat] = []
    var hoursArray:[WorkingDayHours] = []
    
    
    @IBOutlet weak var mainView: UIView!
    var workingHours:[String] = []
    @IBOutlet weak var catConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var workingHourConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var mainViewHeightConstraint: NSLayoutConstraint!
    let window = UIApplication.shared.keyWindow
    var tabbarController = ManageLoginTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.firstCode()
        
        self.btnUser.layer.borderWidth = 1
        self.btnUser.layer.borderColor = UIColor.white.cgColor
        self.btnUser.layer.cornerRadius = 15
        
        self.btnUser.addTarget(self, action: #selector(btnUserAction(_:)), for: UIControlEvents.touchUpInside)
        
        self.catConstraint.constant = self.lblAddCategory.intrinsicContentSize.height
        self.workingHourConstraint.constant = self.lblAddWorkingHours.intrinsicContentSize.height
        self.mainViewHeightConstraint.constant = self.mainView.intrinsicContentSize.height
        
        if isEdit == true{
            txtFieldName.text = empoyeeObj.emFName!
            txtFieldEmail.text = empoyeeObj.emEmail!
            txtFieldLastName.text = empoyeeObj.emLName!
            txtFieldBirthDate.text = empoyeeObj.emBirthday!
            txtFieldPhoneNumber.text = empoyeeObj.emPhone!
            imgEmployee.sd_setImage(with: URL(string: empoyeeObj.emImage!), completed: nil)
            self.lblSelectedHour.text! = "Working Hours"
            self.lblSelectedCategory.text! = "Category"
            var serviceString = ""
            
            for i in empoyeeObj.emServices{
                
                self.catArray.append(ProviderCat(dict: ["ser_name":"\(i.ser_name!)","ser_id":"\(i.ser_id!)"]))
                
            }
    
            
            for i in catArray{
                
                if serviceString == ""{
                    serviceString = "\(i.mainCat!)"
                }else{
                    serviceString = "\(serviceString) \n\(i.mainCat!)"
                }
                self.lblAddCategory.text! = serviceString

                self.catConstraint.constant = self.lblAddCategory.intrinsicContentSize.height
                self.mainViewHeightConstraint.constant = self.mainView.intrinsicContentSize.height
                
            }
            
            
            for i in empoyeeObj.emTime{
                self.hoursArray.append(WorkingDayHours(w_day: i.emp_oh_day!, sTime: i.emp_oh_start_time!, eTime: i.emp_oh_end_time!))
            }
            
            var timeString = ""
            for i in self.hoursArray{
                
                if timeString == ""{
                    timeString = "\(i.day!) \(i.startTime!) - \(i.endTime!)"
                }else{
                    timeString = "\(timeString) \n\(i.day!) \(i.startTime!) - \(i.endTime!)"
                }
                self.lblAddWorkingHours.text! = timeString
                self.workingHourConstraint.constant = self.lblAddWorkingHours.intrinsicContentSize.height
                self.mainViewHeightConstraint.constant = self.mainView.intrinsicContentSize.height
                
            }
            
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func firstCode(){
        self.selectCategoryView.layer.borderWidth = 0.5
        self.selectCategoryView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        
        self.selectedHourView.layer.borderWidth = 0.5
        self.selectedHourView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        
        //placeholder Color
        Utility.setTexField(txtField: txtFieldEmail, placeHolderName: "Email")
        Utility.setTexField(txtField: txtFieldPhoneNumber, placeHolderName: "Phone Number")
        Utility.setTexField(txtField: txtFieldBirthDate, placeHolderName: "Birthday")
        Utility.setTexField(txtField: txtFieldName, placeHolderName: "First Name")
        Utility.setTexField(txtField: txtFieldLastName, placeHolderName: "Last Name")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if appDelegate.changeStoryBoard == true{
            appDelegate.changeStoryBoard = false
        }
        
        self.tabBarController?.tabBar.isHidden = false
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
        setLayOut()
    }

    func setLayOut(){
        self.imgEmployee.layer.cornerRadius = self.imgEmployee.frame.size.height / 2
        self.imgEmployee.clipsToBounds = true
        self.imgEmployee.layer.borderWidth = 1
        self.imgEmployee.layer.borderColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1).cgColor
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
    
    //Mark : DelegateMethod
    func SendToEmployee(mainCat: [ProviderCat]?) {
        if mainCat?.count != 0{
            catArray.removeAll()
        }
        catArray = mainCat!
        var getCatString = ""
        for i in catArray{
            
            if getCatString == ""{
                getCatString = "\(i.mainCat!)"
            }else{
                getCatString = "\(getCatString) \n\(i.mainCat!)"
            }
            self.lblAddCategory.text! = getCatString
            self.catConstraint.constant = self.lblAddCategory.intrinsicContentSize.height
            self.mainViewHeightConstraint.constant = self.mainView.intrinsicContentSize.height
        }
        //setLayOut()
    }
    func SendToEmployeeHours(hoursAndDay: [WorkingDayHours]?) {
        if hoursAndDay?.count != 0{
            hoursArray.removeAll()
        }
        
        hoursArray = hoursAndDay!
        var timeString = ""
        for i in hoursArray{
            
            if timeString == ""{
                timeString = "\(i.day!) \(i.startTime!) - \(i.endTime!)"
            }else{
                timeString = "\(timeString) \n\(i.day!) \(i.startTime!) - \(i.endTime!)"
            }
            self.lblAddWorkingHours.text! = timeString
            self.workingHourConstraint.constant = self.lblAddWorkingHours.intrinsicContentSize.height
            self.mainViewHeightConstraint.constant = self.mainView.intrinsicContentSize.height
        }
    }
    
    
    //Mark: Action Methods
    
    @objc func btnUserAction(_ sender:UIButton){
        
        if let userLoginFlag = userDefaults.value(forKey: "user_id") as? String{
            
            loadHomePage()
            
        }else{
            let sBoard = UIStoryboard.init(name: "User", bundle: nil)
            let vc = sBoard.instantiateViewController(withIdentifier: "UserTabBar") as! UserTabBarController
            //        vc.hidesBottomBarWhenPushed = false
            vc.hidesBottomBarWhenPushed = true
            userDefaults.set("user", forKey: "lastLogin")
            appDelegate.changeStoryBoard = true
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
    }

    @IBAction func selectCategoryAction(_ sender: UIButton) {
        
        let sBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "AddServicesCategoryVC") as! AddServicesCategoryVC
//        vc.hidesBottomBarWhenPushed = true
        vc.employeeGetCat = true
        vc.delegateForEmployee = self
        vc.fromEmployeeCat = self.catArray
        vc.loadViewIfNeeded()
        appDelegate.changeStoryBoard = true
        self.navigationController?.pushViewController(vc, animated: true)
   
    }
    
    @IBAction func selectHourAction(_ sender: UIButton) {
        let sBoard = UIStoryboard.init(name: "SignUp", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "Work_day_VC") as! Work_day_VC
        vc.employeeGetHour = true
        vc.delegateForEmployee = self
        
        vc.fromEmployee = self.hoursArray
        vc.loadViewIfNeeded()
        appDelegate.changeStoryBoard = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnSaveAction(_ sender: UIButton) {
        if isEdit == true{
            editEmployeeAPI()
        }else{
            addEmployeeAPI()
        }
    }

    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func addOrEditImageAction(_ sender: UIButton) {
        selectImages()
    }
    
    
    //Mark: API
    func addEmployeeAPI(){
        
        KRProgressHUD.show()

        var objForCat : [[String:Any]] = []
        var objForHours : [[String:Any]] = []
        
        for i in catArray{
            let obj = ["category_id":"\(i.mainCatID!)"]
            objForCat.append(obj)
        }
        
        for j in hoursArray{
            let obj = ["oh_day":"\(j.day!)","oh_start_time":"\(j.startTime!)","oh_end_time":"\(j.endTime!)"]
            objForHours.append(obj)
        }
        
        let params = ["em_fname":"\(txtFieldName.text!)","em_lname":"\(txtFieldLastName.text!)","em_phone":"\(txtFieldPhoneNumber.text!)","em_email":"\(txtFieldEmail.text!)","em_birthday":"\(txtFieldBirthDate.text!)","em_services":objForCat,"em_time":objForHours,"em_street":"","em_added_by":"\(userDefaults.value(forKey: "pro_id")!)","em_city":""] as [String:Any]
       
        ProviderManager.shared.addOrEditEmployeeAPI(parmas: params, image: self.imgEmployee.image!, api: addEmployee) { (success, message) in
            
            if success == true
            {
                KRProgressHUD.dismiss({
                    let alert = UIAlertController(title: "Add Employee", message: "\(message!)", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                })
            }else{
                
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "Add Employee")
                })
                
            }
            
        }
       
    }
    
    func editEmployeeAPI(){
        
        KRProgressHUD.show()
        
        var objForCat : [[String:Any]] = []
        var objForHours : [[String:Any]] = []
        
        for i in catArray{
            let obj = ["category_id":"\(i.mainCatID!)"]
            objForCat.append(obj)
        }
        
        for j in hoursArray{
            let obj = ["oh_day":"\(j.day!)","oh_start_time":"\(j.startTime!)","oh_end_time":"\(j.endTime!)"]
            objForHours.append(obj)
        }
        
        let params = ["em_fname":"\(txtFieldName.text!)","em_lname":"\(txtFieldLastName.text!)","em_phone":"\(txtFieldPhoneNumber.text!)","em_email":"\(txtFieldEmail.text!)","em_birthday":"\(txtFieldBirthDate.text!)","em_services":objForCat,"em_time":objForHours,"em_street":"","em_added_by":"\(userDefaults.value(forKey: "pro_id")!)","em_city":"","em_id":"\(empoyeeObj.emId!)"] as [String:Any]
        
        let getImage = self.imgEmployee.image ?? UIImage()
        
        ProviderManager.shared.addOrEditEmployeeAPI(parmas: params, image: getImage, api: editEmployee) { (success, message) in
            
            if success == true{
                KRProgressHUD.dismiss({
                    let alert = UIAlertController(title: "Edit Employee", message: "\(message!)", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                })
            }else{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: "\(message!)", alerttitle: "Edit Employee")
                })
            }

        }
        
    }
    
   
    
    //Mark : Image Picker
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
    
    //addNewEmployee
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imgEmployee.image = pickedimage
            picker.dismiss(animated: true, completion: nil)
        }else{
            picker.dismiss(animated: true, completion: nil)
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
extension UILabel {
    
//    func retrieveTextHeight () -> CGFloat {
//        let attributedText = NSAttributedString(string: self.text!, attributes: [NSFontAttributeName:self.font])
//
//        let rect = attributedText.boundingRect(with: CGSize(width: self.frame.size.width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
//
//        return ceil(rect.size.height)
//    }
    
   // func retrieveTextHeight () ->
    
}
