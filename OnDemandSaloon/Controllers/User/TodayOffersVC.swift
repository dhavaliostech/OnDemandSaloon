//
//  TodayOffersVC.swift
//  demo1
//
//  Created by PS on 01/08/18.
//  Copyright © 2018 PS. All rights reserved.
//

import UIKit
import KRProgressHUD

class TodayOffersVC: UIViewController {

    @IBOutlet weak var btnServices: UIButton!
    
    @IBOutlet weak var todayOffersTableView: UITableView!
    
    var todayOfferArray:[Today_Offer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnServices.layer.borderWidth = 1
        self.btnServices.layer.borderColor = UIColor.white.cgColor
        self.btnServices.layer.cornerRadius = self.btnServices.height / 2
        getTodayOffersData()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if appDelegate.changeStoryBoard == true{
            appDelegate.changeStoryBoard = false
        }
    }
    
    func getTodayOffersData(){
    
        KRProgressHUD.show()
        UserManager.shared.todayOffersList(param: [:]) { (success, reponseData, message) in
            
            if success == true{
                
                self.todayOfferArray = reponseData
                
                self.todayOffersTableView.reloadData()
            }else{
                
            }
            KRProgressHUD.dismiss()
        }
    
    
    }
    
    @IBAction func sellYourServicesAction(_ sender: UIButton) {
        
        if let getLogin = userDefaults.value(forKey: "pro_id") as? String{
            
          gotoServiceProvider()
            
        }else{
            createPopUp()
            
        }
        
    }
    
    @objc func createPopUp(){
        Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "TodayOffersVC", isLogin: false, isService: true )
    }
    
    @objc func gotoServiceProvider(){
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
    
    @IBAction func btnBackAction(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
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
        
        if segue.identifier == "detailsOfferSegue"{
            let obj = segue.destination as! ViewOffersVcViewController
            obj.getSelectedObj = sender as! Today_Offer
        }
        
    }
 

}
extension TodayOffersVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayOfferArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodayOffersTableViewCell") as? TodayOffersTableViewCell
        
        let obj = todayOfferArray[indexPath.row]
        
        cell?.BackView.layer.shadowOpacity = 0.18
        cell?.BackView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell?.BackView.layer.shadowRadius = 2
        cell?.BackView.layer.shadowColor = UIColor.black.cgColor
        cell?.BackView.layer.masksToBounds = false
        cell?.BackView.layer.cornerRadius = 8
//        cell?.BackView.layer.borderWidth = 1
//        cell?.BackView.layer.cornerRadius = 4
//        cell?.BackView.clipsToBounds = true
//        cell?.BackView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0,alpha: 1.0).cgColor
        cell?.selectionStyle = .none
        tableView.tableFooterView = UIView()
       
        cell?.lblDate.text = "\(obj.off_start_date!) To \(obj.off_end_date!)"
        cell?.lblTitle.text = "\(obj.Off_name!)"
        cell?.lblDescription.text = "\(obj.off_desc!)"

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedOBj = todayOfferArray[indexPath.row]
        
        self.performSegue(withIdentifier: "detailsOfferSegue", sender: selectedOBj)
    }
    
}
