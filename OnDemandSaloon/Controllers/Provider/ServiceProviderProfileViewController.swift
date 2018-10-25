//
//  ServiceProviderProfileViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 22/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD
import SDWebImage

class ServiceProviderProfileViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var imgServiceProvider: UIImageView!
    
    @IBOutlet weak var txtFieldName: UITextField!
    
    @IBOutlet weak var txtFieldPhoneNumber: UITextField!
    
    
    @IBOutlet weak var selectCategoryView: UIView!
    
    @IBOutlet weak var dayView: UIView!
    
    @IBOutlet weak var imgCollectionView: UICollectionView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnUser: UIButton!
    
    let window = UIApplication.shared.keyWindow
    var tabbarController = ManageLoginTabBarController()

    @IBOutlet weak var txtBusinessLocation: UITextField!
    
    @IBOutlet weak var txtWorkingHours: UITextField!
    @IBOutlet weak var txtContry: UITextField!
    
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var buissnessAddress: UITextField!
    @IBOutlet weak var nameView: UIView!
    
    @IBOutlet weak var phoneNumberView: UIView!
    
    @IBOutlet weak var businessLocationView: UIView!
    
    @IBOutlet weak var contryView: UIView!
    @IBOutlet weak var cityView: UIView!
    
    @IBOutlet weak var buissnessAddressView: UIView!
    @IBOutlet weak var emailView: UIView!
    
    var isImageUpload = false
    var getProfile :ProviderProfile!
    var imageArray :[BannerImage] = []
    var slectedImagesArray:[UIImage] = []
    
    var uploadBannerImage:UIImage!
    
    var heightOfCollectionView:CGFloat{
        
        self.imgCollectionView.layoutIfNeeded()
        return self.imgCollectionView.contentSize.height
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProfileAPI()
        self.heightConstraint.constant = heightOfCollectionView
 
        setUPView()
        
        self.btnUser.layer.borderWidth = 1
        self.btnUser.layer.borderColor = UIColor.white.cgColor
        self.btnUser.layer.cornerRadius = 15
        self.btnUser.addTarget(self, action: #selector(btnUserAction(_:)), for: UIControlEvents.touchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        super.viewWillLayoutSubviews()
        self.imgServiceProvider.layer.cornerRadius = self.imgServiceProvider.frame.size.height / 2
        self.imgServiceProvider.clipsToBounds = true
        self.imgServiceProvider.layer.borderWidth = 0.5
        self.imgServiceProvider.layer.borderColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1).cgColor
    }
    
    
    func getProfileAPI(){
        
        KRProgressHUD.show()
        
        let parsm = ["id":"\(userDefaults.value(forKey: "pro_id")!)","role":"1"]
        
        ProfileManager.shared.providerProfileApicall(parmas: parsm) { (success, message, response) in
            
            if success == true{
                self.getProfile = response
                
                self.txtEmail.text! = self.getProfile.pro_email!
                self.txtFieldName.text! = self.getProfile.business_name!
                self.txtBusinessLocation.text! = self.getProfile.pro_location!
                self.txtFieldPhoneNumber.text! = self.getProfile.pro_phone!
                self.imgServiceProvider.sd_setImage(with: URL(string: self.getProfile.pro_avatar!), completed: nil)
                self.txtCity.text! = self.getProfile.city!
                self.txtContry.text! = self.getProfile.country!
                if self.getProfile.pro_avatar! == ""{
                    self.imgServiceProvider.image = #imageLiteral(resourceName: "userIcon")
                }
                self.buissnessAddress.text! = self.getProfile.business_full_address!
                self.getIamges()
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
            }
            KRProgressHUD.dismiss()
        }
    }
    
    
    func getIamges(){
        let params = ["provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        ProviderManager.shared.getBannerImageBasedOnProId(params: params) { (success, response, message) in
            
            if success == true{
                print(self.imageArray.count)
                self.imageArray = response
                self.imgCollectionView.reloadData()
                self.heightConstraint.constant = self.heightOfCollectionView
                KRProgressHUD.dismiss()
            }else{
                KRProgressHUD.dismiss()
            }
            
        }
    }
    
    @objc func btnUserAction(_ sender:UIButton){
        
        if let userLoginFlag = userDefaults.value(forKey: "user_id") as? String{
            
            let sBoard = UIStoryboard.init(name: "User", bundle: nil)
            let vc = sBoard.instantiateViewController(withIdentifier: "UserTabBar") as! UserTabBarController
            vc.hidesBottomBarWhenPushed = true
            vc.loadViewIfNeeded()
            userDefaults.set("user", forKey: "lastLogin")
            appDelegate.changeStoryBoard = true
            self.navigationController?.pushViewController(vc, animated: false)
   
        }else{
            loadHomePage()
        }
        
    }
    func loadHomePage() {
        
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
    
    func setUPView(){
        //set uiview board
        Utility.setBoarderAndColorOfView(getview: self.businessLocationView)
        Utility.setBoarderAndColorOfView(getview: self.emailView)
        
        Utility.setBoarderAndColorOfView(getview: self.nameView)
        Utility.setBoarderAndColorOfView(getview: self.phoneNumberView)
        Utility.setBoarderAndColorOfView(getview: self.buissnessAddressView)
        Utility.setBoarderAndColorOfView(getview: self.cityView)
        Utility.setBoarderAndColorOfView(getview: self.contryView)
        //Set textfield place holder color
        Utility.setTexField(txtField:self.txtFieldName,placeHolderName:"Business Name")
        Utility.setTexField(txtField:self.txtFieldPhoneNumber,placeHolderName:"Business Phone")
    
        Utility.setTexField(txtField:self.txtBusinessLocation,placeHolderName:"Business Location")
        Utility.setTexField(txtField:self.txtEmail,placeHolderName:"Email")
        Utility.setTexField(txtField: self.txtCity, placeHolderName: "City")
        Utility.setTexField(txtField: self.txtContry, placeHolderName: "Contry")
        Utility.setTexField(txtField: self.buissnessAddress, placeHolderName: "Buissness Address")
     
    }
    
    @IBAction func selectCategoryAction(_ sender: UIButton) {
    }
   
    
    @IBAction func uploadAction(_ sender: UIButton) {
        
        isImageUpload = true
        selectImages()
    }
    
    @IBAction func btnSaveAction(_ sender: UIButton) {
        
        guard self.txtFieldName.text! != "" else {
            
            Utility.showAlert(vc: self, strMessage: "Please enter buissness name.", alerttitle: "")
            return
        }
        
        guard self.txtFieldPhoneNumber.text! != "" else{
            Utility.showAlert(vc: self, strMessage: "Please enter phone number.", alerttitle: "")
            return
        }
        
        guard self.txtBusinessLocation.text! != "" else{
            Utility.showAlert(vc: self, strMessage: "Please enter buissness location.", alerttitle: "")
            return
        }
        
        guard self.txtEmail.text! != "" else{
            Utility.showAlert(vc: self, strMessage: "Please enter buissness email.", alerttitle: "")
            return
        }
        
        guard Utility.isValidEmail(testStr: self.txtEmail.text!) else{
            Utility.showAlert(vc: self, strMessage: "Please enter buissness email.", alerttitle: "")
            return
        }
        
        guard self.txtCity.text! != "" else {
            Utility.showAlert(vc: self, strMessage: "Please enter your city.", alerttitle: "")
            return
        }
        guard self.txtContry.text! != "" else {
            Utility.showAlert(vc: self, strMessage: "Please enter your contry.", alerttitle: "")
            return
        }
        guard self.buissnessAddress.text! != "" else {
            Utility.showAlert(vc: self, strMessage: "Please enter buissness address.", alerttitle: "")
            return
        }
        getUapadteProfile()
        //self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func getUapadteProfile(){
        
        KRProgressHUD.show()

        let updateParmiter = ["id":"\(userDefaults.value(forKey: "pro_id")!)","city": "\(txtCity.text!)","country": "\(txtContry.text!)","business_name":"\(txtFieldName.text!)", "user_phone": "\(txtFieldPhoneNumber.text!)", "user_location": "\(self.txtBusinessLocation.text!)", "user_email": "\(txtEmail.text!))","role": "1","business_full_address":"\(self.buissnessAddress.text!)"]
        
        ProviderManager.shared.editProfileAPI(parmas: updateParmiter, image: self.imgServiceProvider.image!) { (success, message) in
            
            if success == true{
                KRProgressHUD.dismiss({
                    let alert = UIAlertController(title: "Update Profile", message: "\(message!)", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                })
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "Update Profile")
                })
            }
            
        }
        
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton) {
        
        KRProgressHUD.show()
        
        let serviceId = self.imageArray[sender.tag]
        
        let params = ["provider_id":"\(userDefaults.value(forKey: "pro_id")!)","banner_id":"\(serviceId.banner_id!)"]

        ProviderManager.shared.deleteBannerAPI(params: params) { (success, message) in
            
            if success == true{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: "\(message!)", alerttitle: "")
                })
                self.getIamges()
            }else{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: "\(message!)", alerttitle: "")
                })
            }
            
        }
   
    }
    
    func addBannerImage(){
        KRProgressHUD.show()
        let params = ["provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        ProviderManager.shared.addBannerImaeAPI(parmas: params, image:uploadBannerImage! , api: addbannerImage) { (success, message) in
            
            if success == true{
                
                self.getIamges()
            }else{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: "\(message!)", alerttitle: "Upload Image")
                })
            }
            
        }
    }
    
    @IBAction func addProfileImage(_ sender: UIButton) {
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
        
        if isImageUpload != true{
            if let pickedimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.imgServiceProvider.image = pickedimage
                picker.dismiss(animated: true, completion: nil)
            }else{
                picker.dismiss(animated: true, completion: nil)
            }
        }else{
            if let pickedimage = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.uploadBannerImage = pickedimage
                isImageUpload = false
                addBannerImage()
                picker.dismiss(animated: true, completion: nil)
            }else{
                picker.dismiss(animated: true, completion: nil)
            }
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

extension ServiceProviderProfileViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imagesCell", for: indexPath) as! ServiceProviderImagesCell
        
            let imgObj =  self.imageArray[indexPath.item]
            imageCell.btnDeleteImage.tag = indexPath.item
            imageCell.layer.cornerRadius = 10
        
            imageCell.uploadedImages.sd_setImage(with: URL(string: imgObj.bannerName!.trimmingCharacters(in: .whitespaces)), completed: nil)
   
        return imageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 4 - 10, height: collectionView.frame.size.width / 4 - 10)
    }
    
    
}
