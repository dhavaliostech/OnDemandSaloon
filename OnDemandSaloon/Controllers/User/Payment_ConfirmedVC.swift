//
//  Payment_ConfirmedVC.swift
//  SalonApp
//
//  Created by Pratik Zankat on 19/07/18.
//  Copyright © 2018 MANISH CHAUHAN. All rights reserved.
//

import UIKit

class Payment_ConfirmedVC: UIViewController {

    @IBOutlet var bgview: UIView!
    
    @IBOutlet var secondview: UIView!
    
    @IBOutlet var reightImage: UIImageView!
    
    @IBOutlet var lblThank: UILabel!
    
    @IBOutlet var lblConfirmentpayment: UILabel!
    
    @IBOutlet var btnContinue: UIButton!
    
    let window = UIApplication.shared.keyWindow
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bgview.layer.cornerRadius = 2
        bgview.clipsToBounds = true
        secondview.layer.cornerRadius = 3
        secondview.clipsToBounds = true
        secondview.layer.masksToBounds = false
        secondview.layer.shadowColor = UIColor.black.cgColor
        secondview.layer.shadowOpacity = 0.5
        secondview.layer.shadowOffset = CGSize(width: -1, height: 1)
        secondview.layer.shadowRadius = 2
        
     
        
       // secondview.layer.rasterizationScale = scalb ? UIScreen.main.scale : 1
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if appDelegate.changeStoryBoard == true{
            self.tabBarController?.tabBar.isHidden = true
        }else{
            self.tabBarController?.tabBar.isHidden = true
        }
   
    }
    
    
    @IBAction func btnContinue(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
        vc.loadViewIfNeeded()

        self.navigationController?.popToRootViewController(animated: true)
        
        
        
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
