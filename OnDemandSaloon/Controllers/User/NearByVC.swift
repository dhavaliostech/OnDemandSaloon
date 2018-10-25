//
//  NearByVC.swift
//  demo1
//
//  Created by PS on 01/08/18.
//  Copyright © 2018 PS. All rights reserved.
//

import UIKit
import CoreLocation
import KRProgressHUD
import SDWebImage
import FloatRatingView

class NearByVC: UIViewController {

    
    @IBOutlet weak var btnServices: UIButton!
    @IBOutlet weak var nearByCollectionView: UICollectionView!
    
    var listOfNearByArray:[NearBy] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utility.chnageBtnTitle(btn: btnServices)
        getNearBySalonData()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tabBarController?.tabBar.isHidden = false
        self.btnServices.layer.borderWidth = 1
        self.btnServices.layer.borderColor = UIColor.white.cgColor
        self.btnServices.layer.cornerRadius = self.btnServices.height / 2
        //self.calendarView.selectDate(today)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if appDelegate.changeStoryBoard == true{
            self.tabBarController?.tabBar.isHidden = true
        }else{
            self.tabBarController?.tabBar.isHidden = false
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
        Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "UserHomeViewController", isLogin: false, isService: true )
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
    
    func getNearBySalonData(){

        KRProgressHUD.show()

        currentLocation.desiredAccuracy = kCLLocationAccuracyBest

        let location = currentLocation.location?.coordinate

        let latitude = location?.longitude
        let longitude = location?.longitude

        let params = ["latitude":"123","longitude":"456"]

        UserManager.shared.getListOfNearBySalons(param: params) { (success, responseData, message) in

            if success == true{

                self.listOfNearByArray = responseData

                self.nearByCollectionView.reloadData()
                KRProgressHUD.dismiss()
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message)", errortitle: "")
                })

            }

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackacion(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
extension NearByVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FloatRatingViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfNearByArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "nearBY", for: indexPath) as! NearByCollectionViewCell
        
        let obj = listOfNearByArray[indexPath.item]
        
         cell.ratingView.delegate = self
        //secondCell.ratingView.editable = true
        cell.ratingView.type = .floatRatings
        
        
        cell.backView.layer.cornerRadius = 5
        //secondCell.backView.layer.borderWidth = 1
        cell.backView.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.layer.cornerRadius = 5
        cell.layer.shadowOpacity = 0.18
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 2
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 8
        
        cell.lblLocation.text! = obj.user_location!
        cell.lblReview.text! = "\(obj.total_review!) reviews"
        cell.lblPercentageHappyCustomer.text! = "\(obj.happy_performance!)% Happy Customers."
        cell.lblSaloonName.text! = obj.business_name!
        cell.ratingView.rating = Double(obj.rat_out_of_5!)!
        cell.strImage.sd_setImage(with: URL(string: obj.banner_name!), completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! NearByCollectionViewCell
        
        let obj = listOfNearByArray[indexPath.item]
        
        if obj.salon_Id! != ""{
            let sBoard = UIStoryboard.init(name: "User", bundle: nil)
            let vc = sBoard.instantiateViewController(withIdentifier: "ServiceViewController") as! ServiceViewController
            vc.salonID = obj.salon_Id!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width , height: 156)
    }
    
    
}
