//
//  ViewOffresAdminVC.swift
//  demo1
//
//  Created by PS on 08/08/18.
//  Copyright © 2018 PS. All rights reserved.
//

import UIKit
import KRProgressHUD

class ViewOffresAdminVC: UIViewController {

    var arrViewOffer:[ViewOffersData] = []
    
    @IBOutlet weak var tblOffers: UITableView!
    
    @IBOutlet weak var btnUser: UIButton!
    let window = UIApplication.shared.keyWindow
    var tabbarControllerCreated = ManageLoginTabBarController()
    let shapeLayer = CAShapeLayer()
    
    var tabbarController = ManageLoginTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // viewOffers()
        // Do any additional setup after loading the view.
        
        self.btnUser.addTarget(self, action: #selector(btnUserAction(_:)), for: UIControlEvents.touchUpInside)
        self.btnUser.layer.borderWidth = 1
        self.btnUser.layer.borderColor = UIColor.white.cgColor
        self.btnUser.layer.cornerRadius = self.btnUser.frame.size.height / 2
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        viewOffers()
        
    }
    
    @IBAction func btnEditAction(_ sender: UIButton) {
        
        
        let obj = self.arrViewOffer[sender.tag]
         self.performSegue(withIdentifier: "detailOffersSegue", sender: obj)
        
    }
    
    @objc func btnUserAction(_ sender:UIButton){
      
        if let userLoginFlag = userDefaults.value(forKey: "user_id") as? String{
            pushView()
   
        }else{
            loadHomePage()
        }
        
    }
    
    @objc func pushView(){
        let sBoard = UIStoryboard.init(name: "User", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "UserTabBar") as! UserTabBarController
        //        vc.hidesBottomBarWhenPushed = false
        vc.hidesBottomBarWhenPushed = true
        userDefaults.set("user", forKey: "lastLogin")
        appDelegate.changeStoryBoard = true
        self.navigationController?.pushViewController(vc, animated: false)
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
    
    
    @IBAction func btnBackaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func viewOffers(){
        KRProgressHUD.show()
        
        let paramter = ["provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        ProviderManager.shared.viewsOffersAPIcall(params: paramter) { (success, response, error) in
            
            if success ==  true{
                self.arrViewOffer = response
                self.tblOffers.reloadData()
                print(self.arrViewOffer)
                
            }
            else {
                print(error?.localizedCapitalized)
            }
            KRProgressHUD.dismiss()
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "detailOffersSegue"{
            let obj = segue.destination as! AddOffersViewController
            tabBarController?.tabBar.isHidden = false
            
            tabBarController?.tabBar.isHidden = false
            obj.isViewOffer = true
            
            if sender != nil{
                obj.editOffersArray = sender as! ViewOffersData
            }
            
        }
        
    }

}

extension ViewOffresAdminVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrViewOffer.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewOffersAdminCell") as! ViewOffersAdminCell
        cell.btnEdit.tag = indexPath.row
        
        let obj = arrViewOffer[indexPath.row]
        
        cell.lblTitle.text = obj.off_name!
        cell.lblDate.text = "\(obj.off_start_date!) \(obj.off_end_date!)"
        cell.lblDetails.text = obj.off_desc!
        cell.backView.layer.shadowOpacity = 0.18
        cell.backView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.backView.layer.shadowRadius = 2
        cell.backView.layer.shadowColor = UIColor.black.cgColor
        cell.backView.layer.masksToBounds = false
        
        cell.backView.layer.cornerRadius = 8
        cell.selectionStyle = .none
        tableView.tableFooterView = UIView()
        return cell
        
    }
    
}
