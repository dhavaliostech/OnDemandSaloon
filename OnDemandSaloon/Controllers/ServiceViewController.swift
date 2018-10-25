//
//  ServiceViewController.swift
//  OnDemandSaloon
//
//  Created by Pratik Zankat on 10/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//FloatRatingView

import UIKit
import FloatRatingView
import KRProgressHUD
import SDWebImage

class ServiceViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,FloatRatingViewDelegate {
    
    @IBOutlet weak var firstIMG: UIImageView!
    @IBOutlet weak var secondIMG: UIImageView!
    @IBOutlet var infoView: UIView!
    @IBOutlet var loginPopupBackView: UIView!
    
    @IBOutlet weak var lblServices: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    
    @IBOutlet weak var proceedBtn: UIButton!
    @IBOutlet weak var saloonServicesCollectionView: UICollectionView!
    @IBOutlet var btnForgotPassword: UIButton!
    @IBOutlet var btnCreateAccount: UIButton!
    @IBOutlet var btnSignin: UIButton!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var passwordBackView: UIView!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var emailBackView: UIView!
    @IBOutlet var btnClose: UIButton!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var popupView: UIView!
    @IBOutlet var btnsell: UIButton!
    
   
    @IBOutlet var serviceListCollectionView: UICollectionView!
   
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet var imagesCollectionView: UICollectionView!
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var addCartBackView: UIView!
    
    @IBOutlet weak var infoBackVIew: UIView!
    @IBOutlet weak var btnServices: UIButton!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var heightOfTableview: NSLayoutConstraint!
    
    @IBOutlet weak var infoViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var reviewTableViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var infoTableView: UITableView!
    
    @IBOutlet weak var infoviewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var cadViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnRateThisSalon: UIButton!
    @IBOutlet weak var lblAddServices: UILabel!
    
    @IBOutlet weak var lblSalonAddress: UILabel!
    
    @IBOutlet weak var serviceHeight: NSLayoutConstraint!
    
    @IBOutlet weak var servicetableView: UITableView!
    
    @IBOutlet weak var lblSalonName: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var totalReview: UILabel!
    @IBOutlet weak var lblCustomerPercentage: UILabel!
    
    @IBOutlet weak var lblTimeInfo: UILabel!
    @IBOutlet weak var addressView: UIView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblTotalPrice: UILabel!
    
    //let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let window = UIApplication.shared.keyWindow
    
    var arrService = ["All","Hair salons","Nailspa"," Bridalmakeup","other"]
    var arrName = ["Hair Cut","Hair Style","Hair Color","Hair Spa","Hair Shampoo"]
    var reviewersName = ["Steve","Kevin","Nikky","Smith","Nishit"]
    
    var flagArr : [Int] = []
    
    var salonID = ""
    
    var selectedServiceIndex :Int!
    var detailSalonData:SalonDetailsBasedOnId!
    
    var reviewListArray:[RatingList] = []
    var imageList:[String] = []
    var timeInforArray :[TimeInfo] = []
    var catArray: [CatDetails] = []
    var catSerArray:[CatSerDetails] = []
    var allServices:[CatSerDetails] = []
    var employeeList:[EmployeeeListAppointment] = []
    
    var mainCatID:[String] = []
    
    //Flags
    var popUpFlag = false
    var pushFlag = false
    var isAllCatSelected = false
    
    var selectedBookObject :[CatSerDetails] = []
    var currentImageIndex:Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        btnInfo.layer.borderWidth = 1
        btnInfo.layer.cornerRadius = 4
        btnInfo.clipsToBounds = true
        btnInfo.layer.borderColor = UIColor(red: 0/255.0, green: 102/255.0, blue: 176/255.0, alpha: 1.0).cgColor
        
