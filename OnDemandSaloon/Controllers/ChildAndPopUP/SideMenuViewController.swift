//
//  SideMenuViewController.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 27/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var sideMenuTableView: UITableView!
    
    var parentController : UserHomeViewController?
    var getParentController = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //parentController = parent?.navigationController?.getVC(viewController: getParentController)
        
        // Do any additional setup after loading the view.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuCell")
        
        return cell!
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


//extension UINavigationController {
//
//    func getParent(viewController:String?) -> UIViewController {
//        for element in viewControllers as Array {
//            if "\(type(of: element)).Type" == "\(type(of: viewController))" {
//                return element
//                //self.popToViewController(element, animated: true)
//                //break
//            }
//        }
//        return UIViewController()
//    }
//
//}

