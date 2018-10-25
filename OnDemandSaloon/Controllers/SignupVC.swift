//
//  SignupVC.swift
//  OnDemandSaloon
//
//  Created by Pratik Zankat on 30/05/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD
import CoreLocation
import GooglePlaces

class SignupVC: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet var nameBackView: UIView!
    
    @IBOutlet var txtConfirmPassword: UITextField!
    @IBOutlet var confirmPasswordBackView: UIView!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var passwordBackView: UIView!
    
    @IBOutlet var txtLocation: UITextField!
    @IBOutlet var locationBackView: UIView!
    @IBOutlet var txtPhoneNo: UITextField!
    @IBOutlet var phonenoBackView: UIView!
    @IBOutlet var txtNameofBusiness: UITextField!
    
    @IBOutlet weak var businessEmailView: UIView!
    @IBOutlet weak var txtBusinessEmail: UITextField!
    
    @IBOutlet weak var contryView: UIView!
    @IBOutlet weak var txtContry: UITextField!
    
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var txtCity: UITextField!
    
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var txtAddress: UITextField!
    
     @IBOutlet weak var btnFreelancers: UIButton!
    
    @IBOutlet weak var lblFreelancerNotes: UILabel!
    @IBOutlet weak var notesView: UIView!
    @IBOutlet weak var imgSaloons: UIImageView!
    @IBOutlet weak var imgFreelancer: UIImageView!
    @IBOutlet weak var btnSaloons: UIButton!
    var isHideBottomBar = false
    
    var BusinessLoaction = ""
    @IBOutlet var btnContinue: UIButton!
    var Location:[String] = ["Ahmadabad","Rajkot","Surat","Gondal"]
    fileprivate var alertStyle: UIAlertControllerStyle = .actionSheet
    var isBusinessLocation = false
    var arrservices:[ListOfMainCategories] = []
    var servicesList:[String] = []
    var locationManager = CLLocationManager()
    var userLatitude:Double!
    var userLongitude:Double!
    
    
    var allDataForSearchSalon:GetSearchData!
    var contryArr:[GetContry] = []
    var cityArr:[GetCities] = []
    var locationArr:[GetLocation] = []
    var arrLocation:[String] = []
    var registerServiceType = ""
    
    
   // var freeLancerStrin = "\()"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        
        //GetLetLong()
        getData()
        
        Utility.setTexField(txtField: txtNameofBusiness, placeHolderName: "Name of Your Business")
        Utility.setTexField(txtField: txtPhoneNo, placeHolderName: "Business Phone Number")
        Utility.setTexField(txtField: txtContry, placeHolderName: "Contry")
        Utility.setTexField(txtField: txtCity, placeHolderName: "Buissness City")
        Utility.setTexField(txtField: txtLocation, placeHolderName: "Buissness Location")
        Utility.setTexField(txtField: txtAddress, placeHolderName: "Address")
        Utility.setTexField(txtField: txtPassword, placeHolderName: "Password")
        Utility.setTexField(txtField: txtConfirmPassword, placeHolderName: "Confirm Password")
        Utility.setTexField(txtField: txtBusinessEmail, placeHolderName: "Buissness Email Address")
        self.txtContry.text! = "UAE"
        
        Utility.setBoarderAndColorOfView(getview: confirmPasswordBackView)
        confirmPasswordBackView.layer.cornerRadius = 4
        
        Utility.setBoarderAndColorOfView(getview: passwordBackView)
        passwordBackView.layer.cornerRadius = 4

        Utility.setBoarderAndColorOfView(getview: locationBackView)
        locationBackView.layer.cornerRadius = 4
        
        Utility.setBoarderAndColorOfView(getview: nameBackView)
        nameBackView.layer.cornerRadius = 4
        
        Utility.setBoarderAndColorOfView(getview: phonenoBackView)
        phonenoBackView.layer.cornerRadius = 4
        
        Utility.setBoarderAndColorOfView(getview: contryView)
        contryView.layer.cornerRadius = 4
        
        Utility.setBoarderAndColorOfView(getview: cityView)
        cityView.layer.cornerRadius = 4
        
        Utility.setBoarderAndColorOfView(getview: addressView)
        addressView.layer.cornerRadius = 4
        
        Utility.setBoarderAndColorOfView(getview: locationBackView)
        locationBackView.layer.cornerRadius = 4
        
        Utility.setBoarderAndColorOfView(getview: businessEmailView)
        businessEmailView.layer.cornerRadius = 4
        
        Utility.setBoarderAndColorOfView(getview: self.notesView)
        notesView.layer.cornerRadius = 4
        
        let formattedString = NSMutableAttributedString()
        
        //let first = formattedString.bold("")
        
        self.imgFreelancer.image = #imageLiteral(resourceName: "radioOn")
        self.registerServiceType = "1"
        
        self.imgSaloons.image = #imageLiteral(resourceName: "radioOff")
        
        self.lblFreelancerNotes.text = "You can choose only two categories and add unlimited services in those selected categories.\nYou are not able to add Employees.\nYou are able to change your account type in future as per your requirements to Saloons."
        
        
        
        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
