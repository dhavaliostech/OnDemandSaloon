//
//  UpcomingAppointment ListVC.swift
//  SalonApp
//
//  Created by MANISH CHAUHAN on 7/21/18.
//  Copyright © 2018 MANISH CHAUHAN. All rights reserved.
//

import UIKit
import KRProgressHUD

class UpcomingAppointment_ListVC: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var btnFromDate: UIButton!
    
    @IBOutlet weak var btnToDate: UIButton!
   
    @IBOutlet weak var tableviewdata: UITableView!
    
    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var btnUpcoming: UIButton!
    @IBOutlet weak var btnPast: UIButton!
    var arrayProfile:[UIImage] = [#imageLiteral(resourceName: "brows"),#imageLiteral(resourceName: "bridalMakeup"),#imageLiteral(resourceName: "brows")]
    
    
    
    var arrName:[String] = ["Sana Saikh","Asama","Saista"]
    
    var arrservice:[String] = ["Color","HairCut","Facial"]
    
    var arrTime:[String] = ["2:00AM","4:00PM","6:30PM"]
    
    var arrDay:[String] = ["Today","Tomorrow","03/04/2018"]
    
    var index : Int!
    
    var arrayOfAppointment :[ProviderAppointmentList] = []
    
    let window = UIApplication.shared.keyWindow
    var tabbarController = ManageLoginTabBarController()

    var isPast = false
    
    var appointmentArray:[AppointmentlistData] = []
    var arrayOfPast:[AppointmentlistData] = []
    
    var arrayOfUpcomming:[AppointmentlistData] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnUser.addTarget(self, action: #selector(btnUserAction(_:)), for: UIControlEvents.touchUpInside)
        
        self.btnUser.layer.borderWidth = 1
        self.btnUser.layer.borderColor = UIColor.white.cgColor
        self.btnUser.layer.cornerRadius = 15
        tabBarController?.tabBar.isHidden = false
        btnPast.layer.cornerRadius = 4
        btnPast.layer.borderWidth = 1
        btnPast.layer.borderColor = txtBlueColor.cgColor
        btnPast.clipsToBounds = true
        
        btnUpcoming.layer.cornerRadius = 4
        btnUpcoming.layer.borderWidth = 1
        btnUpcoming.layer.borderColor = txtBlueColor.cgColor
        btnUpcoming.clipsToBounds = true
       // self.getAppointmentList()
        
        appoinmentlist()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if appDelegate.changeStoryBoard == true{
            tabBarController?.tabBar.isHidden = true
        }else{
            tabBarController?.tabBar.isHidden = false

        }

    }
    
    func appoinmentlist(){
        
        KRProgressHUD.show()
        //{"start_date":"","end_date":"","provider_id":"1","role":"1"}

        var fromDate = btnFromDate.titleLabel!.text
        var toDate = btnToDate.titleLabel!.text
        
        if fromDate == "dd/mm/yyyy"{
             fromDate = ""
        }
        
        if toDate == "dd/mm/yyyy"{
            toDate = ""
        }
        
        //\(userDefaults.value(forKey: "pro_id")!)
        let parmetr = ["start_date":"\(fromDate!)","end_date":"\(toDate!)","provider_id":"\(userDefaults.value(forKey: "pro_id")!)","role":"1"]
        
        ProviderManager.shared.appointmentApiCall(params: parmetr) { (success, response, message) in
            
            if success == true{
                
               self.appointmentArray =  response
                 print(self.appointmentArray)
                
                for i in self.appointmentArray{
                    if i.app_book_status!  == "1"{
                        self.arrayOfPast.append(i)
                    }else{
                        self.arrayOfUpcomming.append(i)
                    }
                }
                
               self.tableviewdata.reloadData()
               KRProgressHUD.dismiss()
            }else {
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: message!, errortitle: "")
                })
                //print(error?.localizedCapitalized)
            }
        }
       
    }

    @IBAction func fromDateAction(_ sender: UIButton) {
        let alert = UIAlertController(style: .actionSheet, title: "", message: "Select Date")
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            Log(date)
            print(date)
            
            let stringDate = "\(date)"
            self.btnFromDate.setTitle(Utility.convertDateFormater(stringDate, dateFormat: "dd-MM-yyyy"), for: .normal)
        }
        alert.addAction(title: "Done", style: .cancel)
        
        alert.show()
        
    }
    
    @IBAction func toDateAction(_ sender: UIButton) {
        
        let alert = UIAlertController(style: .actionSheet, title: "", message: "Select Date")
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            Log(date)
            print(date)
            
            let stringDate = "\(date)"
            self.btnToDate.setTitle(Utility.convertDateFormater(stringDate, dateFormat: "dd-MM-yyyy"), for: .normal)
        }
        alert.addAction(title: "Done", style: .cancel)
        
        alert.show()
        
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

    @IBAction func btnUpcomingaction(_ sender: UIButton) {
        btnPast.setTitleColor(txtBlueColor, for: .normal)
        btnPast.layer.cornerRadius = 4
        btnPast.layer.borderWidth = 1
        btnPast.layer.borderColor = txtBlueColor.cgColor
        btnPast.clipsToBounds = true
        btnPast.setBackgroundImage(nil, for: .normal)
        btnUpcoming.setBackgroundImage(#imageLiteral(resourceName: "btnSignin"), for: .normal)
        btnUpcoming.setTitleColor(UIColor.white, for: .normal)
        self.isPast = false
        self.tableviewdata.reloadData()
        
    }
    
    @IBAction func btnPastaction(_ sender: UIButton) {
        btnPast.setTitleColor(UIColor.white, for: .normal)
        btnPast.setBackgroundImage(#imageLiteral(resourceName: "btnSignin"), for: .normal)
        btnUpcoming.setBackgroundImage(nil, for: .normal)
        btnUpcoming.layer.cornerRadius = 4
        btnUpcoming.layer.borderWidth = 1
        btnUpcoming.setTitleColor(txtBlueColor, for: .normal)
        btnUpcoming.layer.borderColor = txtBlueColor.cgColor
        btnUpcoming.clipsToBounds = true
        self.isPast = true
        self.tableviewdata.reloadData()
    }
    
    @IBAction func btnSearchAction(_ sender: UIButton) {
        appoinmentlist()
    }
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnAcceptAction(_ sender: UIButton) {
        acceptOrRejectAPI(value:sender.tag,statusAcceptOrReject:"1")
    }
    
    @IBAction func btnRejectAction(_ sender: UIButton) {
        acceptOrRejectAPI(value:sender.tag,statusAcceptOrReject:"0")
    }
    
    //Appointment API
    func getAppointmentList(){
        KRProgressHUD.show()
        
        let params = ["service_pro_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        ProviderManager.shared.listOfAppointment(parmas: params) { (success, response) in
            
            if success {
                self.arrayOfAppointment = response
               // self.collectionviewdata.reloadData()
            }else{
                Utility.showAlert(vc: self, strMessage: "Some thing went wrong.", alerttitle: "")
            }
            KRProgressHUD.dismiss()
        }
        
    }
    
    func acceptOrRejectAPI(value:Int,statusAcceptOrReject:String?){
        
        KRProgressHUD.show()
        
        let obj = arrayOfUpcomming[value]
        
        var date = "\(obj.app_date!)"
        var time = "\(obj.app_service_time!)"
        
        if date == "dd/mm/yyyy"{
            date = ""
        }
        if time == ""{
            time = ""
        }
        
        
        let params = ["date":"\(date)","user_id":"\(obj.id!)","provider_id":"1","role":"1","time":"\(time)","appointment_status":"\(statusAcceptOrReject!)","notes":""]
        
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
    
    //Tableview Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isPast == false{
            return self.arrayOfUpcomming.count
        }else{
             return self.arrayOfPast.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AppoinmentListVCell
        
        cell.bgView.layer.borderWidth = 1
        cell.bgView.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.selectionStyle = .none
        
        
        if isPast == true{

            let obj = arrayOfPast[indexPath.row]
            
            cell.acceptRejectView.isHidden = true
            cell.statusView.isHidden = true
            
            cell.statusView.layer.cornerRadius = 5
            cell.statusView.layer.shadowOpacity = 0.18
            cell.statusView.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.statusView.layer.shadowRadius = 2
            cell.statusView.layer.shadowColor = UIColor.black.cgColor
            cell.statusView.layer.masksToBounds = false
            cell.statusView.layer.cornerRadius = 8
            cell.lblStatus.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
            if  obj.app_status! == "0"{
                cell.lblStatus.text! = "Pending"
                cell.statusView.isHidden = false
            }else if obj.app_status! == "1"{
                cell.lblStatus.text! = "Accepted"
                cell.statusView.isHidden = false
            }else if obj.app_status! == "2"{
                cell.lblStatus.text! = "Rejected"
                cell.statusView.isHidden = false
            }
            
            cell.UserProfile.image = UIImage(named: "userIcon")
            cell.lblName.text = "\(obj.user_fname!) \(obj.user_lname!)"
            var str = ""
            for i in obj.service_list{
                
                if str == ""{
                    str = i.ser_cs_name!
                }else{
                    str = "\(str),\(i.ser_cs_name!)"
                }
                
            }
            
            cell.lblService.text = "\(str)"
            cell.lblTime.text = obj.app_service_time
            cell.lblDate.text = obj.app_date
           
            cell.UserProfile.sd_setImage(with: URL(string: obj.user_avatar!), completed: nil)
            
        }else{
            let obj = arrayOfUpcomming[indexPath.row]
            
            cell.acceptRejectView.isHidden = true
            cell.statusView.isHidden = true
            
            cell.statusView.layer.cornerRadius = 5
            cell.statusView.layer.shadowOpacity = 0.18
            cell.statusView.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.statusView.layer.shadowRadius = 2
            cell.statusView.layer.shadowColor = UIColor.black.cgColor
            cell.statusView.layer.masksToBounds = false
            cell.statusView.layer.cornerRadius = 8
            
            if  obj.app_status! == "0"{
                cell.lblStatus.text! = "Pending"
                cell.acceptRejectView.isHidden = false
            }else if obj.app_status! == "1"{
                cell.lblStatus.text! = "Accepted"
                cell.statusView.isHidden = false
                cell.lblStatus.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
            }else if obj.app_status! == "2"{
                cell.lblStatus.text! = "Rejected"
                cell.lblStatus.textColor = UIColor.white
                cell.statusView.isHidden = false
            }
            
            cell.UserProfile.image = UIImage(named: "userIcon")
            cell.lblName.text = "\(obj.user_fname!) \(obj.user_lname!)"
            var str = ""
            for i in obj.service_list{
                
                if str == ""{
                    str = i.ser_cs_name!
                }else{
                    str = "\(str),\(i.ser_cs_name!)"
                }
                
            }
            
            cell.lblService.text = "\(str)"
            cell.lblTime.text = obj.app_service_time
            cell.lblDate.text = obj.app_date
            // cell.UserProfile.sd_setImage(with: URL(string: "\(obj.user_avatar)")
            cell.UserProfile.sd_setImage(with: URL(string: obj.user_avatar!), completed: nil)
            
            
        }

        if isPast != true{
            cell.btnAccept.setBackgroundImage(#imageLiteral(resourceName: "agree"), for: .normal)
            cell.btnAccept.setTitle("Accept", for: .normal)
            cell.btnAccept.setTitleColor(UIColor.white, for: .normal)
            cell.btnAccept.layer.cornerRadius = 0
            cell.btnAccept.layer.borderWidth = 0
            cell.btnAccept.clipsToBounds = true
            cell.btnAccept.isUserInteractionEnabled = true
            
            cell.btnReject.setBackgroundImage(#imageLiteral(resourceName: "reject"), for: .normal)
            cell.btnReject.setTitle("Reject", for: .normal)
            cell.btnReject.setTitleColor(UIColor.white, for: .normal)
            cell.btnReject.layer.cornerRadius = 0
            cell.btnReject.layer.borderWidth = 0
            cell.btnReject.clipsToBounds = true
        }else{
           
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isPast == true{
            let obj = self.arrayOfPast[indexPath.row]
             performSegue(withIdentifier: "appointmentDetailSegue", sender: obj)
        }else{
            let obj = self.arrayOfUpcomming[indexPath.row]
            performSegue(withIdentifier: "appointmentDetailSegue", sender: obj)
        }
    
    }

   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "appointmentDetailSegue"{
            let obj = segue.destination as! AppointmentDetailsVC
            tabBarController?.tabBar.isHidden = false
          //obj.getObjDetail = arrayOfAppointment[index]
          obj.getObjDetaillist = sender as! AppointmentlistData
        }
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
