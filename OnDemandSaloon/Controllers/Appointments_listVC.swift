//
//  Appointments_listVC.swift
//  SalonApp
//
//  Created by MANISH CHAUHAN on 7/17/18.
//  Copyright © 2018 MANISH CHAUHAN. All rights reserved.
//

import UIKit
import KRProgressHUD

class Appointments_listVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var lblMyAppointment: UILabel!
    @IBOutlet weak var btnService: UIButton!
    @IBOutlet weak var btnUpcoming: UIButton!
    @IBOutlet weak var UpcomingImg: UIImageView!
    @IBOutlet weak var lblUpcoming: UILabel!
    
    @IBOutlet weak var btnPast: UIButton!
    @IBOutlet weak var lblAppointmentList: UILabel!
    @IBOutlet weak var pastimg: UIImageView!
    @IBOutlet weak var lblPast: UILabel!
    
    @IBOutlet weak var tableviewdata: UITableView!
    
    //UpcomingImage
    //var UpcomingIamge:[UIImage] = [#imageLiteral(resourceName: "alarm"),#imageLiteral(resourceName: "alarm"),#imageLiteral(resourceName: "alarm")]
    var Cofirmed:[String] = ["Cofirmed","Cofirmed","Cofirmed"]
    var HairStyle:[String] = ["HairCut","HairCut","HairStyle"]
    var DateTime:[String] = ["March,28,10:12AM","June,28,10:14AM","April,28,10:09AM"]
    
    //Past
    var Pastimage:[UIImage] = [#imageLiteral(resourceName: "alarm"),#imageLiteral(resourceName: "alarm"),#imageLiteral(resourceName: "alarm")]
    var PastCofirmed:[String] = ["Cofirmed","Cofirmed","Cofirmed"]
    var PastHairStyle:[String] = ["HairCut","HairCut","HairStyle"]
    var PastDateTime:[String] = ["March,28,10:12PM","June,02,10:14PM","April,21,10:09PM"]
    
    var mainObj :ListOFUpcommingAndPastAppointments!
    var upcomingArray:[UserAppointment] = []
    var pastArray:[UserAppointment] = []
    
    var value = false
    
    var servicesString:String!
    override func viewDidLoad() {
        super.viewDidLoad()
   
        btnService.layer.cornerRadius = btnService.frame.size.width / 6
        btnService.layer.borderWidth = 1
        btnService.layer.borderColor = UIColor.white.cgColor
        btnService.clipsToBounds = true
        
        //btnUpcoming
        btnUpcoming.layer.borderWidth = 1
        btnUpcoming.layer.borderColor = UIColor.lightGray.cgColor
        btnUpcoming.isSelected = true
        btnService.clipsToBounds = true
        
        //btnPast
        btnPast.layer.borderWidth = 1
        btnPast.layer.borderColor = UIColor.lightGray.cgColor
        btnPast.clipsToBounds = true
        
        lblPast.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
        upcoming()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Utility.chnageBtnTitle(btn: btnService)

        self.tabBarController?.tabBar.isHidden = false
        
        if appDelegate.changeStoryBoard == true{
            appDelegate.changeStoryBoard = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        if appDelegate.changeStoryBoard == true{
            tabBarController?.tabBar.isHidden = true
        }else{
            tabBarController?.tabBar.isHidden = false
        }
    }
    
    func upcoming(){
        
        KRProgressHUD.show()
        //\(userDefaults.value(forKey: "user_id")!
        let parmiter = ["user_id":"\(userDefaults.value(forKey: "user_id")!)","role":"2"]
        
        UserManager.shared.bookDatailsApiCall(parmas: parmiter) { (success, error, response) in
            
            if success == true{
                
                self.mainObj = response
                
               self.upcomingArray = self.mainObj.arrayOfUpcomming
                self.pastArray = self.mainObj.arrayOfPast
                self.tableviewdata.reloadData()
            }
            else{
                print(error?.localizedCapitalized)
                KRProgressHUD.dismiss()
            }
            KRProgressHUD.dismiss()
        }
        
        
    }
    
    @IBAction func btnMenuAction(_ sender: UIButton) {
    }
    @IBAction func btnSellServiceAction(_ sender: UIButton) {
        if let getLogin = userDefaults.value(forKey: "pro_id") as? String{
            gotoPrvider()
            
        }else{
            createPopUp()
        }
    }
    
    @objc func createPopUp(){
        Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "Appointments_listVC", isLogin: false, isService: true )
    }
    @objc func gotoPrvider(){
        let sBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
        appDelegate.changeStoryBoard = true
        //tabBarController?.hidesBottomBarWhenPushed = true
        vc.hidesBottomBarWhenPushed = true
        vc.loadViewIfNeeded()
        userDefaults.set("provider", forKey: "lastLogin")
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func btnUpcomingAction(_ sender: UIButton) {
    
        if sender.tag == 1{
            
            btnUpcoming.isSelected = true
            if btnUpcoming.isSelected == true{
                UpcomingImg.image = UIImage(named: "btnSignin")
                lblUpcoming.textColor = UIColor.white
                
                pastimg.image = UIImage(named: "card")
                lblPast.textColor = UIColor(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
                value = false
                btnPast.isSelected = false
                value = false
            }
            
            btnUpcoming.isSelected = false
        }
        else if sender.tag == 2{
            
            sender.isSelected = true
            
            if sender.isSelected == true{
                value = true
                btnUpcoming.isSelected = false
                pastimg.image = UIImage(named: "btnSignin")
                lblPast.textColor = UIColor.white
                
                UpcomingImg.image = UIImage(named: "card")
                lblUpcoming.textColor =  UIColor(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
                value = true

            }
   
        }
        
        tableviewdata.reloadData()
  
    }
        
    @IBAction func btnPastAction(_ sender: UIButton) {
        if btnPast.isSelected == true{
            btnPast.setBackgroundImage(#imageLiteral(resourceName: "btnSignin"), for: .normal)
            btnUpcoming.isSelected = false
            btnUpcoming.setBackgroundImage(#imageLiteral(resourceName: "card"), for: .normal)
            btnUpcoming.setTitleColor(UIColor.blue, for: .normal)
            btnPast.setTitleColor(UIColor.white, for: .normal)
            //btnPast.isSelected  = false
        }
        else {
            btnPast.setBackgroundImage(#imageLiteral(resourceName: "card"), for: .normal)
            btnPast.setTitleColor(UIColor.blue, for: .normal)
            //btnPast.isSelected = true
        }
          tableviewdata.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if value == false{
              return upcomingArray.count
        }
       else if value == true{
            return pastArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AppointmentListCell
        
        cell.selectionStyle = .none
        
        if value == false{
            
            let obj = upcomingArray[indexPath.row]
            
        
            if obj.app_status! == "0"{
                cell.lblConfirmed.text! = "Pending"
            }else if obj.app_status! == "1"{
                cell.lblConfirmed.text! = "Accepted"
            }else if obj.app_status! == "2"{
                cell.lblConfirmed.text! = "Cancel"
            }
            
            var getUpcomingServices: [String] = []
            for i in obj.service_list{
                getUpcomingServices.append(i.ser_cs_name!)
            }
            var mainString :String!
            var value = 0
            for j in getUpcomingServices{
                
                if value == 0 {
                    mainString = "\(j)"
                    value = value + 1
                }else{
                    mainString = "\(mainString!), \(j)"
                    
                }
                
            }
            cell.lblSalonName.text! = obj.business_name!
            cell.lblHairStyle.text! = "\(mainString!)"
            cell.lblDateTime.text! = obj.app_date!
        }
        else if value == true{
            let obj = pastArray[indexPath.row]
            
            
            if obj.app_status! == "0"{
                cell.lblConfirmed.text! = "Pending"
            }else if obj.app_status! == "1"{
                cell.lblConfirmed.text! = "Accepted"
            }else if obj.app_status! == "2"{
                cell.lblConfirmed.text! = "Cancel"
            }
            
           // cell.lblConfirmed.text! = "Confirmed"
            
            var getPastServices: [String] = []
            for i in obj.service_list{
               getPastServices.append(i.ser_cs_name!)
            }
            cell.lblSalonName.text! = obj.business_name!

            
            var mainString :String!
            var value = 0
            for j in getPastServices{
            
                if value == 0 {
                    mainString = "\(j)"
                    value = value + 1
                }else{
                    mainString = "\(mainString!), \(j)"
                   
                }
                
            }
            
           cell.lblHairStyle.text! = mainString!
            
            cell.lblDateTime.text! = obj.app_date!
            
        }
        return cell
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