        btnsell.layer.borderWidth = 1
        btnsell.layer.cornerRadius = self.btnsell.frame.size.height / 2
        btnsell.clipsToBounds = true
        btnsell.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0, alpha: 1.0).cgColor
        
        popupView.layer.cornerRadius = 5
        
        self.shadowView(view: addCartBackView)
        self.shadowView(view: tableview)
        
        btnInfo.layer.borderWidth = 1
        btnInfo.layer.cornerRadius = 5
        btnInfo.layer.borderColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0).cgColor
        
        self.btnServices.layer.borderWidth = 1
        self.btnServices.layer.cornerRadius = 5
        self.btnServices.layer.borderColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0).cgColor
        
        self.firstIMG.image = #imageLiteral(resourceName: "btnSignin")
        self.firstIMG.layer.cornerRadius = 5
        self.secondIMG.layer.cornerRadius = 5
        self.lblServices.textColor = UIColor.white
        self.lblInfo.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
        
        self.addCartBackView.isHidden = false
        
        if self.selectedBookObject.count == 0{
            self.addCartBackView.isHidden = true
            cadViewConstraint.constant = 0
        }
        
        
        if salonID != ""{
            getSalonDataBasedOnID()
        }else{
            
        }
        
        
        // Do any additional setup after loading the view.
        
    }
    //gotoRateSegue
    //detailResultSegue
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if appDelegate.changeStoryBoard == true{
            appDelegate.changeStoryBoard = false
        }
       
        if let getFlag = userDefaults.value(forKey: "userLogin") as? Bool{
            if getFlag != true{
                addCartBackView.isHidden = true
                cadViewConstraint.constant = 0
            }
        }
        
        Utility.chnageBtnTitle(btn: btnsell)

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
    
    func shadowView(view:UIView){
        
        view.layer.shadowOpacity = 0.18
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowRadius = 2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
    }
    
    var tableViewHeight :CGFloat{
        tableview.layoutIfNeeded()
        return tableview.contentSize.height
    }
    
    var reviewTableviewHeight:CGFloat{
        infoTableView.layoutIfNeeded()
        
        print(infoTableView.contentSize.height)
        return infoTableView.contentSize.height
    }
    
    var selectedServices:CGFloat{
        servicetableView.layer.layoutIfNeeded()
        return servicetableView.contentSize.height
    
    }
    
    @IBAction func btnRateThisSalonAction(_ sender: UIButton) {
    
        if let userid = userDefaults.value(forKey: "user_id") as? String{
            var reviewId = ""
            
            for i in self.reviewListArray{
                
                if i.id! == userid{
                    reviewId = i.id!
                }
                
            }
            
            guard userid != reviewId else {
                Utility.errorAlert(vc: self, strMessage: "You have already rated this salon.", errortitle: "Rate This Salon")
                return
            }
            
            self.performSegue(withIdentifier: "gotoRateSegue", sender: nil)
            
        }else{
            
            let obj = ["salonID":"\(self.detailSalonData.serviceProviderId!)"]
            print(obj)
            userDefaults.set(obj as [String:Any], forKey: "rateLogin")
            
            appDelegate.rateLogin = true
            Utility.generateInfoPopUp(parentController: self, isPopView: false, parentVc: "ServiceViewController", isLogin: true, isService: false)
            
            
        }
        
    }
    //ServiceViewController
    @IBAction func btnSellYourService(_ sender: UIButton) {
        
        if let getLogin = userDefaults.value(forKey: "pro_id") as? Bool{
            
            gotServiceoProvider()
        
        }else{
            createPopUpp()
        }
    }
    
    
    @objc func createPopUpp(){
        Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "ServiceViewController", isLogin: false, isService: true )
    }
    
    @objc func gotServiceoProvider(){
        let sBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
        appDelegate.changeStoryBoard = true
        //tabBarController?.hidesBottomBarWhenPushed = true
        vc.loadViewIfNeeded()
        userDefaults.set("provider", forKey: "lastLogin")
        vc.hidesBottomBarWhenPushed = true
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    
    @IBAction func btnBookAction(_ sender: UIButton) {
        self.addCartBackView.isHidden = false
        if sender.titleLabel?.text == "Cancel"
        {
            let objForAllServices = allServices[sender.tag]
            for i in selectedBookObject{
 
                if i.ser_cs_id! != objForAllServices.ser_cs_id!{
                    
                }
                else {
                    
                    let arrayIndex = selectedBookObject.index(of: objForAllServices)
                    
                    for i in self.allServices{
                        if i.ser_cs_id! == selectedBookObject[arrayIndex!].ser_cs_id!{
                            i.selectedItem = false
                            selectedBookObject[arrayIndex!].selectedItem = false
                        }
                    }
                    
                    print(arrayIndex!)
                    selectedBookObject.remove(at: arrayIndex!)
                    
                    break
                }

            }
        }else {
            markAsBookedServie(index: sender.tag)
        }
        
        self.tableview.reloadData()
        self.servicetableView.reloadData()
        self.addCartBackView.isHidden = false
        self.heightOfTableview.constant = self.tableViewHeight
        
        
        if self.selectedBookObject.count == 0{
            self.addCartBackView.isHidden = true
        }
        
        self.serviceHeight.constant = self.selectedServices
    }
    
    func markAsBookedServie(index:Int){
        let objForAllServices = allServices[index]

        if let getFlag = userDefaults.value(forKey: "user_id") as? String{
            
            tableview.reloadData()
            
        }else {
            let obj = ["salonID":"\(self.detailSalonData.serviceProviderId!)","slectedServiceID":"\(objForAllServices.ser_cs_id!)","catId":"\(objForAllServices.ser_cs_parent!)"]
            print(obj)
            userDefaults.set(obj as [String:Any], forKey: "slected_Book_LoginObj")
            
            Utility.generateInfoPopUp(parentController: self, isPopView: false, parentVc: "ServiceViewController", isLogin: true, isService: false)
            
            return
            
        }
    
        var selectServices :[CatSerDetails] = []
        
        if selectedBookObject.count != 0{
            
            for i in selectedBookObject{
                
                if i.ser_cs_id! == objForAllServices.ser_cs_id!{
                    
                    print("Same Value")
                    
                }
                else {
                    
                    for i in self.allServices{
                        if i.ser_cs_parent! == objForAllServices.ser_cs_parent!{
                            if i.ser_cs_id! == objForAllServices.ser_cs_id!{
                                i.selectedItem = true
                                objForAllServices.selectedItem = true
                                
                            }
                        }
                    }
                    
                    
                    selectedBookObject.append(objForAllServices)
                    break
                    //break
                }

            }
            
        }else{
            for i in self.allServices{
                if i.ser_cs_id! == objForAllServices.ser_cs_id!{
                    i.selectedItem = true
                    objForAllServices.selectedItem = true
                }
            }
            selectedBookObject.append(objForAllServices)
        }

        print(flagArr)
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        
        if appDelegate.isLogin == true{
            appDelegate.isLogin = false
            userDefaults.removeObject(forKey: "slected_Book_LoginObj")
        }else if appDelegate.rateLogin == true{
            //rateLogin
            userDefaults.removeObject(forKey: "rateLogin")
        }
         self.navigationController?.popViewController(animated: true)
        
    }
   
    
    // MARK: Button Action
    
    @IBAction func btnToggole(_ sender: UIButton) {

        self.lblServices.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
        self.lblInfo.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
        self.firstIMG.image = nil
        self.secondIMG.image = nil
        if sender.tag == 1 {
           showInfobackView()
           self.lblServices.textColor = UIColor.white
            self.firstIMG.image = #imageLiteral(resourceName: "btnSignin")
        }else {

            showInfoView()
            self.lblInfo.textColor = UIColor.white
            self.secondIMG.image = #imageLiteral(resourceName: "btnSignin")
        }
    }
    
    func showInfoView(){
        self.tableview.isHidden = true
        self.addCartBackView.isHidden = true
        infoviewHeight.constant = 0
        let getHeight = reviewTableviewHeight
        print(reviewTableviewHeight)
        print()
        let getValue = infoView.height + getHeight
        print(getValue)
        //infoviewHeight.constant = getValue
        collectionViewHeight.constant = 0
        reviewTableViewHeight.constant = reviewTableviewHeight
        self.cadViewConstraint.constant = 0
        heightOfTableview.constant = 0
        self.infoBackVIew.addSubview(infoView)
        self.infoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([infoView.topAnchor.constraint(equalTo: infoBackVIew.topAnchor, constant: 0),infoView.leadingAnchor.constraint(equalTo: infoBackVIew.leadingAnchor, constant: 0),infoView.trailingAnchor.constraint(equalTo: infoBackVIew.trailingAnchor, constant: 0),infoView.bottomAnchor.constraint(equalTo: infoBackVIew.bottomAnchor, constant: 0)])
        //infoView.bottomAnchor.constraint(equalTo: infoBackVIew.bottomAnchor, constant: 0)]
    }
    
    func showInfobackView(){
        self.infoView.removeFromSuperview()
        self.addCartBackView.isHidden = false
        collectionViewHeight.constant = 40
        self.tableview.isHidden = false
        let getInfoViewHeight = tableViewHeight
        let totalViewHeight =  getInfoViewHeight + 32
        infoviewHeight.constant = totalViewHeight
        heightOfTableview.constant = tableViewHeight
        self.infoView.frame = CGRect(x: 0, y: 0, width: 309, height: 331)
        reviewTableViewHeight.constant = 140
        self.addCartBackView.isHidden = false

        if self.selectedBookObject.count != 0{
            self.cadViewConstraint.constant = self.selectedServices + 60
        }else{
            self.cadViewConstraint.constant = 0
            self.addCartBackView.isHidden = true
        }
    }
    
    @IBAction func btnCloseAction(_ sender: UIButton) {
        
        loginPopupBackView.isHidden = true
        loginPopupBackView.removeFromSuperview()
        self.tableview.reloadData()
    }
    
    @objc func btnCallAction(_ sender:UIButton){
        let phoneNumber = self.detailSalonData.user_phone!
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            //UIApplication.shared.openURL(url)
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
    @IBAction func proceedBtnAction(_ sender: UIButton) {

        
        self.performSegue(withIdentifier: "selectTimeSegue", sender: nil)
    }
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "SignUp", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AppointmentBookingViewController") as! AppointmentBookingViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func btnBackaction(_ sender: UIButton) {
    }
    
    
    @IBAction func btnCallaction(_ sender: UIButton) {
    }
    
    @IBAction func Signinaction(_ sender: UIButton) {
       
    }
    
    func getSalonDataBasedOnID(){
        
        KRProgressHUD.show()
        let param = ["shop_id":"\(salonID)"]
        UserManager.shared.getDataBasedOnSalonId(param: param) { (success, responseData,message) in
            
            if success == true{

                self.detailSalonData = responseData
                self.reviewListArray = self.detailSalonData.ratList
                self.catArray = self.detailSalonData.catArray
                self.catSerArray = self.detailSalonData.catServiceArray
                self.imageList = self.detailSalonData.imageArray
                self.timeInforArray = self.detailSalonData.timeInfo
                //self.employeeList = self.detailSalonData.employeeList
                self.ratingView.rating = Double(self.detailSalonData.rat_out_of_5!)!
                self.employeeList.append(EmployeeeListAppointment(dict: ["em_id":"0","em_fname":"Anyone"]))
            
                for i in self.detailSalonData.employeeList{
                     self.employeeList.append(i)
                }
                
                self.lblLocation.text = self.detailSalonData.user_location!
                self.lblSalonName.text = self.detailSalonData.business_name!
                self.lblCustomerPercentage.text = "\(self.detailSalonData.happy_customers!)% Happy Customers"
                self.totalReview.text = "\(self.detailSalonData.total_review!) reviews"
                
                self.lblSalonAddress.text = self.detailSalonData.salonAddress!
            
                let firstCatObj = self.catArray[0]
                
                for j in self.catSerArray{
                    
                    if firstCatObj.ser_ID! == j.ser_cs_parent{
                        self.allServices.append(j)
                    }
                    
                }
                var timeInfo = ""
                for i in self.timeInforArray{
                    
                    if timeInfo == ""{
                        timeInfo = "\(i.oh_day!) \(i.oh_from_time!) - \(i.oh_to_time!)"
                    }else{
                        timeInfo = "\(timeInfo) \n\(i.oh_day!) \(i.oh_from_time!) - \(i.oh_to_time!)"
                    }
                    self.lblTimeInfo.text! = timeInfo
                }
                
                if appDelegate.isLogin == true{
                    
                    let getObj = userDefaults.value(forKey: "slected_Book_LoginObj") as! [String:Any]
                    
                    for i in self.catArray{
                        
                        for j in self.allServices{
                            if i.ser_ID! == getObj["catId"] as! String{
                                
                                if j.ser_cs_id! == getObj["slectedServiceID"] as! String{
                                    j.selectedItem = true

                                    self.selectedBookObject.append(j)
                                    
                                    break
                                }
                                
                            }
                            
                        }
    
                    }
                }
                
                if self.selectedBookObject.count != 0{
                    self.addCartBackView.isHidden = false
    
                }
                
                self.tableview.reloadData()
                self.servicetableView.reloadData()
                self.infoTableView.reloadData()
                self.imagesCollectionView.reloadData()
                self.serviceListCollectionView.reloadData()
                let getInfoViewHeight = self.tableViewHeight
                let totalViewHeight =  getInfoViewHeight + 32
                self.infoviewHeight.constant = totalViewHeight
                self.heightOfTableview.constant = self.tableViewHeight
                self.shadowView(view: self.addressView)
              
                self.pageControl.numberOfPages = self.imageList.count
                
                KRProgressHUD.dismiss()
            }else{
                
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
            }
            
        }
    }
    
    
    //MARK: TableView Delegate and DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 2{
            return self.reviewListArray.count
        }else if tableView.tag == 3{
            return self.selectedBookObject.count
        }
        else{
            return self.allServices.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 2{
            
            let reviewObj = reviewListArray[indexPath.row]
            
            let infocell = tableView.dequeueReusableCell(withIdentifier: "infoDetailsCell") as! infoDetailsCell
            infocell.rateCellBackView.layer.cornerRadius = 5
            infocell.rateCellBackView.layer.borderWidth = 1
            infocell.rateCellBackView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
            infocell.lblusername.text = reviewersName[indexPath.row]
            tableView.tableFooterView = UIView()
            infocell.selectionStyle = .none
            
            infocell.imgUser.sd_setImage(with: URL(string: reviewObj.userImage!), completed: nil)
            infocell.lblusername.text = "\(reviewObj.user_frame!) \(reviewObj.user_lname!)"
            infocell.lblDetails.text = reviewObj.ratDiscription!
            infocell.lblTime.text = reviewObj.ratCreatedTime!
            infocell.userRatings.rating = Double(reviewObj.rateOutOF5!)!
            
            return infocell
            
        }else if tableView.tag == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BookingTableViewCell
            //Set Cell UI
            cell.btnBook.layer.borderWidth = 1
            cell.btnBook.layer.borderColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1).cgColor
            cell.btnBook.setTitleColor(UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1), for: .normal)
            cell.priceView.layer.borderWidth = 1
            cell.priceView.layer.borderColor = UIColor.lightGray.cgColor
            tableView.tableFooterView = UIView()
            cell.selectionStyle = .none
            cell.categoryName.layer.borderColor = UIColor.lightGray.cgColor
            cell.catView.layer.borderColor = UIColor.lightGray.cgColor
            cell.catView.layer.borderWidth = 1
            cell.btnCall.tag = indexPath.row
            cell.btnCall.addTarget(self, action: #selector(btnCallAction(_:)), for: .touchUpInside)
            //Data Object
            //let obj = catArray[indexPath.row]

            cell.btnBook.tag = indexPath.row
            print(cell.btnBook.tag)

            //Setting Data

                let obj = allServices[indexPath.row]
                cell.categoryName.text! = obj.ser_cs_name!
                cell.catagoryIMG.sd_setImage(with: URL(string: obj.ser_cat_image!), completed: nil)
                cell.lblPrice.text! = "\(obj.ser_cs_price!)AED"
                cell.btnBook.backgroundColor = UIColor.white
            
            if selectedBookObject.count != 0{
 
                if obj.selectedItem == true{
                    cell.btnBook.setTitle("Cancel", for: UIControlState.normal)
                    cell.imgAddAndStatus.image = #imageLiteral(resourceName: "smallRight")
                    cell.btnBook.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
                    cell.btnBook.layer.borderWidth = 0
                    cell.btnBook.setTitleColor(UIColor.white, for: .normal)
                    return cell
                }else{
                    cell.btnBook.setTitle("Book", for: UIControlState.normal)
                    cell.imgAddAndStatus.image = #imageLiteral(resourceName: "iconplus")
                    cell.btnBook.backgroundColor = UIColor.white
                    cell.btnBook.layer.borderWidth = 1
                    cell.btnBook.layer.borderColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1).cgColor
                    cell.btnBook.setTitleColor(UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1), for: .normal)

                    return cell
                }
                
            }else{
                cell.btnBook.setTitle("Book", for: UIControlState.normal)
                cell.imgAddAndStatus.image = #imageLiteral(resourceName: "iconplus")
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "servicesCell")
            
            let obj = self.selectedBookObject[indexPath.row]
            var price = 0
            self.lblTotalPrice.text! = "\(price) AED"
            if self.selectedBookObject.count == 0{
                self.lblTotalPrice.text! = "\(price) AED"
            }else{
                
                for i in self.selectedBookObject{
                    
                    if price == 0{
                        price = Int(i.ser_cs_price!)!
                    }else{
                        price = price + Int(i.ser_cs_price!)!
                    }
                }
                
                self.lblTotalPrice.text! = "\(price) AED"
            }

            cell?.textLabel?.text = obj.ser_cs_name!
            cell?.selectionStyle = .none
            return cell!
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == infoTableView{
            return 99.5
        }else if tableView == tableview {
              return 45
        }
        else if tableView == self.servicetableView{
            return 20
        }
        return CGFloat()
    }
  
    override func viewWillLayoutSubviews() {
        if self.view.subviews == nil{
            self.tableview.reloadData()
        }
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
        if segue.identifier == "selectTimeSegue"{
            
            let obj = segue.destination as! SelectDateTimeForAppointmentBookingVC
            obj.getEmployee = self.employeeList
            obj.getTimeInfo = self.timeInforArray
            obj.selectedObj = self.selectedBookObject
            obj.catID = self.catArray
            obj.mainOBJ = self.detailSalonData
            obj.totalAmount = (self.lblTotalPrice.text?.replacingOccurrences(of: "AED", with: ""))!
            tabBarController?.tabBar.isHidden = false

        }else if segue.identifier == "gotoRateSegue"{
            let obj = segue.destination as! RatingViewController
            obj.getSlectedOBj = detailSalonData
            
        }//SalonDetailsBasedOnId
        
    }
   
    //MARK: Extension  get Dynamic width  for lable
}

