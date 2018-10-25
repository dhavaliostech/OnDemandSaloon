//
//  AppointmentBookingViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 12/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class SociaSignInViewController: UIViewController {

    @IBOutlet weak var fbView: UIView!
    
    @IBOutlet weak var emailView: UIView!
    
    @IBAction func fbAction(_ sender: UIButton) {
    }
    
    @IBAction func emailAction(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fbView.layer.borderWidth = 2
        self.emailView.layer.borderWidth = 2
        
            self.emailView.layer.borderColor = UIColor.init(red: 200/255, green: 55/255, blue: 46/255, alpha: 1).cgColor
        
            self.fbView.layer.borderColor = UIColor.init(red: 22/255, green: 62/255, blue: 147/255, alpha: 1).cgColor
      
        
        // Do any additional setup after loading the view.
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
