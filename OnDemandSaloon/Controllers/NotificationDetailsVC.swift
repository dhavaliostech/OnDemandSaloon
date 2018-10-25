//
//  NotificationDetailsVC.swift
//  OnDemandSaloon
//
//  Created by Saavaj on 08/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD

class NotificationDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   

    @IBOutlet weak var btnBusinessProfile: UIButton!
    
    @IBOutlet weak var lblMessageError: UILabel!
    
    @IBOutlet weak var tableviewdata: UITableView!
    
   
    
    var notiifcationsArray:[GetAllNotifications] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnBusinessProfile.layer.borderWidth = 1
        self.btnBusinessProfile.layer.borderColor = UIColor.white.cgColor
        self.btnBusinessProfile.layer.cornerRadius = self.btnBusinessProfile.frame.size.height / 2
        getNotidication()
//        if arrDate.count == 0{
//             view.bringSubview(toFront: lblMessageError)
//        }
//        else {
//            view.bringSubview(toFront: tableviewdata)
//        }
     
//
        // Do any additional setup after loading the view.
    }

    func getNotidication(){
        KRProgressHUD.show()
        //\(userDefaults.value(forKey: "user_id")!)
        let params = ["user_id":"\(userDefaults.value(forKey: "user_id")!)"]
        
        UserManager.shared.getAllNotificationAPI(parmas: params) { (success, message, response) in
            
            if success == true{
               self.notiifcationsArray = response
                self.tableviewdata.reloadData()
            }else{
                self.view.bringSubview(toFront: self.lblMessageError)
            }
         
            KRProgressHUD.dismiss()
        }
    }
    
    @IBAction func btnSellServiceAction(_ sender: UIButton) {
        if let getLogin = userDefaults.value(forKey: "pro_id") as? String{
            
            gotoPrvider()
            
        }else{
            createPopUp()
        }
    }
    
    @objc func createPopUp(){
        Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "NotificationVC", isLogin: false, isService: true )
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notiifcationsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationCell
        
        let obj = notiifcationsArray[indexPath.row]
        
        cell.lblDate.text = Utility.customDateFormatter(date: obj.created_date!, fromDateFormat: "yyyy-mm-dd HH:mm:ss", toDateFormat: "dd-mm-yyyy")
        cell.lblTime.text =  Utility.customDateFormatter(date: obj.created_date!, fromDateFormat: "yyyy-mm-dd HH:mm:ss", toDateFormat: "HH:mm a")
        cell.lblSaloonName.text = obj.business_name!
        cell.lblMessage.text =  obj.strNotification_text!
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) { self.navigationController?.popViewController(animated: true)
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
