//
//  EmployeeListViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 22/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD
import SDWebImage


class EmployeeListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var employeeListTableView: UITableView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnUser: UIButton!
    
    
    var index:Int!
   
    
    var arrayOfEmplyee :[EmployeeList] = []
    
    let window = UIApplication.shared.keyWindow
    var tabbarController = ManageLoginTabBarController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.employeeListTableView.layer.cornerRadius = 5
        self.employeeListTableView.layer.borderWidth = 1
        self.employeeListTableView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        
        
        self.btnUser.layer.borderWidth = 1
        self.btnUser.layer.borderColor = UIColor.white.cgColor
        self.btnUser.layer.cornerRadius = 15
        
        self.btnUser.addTarget(self, action: #selector(btnUserAction(_:)), for: UIControlEvents.touchUpInside)

        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         getListOfEmpoyee()
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

    @IBAction func blockEmployeeAction(_ sender: UIButton) {
        //{"employee_id":"1","emp_status":"0","provider_id":"1"}
        
        var emStatus = ""
        
        let obj = arrayOfEmplyee[sender.tag]
        if obj.emStatus! == "1"{
            emStatus = "0"
        }else{
            emStatus = "1"
        }
        
        KRProgressHUD.show()
        let params = ["employee_id":"\(obj.emId!)","emp_status":"\(emStatus)","provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        ProviderManager.shared.blockEmployeeAPI(params: params) { (success, message) in
            
            if success == true{
                self.getListOfEmpoyee()
                KRProgressHUD.dismiss()
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
            }
            
        }
        
    }
    
    @IBAction func btnEditAction(_ sender: UIButton) {
       
       index = sender.tag
        self.performSegue(withIdentifier: "addNewEmployee", sender: true)
        
    }
    
    var tableVieHeight:CGFloat{
        self.employeeListTableView.layoutIfNeeded()
        return self.employeeListTableView.contentSize.height
        
    }
    
    @IBAction func btnMenuAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: "addNewEmployee", sender: nil)
    }
    

    
    func getListOfEmpoyee(){
        KRProgressHUD.show()
        //let parmas = ["provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        let parmas = ["provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        ProviderManager.shared.employeeListAPI(parmas: parmas) { (success, responseData, message) in
            
            if success == true{
                self.arrayOfEmplyee = responseData
                self.employeeListTableView.reloadData()
                self.heightConstraint.constant = self.tableVieHeight
                KRProgressHUD.dismiss()
                
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
            }
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfEmplyee.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeListCell") as! EmployeeListTableViewCell
        
        let obj = arrayOfEmplyee[indexPath.row]
        
        cell.btnBlockOrUnblock.tag = indexPath.row
        cell.btnEdit.tag = indexPath.row
        cell.lblUserName.text = "\(obj.emFName!) \(obj.emLName!)"
        //cell.lblLocation.text = areaArray[indexPath.row]
        cell.lblUserContactNumber.text = obj.emPhone!
        cell.imgUser.sd_setImage(with: URL(string: obj.emImage!), completed: nil)
        
        if obj.emStatus! == "1"{
            cell.btnBlockOrUnblock.setTitle("Unblock", for: .normal)
            cell.btnBlockOrUnblock.setBackgroundImage(#imageLiteral(resourceName: "agree"), for: .normal)
        }else{
            cell.btnBlockOrUnblock.setTitle("Block", for: .normal)
            cell.btnBlockOrUnblock.setBackgroundImage(#imageLiteral(resourceName: "reject"), for: .normal)
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
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
        
        if segue.identifier == "addNewEmployee"{
            let obj = segue.destination as! NewEmployeeViewController
            tabBarController?.tabBar.isHidden = false

            
            guard index != nil else{
                return
            }
            
            obj.empoyeeObj = arrayOfEmplyee[index]
            index = nil
            obj.isEdit = sender as! Bool
            
            
            
        }
    }
 

}
