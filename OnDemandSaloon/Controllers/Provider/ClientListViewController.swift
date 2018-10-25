//
//  ClientListViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 21/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD
import SDWebImage

class ClientListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var clientListTableView: UITableView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnUser: UIButton!
    
    @IBOutlet weak var btnAddNewClient: UIButton!

    var number :Int!
    
    var flag = false
    
    var clientListArray :[ClientLisiting] = []
    
    let window = UIApplication.shared.keyWindow
    var tabbarController = ManageLoginTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getlist()
        self.clientListTableView.layer.cornerRadius = 5
        self.clientListTableView.layer.borderWidth = 1
        self.clientListTableView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        //self.heightConstraint.constant = tableVieHeight
        
        self.btnUser.addTarget(self, action: #selector(btnUserAction(_:)), for: UIControlEvents.touchUpInside)
 
        self.btnUser.layer.borderWidth = 1
        self.btnUser.layer.borderColor = UIColor.white.cgColor
        self.btnUser.layer.cornerRadius = 15
        
        // Do any additional setup after loading the view.
    }
    
    func getlist(){
    
        KRProgressHUD.show()
        //\(userDefaults.value(forKey: "pro_id")!)
        let clientID = ["provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        ProviderManager.shared.clientListApi(parmas: clientID) { (success, response,errorMessage) in
            
            if success == true{
                self.clientListArray = response
               
                if self.clientListArray.count == 0{
                    self.clientListTableView.isHidden = true
                }else{
                    self.clientListTableView.isHidden = false
                }
                self.clientListTableView.reloadData()
                self.heightConstraint.constant = self.tableVieHeight
                KRProgressHUD.dismiss()
            }else{
                KRProgressHUD.dismiss({
                     Utility.showAlert(vc: self, strMessage: "\(errorMessage!)", alerttitle: "")
                })
            }
  
        }
        
    }
    
    
    @IBAction func addNewClientAction(_ sender: UIButton) {
        flag = false
        self.performSegue(withIdentifier: "addNewClient", sender: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getlist()
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
  
    var tableVieHeight:CGFloat{
        self.clientListTableView.layoutIfNeeded()
        
        return self.clientListTableView.contentSize.height
        
    }
    
    @IBAction func btnMenuAction(_ sender: UIButton) {
    }
    
    @IBAction func btnEditAction(_ sender: UIButton) {
        
        print("Action is working")
        number = sender.tag
        flag = true
        self.performSegue(withIdentifier: "addNewClient", sender: nil)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clientListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clientListCell") as! ClientListTableViewCell
        
        let obj = clientListArray[indexPath.row]
        
        cell.lblLocation.text = obj.strClCity
        cell.lblUserName.text = "\(obj.strClFname!) \(obj.strClLName!)"
        cell.lblUserContactNumber.text = obj.strClPhone
        cell.btnEdit.tag = indexPath.row
        cell.imgUser.sd_setImage(with: URL(string: obj.strClImage!), completed: nil)
        cell.selectionStyle = .none
        return cell
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
        
        if segue.identifier == "addNewClient"{
            let obj = segue.destination as! AddNewClientViewController
            tabBarController?.tabBar.isHidden = false
            
            if flag == true {
                obj.getObject = self.clientListArray[number]
                obj.isShow = true
            }
            
        }
        
    }
 

}



