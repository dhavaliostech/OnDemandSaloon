//
//  AppointmentDetailsVC.swift
//  SalonApp
//
//  Created by MANISH CHAUHAN on 7/21/18.
//  Copyright © 2018 MANISH CHAUHAN. All rights reserved.
//

import UIKit
import KRProgressHUD

class AppointmentDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var serviceTableview: UITableView!
    
    @IBOutlet weak var btnUser: UIButton!
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var lblNumber: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var btndate: UIButton!
    
    @IBOutlet weak var btnTime: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var acceptRejectView: UIView!
    
    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var mainViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var serviceListHeight: NSLayoutConstraint!
    
    @IBOutlet weak var txtNotes: UITextField!
    var getObjDetail:ProviderAppointmentList!
    var getUserDetailsArray : [ProviderAppointmentList] = []
    var isEdit = false
    
    var getObjDetaillist:AppointmentlistData!
    
    let window = UIApplication.shared.keyWindow
    var tabbarController = ManageLoginTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       //getUserDetails()
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.btnUser.addTarget(self, action: #selector(btnUserAction(_:)), for: UIControlEvents.touchUpInside)
        
        self.btnUser.layer.borderWidth = 1
        self.btnUser.layer.borderColor = UIColor.white.cgColor
        self.btnUser.layer.cornerRadius = 15
        
        self.lblUserName.text! = "\(getObjDetaillist.user_fname!) \(getObjDetaillist.user_lname!)"
        self.lblNumber.text! = getObjDetaillist.user_phone!
        self.btndate.setTitle(getObjDetaillist.app_date!, for: .normal)
        self.btnTime.setTitle(getObjDetaillist.app_service_time!, for: .normal)
        self.lblLocation.text! = getObjDetaillist.user_location!
        
        self.serviceTableview.reloadData()
        serviceListHeight.constant = serviceTableViewHeight
        mainViewHeightConstraint.constant = self.mainView.intrinsicContentSize.height
        
        self.acceptRejectView.isHidden = true
        self.statusView.isHidden = true
        
        if self.getObjDetaillist.app_book_status! == "0"{
            if  self.getObjDetaillist.app_status! == "0"{
                //self.lblStatus.text! = "Pending"
                self.statusView.isHidden = true
                self.acceptRejectView.isHidden = false
            }else if getObjDetaillist.app_status! == "1"{
                self.lblStatus.text! = "Accepted"
                self.statusView.isHidden = false
                self.viewShade(view: self.statusView)
                self.lblStatus.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)

            }else if getObjDetaillist.app_status! == "2"{
                self.lblStatus.text! = "Rejected"
                self.statusView.isHidden = false
                self.lblStatus.textColor = UIColor.white
                self.viewShade(view: self.statusView)

            }
        }else{
            if  self.getObjDetaillist.app_status! == "0"{
                self.lblStatus.text! = "Pending"
                self.statusView.isHidden = false
                self.viewShade(view: self.statusView)
                self.lblStatus.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
            }else if getObjDetaillist.app_status! == "1"{
                self.lblStatus.text! = "Accepted"
                self.statusView.isHidden = false
                self.viewShade(view: self.statusView)
                self.lblStatus.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
            }else if getObjDetaillist.app_status! == "2"{
                self.lblStatus.text! = "Rejected"
                self.statusView.isHidden = false
                self.lblStatus.textColor = UIColor.white
                self.viewShade(view: self.statusView)
            }
        }
        
       

    }
    
    func viewShade(view:UIView?){
        view?.layer.cornerRadius = 5
        view?.layer.shadowOpacity = 0.18
        view?.layer.shadowOffset = CGSize(width: 0, height: 2)
        view?.layer.shadowRadius = 2
        view?.layer.shadowColor = UIColor.black.cgColor
        view?.layer.masksToBounds = false
        view?.layer.cornerRadius = 8
    }
    
    var serviceTableViewHeight:CGFloat{
        self.serviceTableview.layer.layoutIfNeeded()
        
        return self.serviceTableview.contentSize.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
         isEdit = false
        
        if appDelegate.changeStoryBoard == true{
            self.tabBarController?.tabBar.isHidden = true
            
        }else{
            self.tabBarController?.tabBar.isHidden = false
            
        }
    }
    
    @IBAction func btnEditAction(_ sender: UIButton) {
        
        isEdit = true
        
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
    
    @IBAction func btnDateAction(_ sender: UIButton) {
        
        if isEdit == true{
            let alert = UIAlertController(style: .actionSheet, title: "", message: "Select Date")
            alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
                Log(date)
                print(date)
                
                let stringDate = "\(date)"
                self.btndate.setTitle(Utility.convertDateFormater(stringDate, dateFormat: "dd-MM-yyyy"), for: .normal)
            }
            alert.addAction(title: "Done", style: .cancel)
            
            alert.show()
        }

        
    }
    
    @IBAction func btnTimeAction(_ sender: UIButton) {
        
        if isEdit == true{
            let alert = UIAlertController(style: .actionSheet, title: "")
            
            alert.addDatePicker(mode: UIDatePickerMode.time, date: nil) { (dateTime) in
                
                self.btnTime.setTitle(Utility.convertDateFormater("\(dateTime)"), for: UIControlState.normal)
            }
            
            alert.addAction(image: nil, title: "Done", color: nil, style: UIAlertActionStyle.default, isEnabled: true) { (dateTimeAction) in
            }
            alert.show()
        }
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //Get the details of use from API
    func getUserDetails(){
        
        KRProgressHUD.show()
        
        let params = ["user_id":"\(getObjDetaillist.id!)"]
        
        ProviderManager.shared.userAppointmentDetails(parmas: params) { (success, data,message) in
            
            if success == true{
                self.getUserDetailsArray = data
                
                for i in self.getUserDetailsArray{
                    
                    //self.btndate.setTitle("\(i.strDate!)", for: UIControlState.normal)
                    self.btnTime.setTitle("\(i.strServiceTime)", for: UIControlState.normal)
                    self.lblUserName.text = "\(i.strFName) \(i.strLName)"
        
                }
                KRProgressHUD.dismiss()
                self.serviceTableview.reloadData()
            }else
            {
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message)", errortitle: "")
                })
            }
            
        }
        
    }
    
    @IBAction func btnAcceptAction(_ sender: UIButton) {
        acceptOrRejectAPI(value:sender.tag,statusAcceptOrReject:"1")
        
    }
    
    @IBAction func btnRejectAction(_ sender: UIButton) {
        acceptOrRejectAPI(value:sender.tag,statusAcceptOrReject:"0")
    }
    
    func acceptOrRejectAPI(value:Int,statusAcceptOrReject:String?){
        
        KRProgressHUD.show()

        var date = btndate.titleLabel!.text
        var time = btnTime.titleLabel!.text
        
        if date! == "dd/mm/yyyy"{
            date = ""
        }
        if time! == ""{
            time = ""
        }
        
        
        let params = ["date":"\(date!)","user_id":"\(self.getObjDetaillist.id!)","provider_id":"1","role":"1","time":"\(time!)","appointment_status":"\(statusAcceptOrReject!)","notes":"\(txtNotes.text!)"]
        
        ProviderManager.shared.acceptRejectApiOfAppointment(params: params) { (success, message) in
            
            if success == true{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: "\(message!)", alerttitle: "")
                })
            }else{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: "\(message!)", alerttitle: "")
                })
            }
            
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getObjDetaillist.service_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell") as!  ServiceAppointmentTableViewCell
        
         let obj = getObjDetaillist!
        let serviceObj = obj.service_list[indexPath.row]

        cell.lblPrice.text! = "AED\(serviceObj.ser_cs_price!)"
        cell.lblService.text! = serviceObj.ser_cs_name!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell")
        cell?.selectionStyle = .none
        tableView.tableFooterView = UIView()
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEditeAction(_ sender: UIButton) {
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
