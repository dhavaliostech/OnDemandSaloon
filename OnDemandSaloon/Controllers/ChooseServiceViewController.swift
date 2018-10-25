//
//  ChooseServiceViewController.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 01/06/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class ChooseServiceViewController: UIViewController {

    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var imgServiceProvider: UIImageView!
    
    @IBOutlet weak var btnUser: UIButton!
    
    @IBOutlet weak var btnServiceProvider: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnUser.layer.cornerRadius = 5
        self.btnUser.layer.borderWidth = 2
        self.btnUser.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
    }

   
    @IBAction func btnUserAction(_ sender: UIButton) {
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//        self.navigationController?.pushViewController(nextViewController, animated:true)
         //self.performSegue(withIdentifier: "loginSegue", sender: nil)
        
        let storyBoard = UIStoryboard.init(name: "User", bundle: nil)
        let gotoUserVc = storyBoard.instantiateViewController(withIdentifier: "UserTabBarController") as! UserTabBarController
        navigationController?.pushViewController(gotoUserVc, animated: true)
    }
    
    @IBAction func serviceProviderAction(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(nextViewController, animated:true)
        // self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "loginSegue"{
            
            //let obj = segue.destination as! LoginVC
            
        }
    }
    

}