extension ServiceViewController :UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    //MARK: Collection Delegate and DataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1{
            return imageList.count
        }else if collectionView.tag == 2{
            return catArray.count
        }else if collectionView == saloonServicesCollectionView{
            return 2
        }else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1
        {
            let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "ServiceImagecell", for: indexPath) as? ServiceImagecell
            
            let obj = imageList[indexPath.item]

            cell?.Saloonimg.sd_setImage(with: URL(string: obj), completed: nil)
            
            return cell!
        }else if collectionView.tag == 2{
            let cellService = serviceListCollectionView.dequeueReusableCell(withReuseIdentifier: "ServiceListCell", for: indexPath) as? ServiceListCell
            
            if indexPath.item == 0{
                cellService?.imgServiceBackground.image = #imageLiteral(resourceName: "btnSignin")
            }
            
            if selectedServiceIndex != nil{
                
                if selectedServiceIndex == indexPath.item{
                    cellService?.imgServiceBackground.image = #imageLiteral(resourceName: "btnSignin")
                }else{
                    cellService?.imgServiceBackground.image = nil
                }
                
            }
            
            let obj = catArray[indexPath.item]
            print(obj.ser_name!)
            cellService?.lblService.text = obj.ser_name!
            return cellService!
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1{
            
        }else if collectionView.tag == 2{

            self.flagArr.removeAll()
            self.allServices.removeAll()
            let obj = catArray[indexPath.item]
            
                for j in self.catSerArray{
                    
                    if obj.ser_ID! == j.ser_cs_parent!{
                        self.allServices.append(j)
                        
                    }
                    
                }
            selectedServiceIndex = indexPath.item
            self.serviceListCollectionView.reloadData()
            self.tableview.reloadData()
            self.heightOfTableview.constant = self.tableViewHeight
            self.infoviewHeight.constant = self.tableViewHeight + 32
        }
    }
    
   
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if let gteIndex = self.imagesCollectionView.indexPathsForVisibleItems.first{
            print(self.imagesCollectionView.indexPathsForVisibleItems.first)
            print(self.pageControl.currentPage)
            self.pageControl.currentPage = gteIndex.item
        }   
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1{
            let Width = self.view.frame.size.width
            return CGSize(width:imagesCollectionView.frame.size.width , height:imagesCollectionView.frame.size.height)
        }else if collectionView.tag == 2{
            
            if isAllCatSelected == true{
                
                let Width = allServices[indexPath.item].ser_cs_name!.daywidthlable(constraintedWidth:0, font: UIFont(name: "Titillium-Regular", size: 17.0)!)
                return CGSize(width:Width + 25 , height:serviceListCollectionView.frame.size.height)
            }else{
                let Width = catArray[indexPath.item].ser_name!.daywidthlable(constraintedWidth:0, font: UIFont(name: "Titillium-Regular", size: 17.0)!)
                print(Width)
                return CGSize(width:Width + 25 , height:serviceListCollectionView.frame.size.height)
            }
            
            
        }
        
        return CGSize()
    }
    

}
