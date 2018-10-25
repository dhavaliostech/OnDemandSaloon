//
//  ManageLoginTabBarController.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 29/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class ManageLoginTabBarController: UITabBarController,UITabBarControllerDelegate {

     var getIndexForCurrentTab = 0
    var fromUserSigniN = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
//        if fromUserSigniN == true{
//            let sBoard = UIStoryboard.init(name: "User", bundle: nil)
//            let gotoVc  = sBoard.instantiateViewController(withIdentifier: "UserTabBar") as! UserTabBarController
//            gotoVc.selectedIndex = 1
//            gotoVc.hidesBottomBarWhenPushed = true
//            appDelegate.userLogin = true
//            self.navigationController?.pushViewController(gotoVc, animated: true)
//        }
        
        // Do any additional setup after loading the view.
    }

    func get(){
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        if selectedIndex != 2{
            getIndexForCurrentTab = selectedIndex
        }
        if let getController = viewController as? UINavigationController {
            
            if (getController.visibleViewController?.isKind(of: ChildPopUpViewController.self))!{
                if getIndexForCurrentTab == 0{
                    Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "UserHomeViewController", isLogin: true, isService: false)
                }else{
                    Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "SearchViewController", isLogin: true, isService: false)
                }
                return false
            }
            else{
                return true
            }
            
        }

        return Bool()
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
