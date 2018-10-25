//
//  ViewOffersVcViewController.swift
//  demo1
//
//  Created by PS on 08/08/18.
//  Copyright © 2018 PS. All rights reserved.
//

import UIKit
import FloatRatingView
import SDWebImage

class ViewOffersVcViewController: UIViewController {

    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var lblDiscription: UILabel!
    @IBOutlet weak var lblFromDate: UILabel!
    
    @IBOutlet weak var lblToDate: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var offerTitleView: UIView!
    
    @IBOutlet weak var offerDateView: UIView!
    
    @IBOutlet weak var offerDiscriptionView: UIView!
    
    @IBOutlet weak var salonImage: UIImageView!
    var getSelectedObj :Today_Offer!
    
    @IBOutlet weak var btnServices: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if getSelectedObj != nil{
            
            self.lblName.text = "\(getSelectedObj.business_name!)"
            
            self.lblTitle.text = "\(getSelectedObj.Off_name!)"
            self.lblAddress.text = "\(getSelectedObj.user_location!)"
            self.lblDiscription.text = "\(getSelectedObj.off_desc!)"
            
            
            if getSelectedObj.rat_out_of_5! != "<null>" && getSelectedObj.rat_out_of_5! != ""{
                self.ratingView.rating = Double(getSelectedObj.rat_out_of_5!)!
            }
            
            self.lblFromDate.text = "\(getSelectedObj.off_start_date!)"
            self.lblToDate.text = "\(getSelectedObj.off_end_date!)"
            self.salonImage.sd_setImage(with: URL(string: getSelectedObj.banner_name!), completed: nil)
            
        }else{
            self.lblName.text = "Dubai Celeb"
            
            self.lblTitle.text = "August Celebration"
            self.lblAddress.text = "Abu Dhabi"
            self.lblDiscription.text = "This offer is for only selected customers."
            self.ratingView.rating = 4.9
        }
        
        
        Utility.setBoarderAndColorOfView(getview: offerTitleView)
        Utility.setBoarderAndColorOfView(getview: offerDateView)
        Utility.setBoarderAndColorOfView(getview: offerDiscriptionView)

        self.btnServices.layer.borderWidth = 1
        self.btnServices.layer.borderColor = UIColor.white.cgColor
        self.btnServices.layer.cornerRadius = self.btnServices.height / 2
        // Do any additional setup after loading the view.
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
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        
        
        self.navigationController?.popViewController(animated: true)
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
