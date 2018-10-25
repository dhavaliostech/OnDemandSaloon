//
//  UserTabBarController.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 05/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class UserTabBarController: UITabBarController,UITabBarControllerDelegate {

    var getIndexForCurrentTab = 0

    var isSigin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
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