//        if isHideBottomBar == true{
//            tabBarController?.tabBar.isHidden = false
//            tabBarController?.hidesBottomBarWhenPushed = false
//            
//        }
    }
    
    func getData(){
        KRProgressHUD.show()
        UserManager.shared.getSearchDataInSearchTab(param: [:]) { (success, responseData, message) in
            
            if success == true{
                
                self.allDataForSearchSalon = responseData
                self.contryArr = self.allDataForSearchSalon.contryArray
                self.cityArr = self.allDataForSearchSalon.cityArray
                self.locationArr = self.allDataForSearchSalon.locationArray

                let alert = UIAlertController(title: "", message: "\(message!)", preferredStyle: UIAlertControllerStyle.actionSheet)
                
                alert.addAction((UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (changePass) in
                    
                  self.performSegue(withIdentifier: "", sender: nil)
                })))
                KRProgressHUD.dismiss()
            }else{
                
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
                
            }
            
        }
        
    }
    
    func GetLetLong()
    {
        
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//
//        let location = locationManager.location?.coordinate
//        userLatitude = location?.latitude
//        userLongitude = location?.longitude
    }
    
    
    @IBAction func selectFreelancerORSaloonAction(_ sender: UIButton) {
        
        self.imgFreelancer.image =  #imageLiteral(resourceName: "radioOff")
        self.imgSaloons.image = #imageLiteral(resourceName: "radioOff")
        
        if sender.tag == 1{

                self.imgFreelancer.image = #imageLiteral(resourceName: "radioOn")
                self.registerServiceType = "1"
                self.lblFreelancerNotes.text = "You can choose only two categories and add unlimited services in those selected categories.\nYou are not able to add Employees.\nYou are able to change your account type in future as per your requirements to Saloons."
         
        }else{
        
            self.imgSaloons.image = #imageLiteral(resourceName: "radioOn")
            self.registerServiceType = "2"
             self.lblFreelancerNotes.text = "You can choose unlimited categories and add unlimited services in those selected categories.\nYou are able to add Employees.\nYou are able to change your account type in future as per your requirements to Freelancers."
    
        }
    
    }
    
    @IBAction func btnBackaction(_ sender: UIButton) {
        appDelegate.changeStoryBoard = true
        isHideBottomBar = true
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBAction func btnContinueaction(_ sender: UIButton) {

        guard self.txtNameofBusiness.text! != "" else {
            Utility.errorAlert(vc: self, strMessage: "Please enter buissness name.", errortitle: "")
            return
        }

        guard self.txtPhoneNo.text! != "" else {
            Utility.errorAlert(vc: self, strMessage: "Please enter your buissness phone number.", errortitle: "")
             return
        }

        guard self.txtContry.text! != "" else {
            Utility.errorAlert(vc: self, strMessage: "Please enter contry.", errortitle: "")
            return
        }

        guard self.txtCity.text! != "" else {
            Utility.errorAlert(vc: self, strMessage: "Please enter your city.", errortitle: "")
            return
        }

        guard self.txtLocation.text! != "" else {
            Utility.errorAlert(vc: self, strMessage: "Please enter your location.", errortitle: "")
            return
        }

        guard self.txtAddress.text! != "" else {
            Utility.errorAlert(vc: self, strMessage: "Please enter your full addtress.", errortitle: "")
            return
        }

        guard self.txtBusinessEmail.text! != "" else {
            Utility.errorAlert(vc: self, strMessage: "Please enter your buissness email.", errortitle: "")
            return
        }

        guard isValidEmail(testStr: self.txtBusinessEmail.text!) else {
            Utility.errorAlert(vc: self, strMessage: "Please enter your buissness email proper.", errortitle: "")
            return
        }
        guard self.txtPassword.text! != "" else {
            Utility.errorAlert(vc: self, strMessage: "Please enter your password.", errortitle: "")
            return
        }

        guard self.txtPassword.text! == self.txtConfirmPassword.text! else {
            Utility.errorAlert(vc: self, strMessage: "Password does not match.", errortitle: "")
            return
        }

        
      // self.performSegue(withIdentifier: "gotoWorkingHours", sender: nil)
        signUp()
        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == txtPassword {
            if range.location < 4{
                return true
            }else{
                return false
            }
        }
        
        if textField == txtConfirmPassword {
            if range.location < 4{
                return true
            }else{
                return false
            }
        }
         return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func btnContry(_ sender: UIButton) {
        var arrCountry:[String] = []
        for i in contryArr{
            arrCountry.append(i.contry_Name!)
        }
        
        self.txtContry.text = arrCountry[0]
        let alert = UIAlertController(style: .actionSheet, title: "", message: "Category of Services")
        let pickerViewValues: [String] = arrCountry
        // let frameSizes: [CGFloat] = (150...400).map { CGFloat($0) }
        let index = arrCountry.first
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: arrCountry.index(of: index!) ?? 0)
        
        alert.addPickerView(values: [pickerViewValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            self.txtContry.text = arrCountry[index.row]
            
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
        
    }
    
    @IBAction func btnCity(_ sender: UIButton) {

        var city:[String] = []
        
        for i in cityArr{
            city.append(i.cityName!)
        }
        
        self.txtCity.text = city[0]
        let alert = UIAlertController(style: .actionSheet, title: "", message: "Select Cities")
        let pickerViewValues: [String] = city
        // let frameSizes: [CGFloat] = (150...400).map { CGFloat($0) }
        let index = city.first
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: city.index(of: index!) ?? 0)
        
        alert.addPickerView(values: [pickerViewValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            self.txtCity.text = city[index.row]
            let id = self.cityArr[index.row].city_id!
            self.arrLocation.removeAll()
            for i in self.locationArr{
                
                if i.city_ID! == id{
                     self.arrLocation.append(i.locName)
                }

            }
             self.txtLocation.text = self.arrLocation.first
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
    }
    
    
    @IBAction func btnLocation(_ sender: UIButton) {
        guard self.arrLocation.count != 0 else {
            
            return
        }
        
        let alert = UIAlertController(style: .actionSheet, title: "", message: "Select Location")
        let pickerViewValues: [String] = self.arrLocation
        // let frameSizes: [CGFloat] = (150...400).map { CGFloat($0) }
        let index = areaArray.first
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: self.arrLocation.index(of: index!) ?? 0)
        
        alert.addPickerView(values: [pickerViewValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            self.txtLocation.text = self.arrLocation[index.row]
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
        

    }
    
    func signUp()
    {
        KRProgressHUD.show()
        let params = ["business_name":txtNameofBusiness.text!, "user_phone":txtPhoneNo.text!, "user_location":txtLocation.text!, "city":txtCity.text!,"country":txtContry.text!, "user_email":txtBusinessEmail.text!,"user_password":txtPassword.text!,"business_full_address":txtAddress.text!,"role":"1","device_token":"123","device_type":"2","reg_service_type":"\(registerServiceType)"]
        
        UserManager.shared.register(parametrs: params) { (success, message) in
            
            if success == true{
                
                KRProgressHUD.dismiss()
                let alert = UIAlertController(title: "Success", message: "\(message!)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                     self.performSegue(withIdentifier: "gotoWorkingHours", sender: nil)
                }))
                self.present(alert, animated: true, completion: nil)
                KRProgressHUD.dismiss()
            }
            else
            {
                KRProgressHUD.dismiss()
                Utility.errorAlert(vc: self, strMessage: "\(message)", errortitle: "")
            }
            KRProgressHUD.dismiss()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField == txtPhoneNo
        {
        
            resignFirstResponder()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "gotoWorkingHours"
        {
            let des = segue.destination as! Work_day_VC
        }
    }
    
    
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-Medium", size: 12)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}
