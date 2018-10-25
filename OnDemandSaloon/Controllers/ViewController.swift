//
//  ViewController.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 29/05/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import SCPageControl

public enum SCPageStyle: Int {
    case SCNormal = 100
    case SCJAMoveCircle // Design by Jardson Almeida
    case SCJAFillCircle // Design by Jardson Almeida
    case SCJAFlatBar // Design by Jardson Almeida
}

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let sc = SCPageControlView()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var btnSkip: UIButton!
    
    @IBOutlet weak var backGroundImage: UIImageView!
    
    @IBOutlet weak var introCollectionView: UICollectionView!
    
    var tabbarController = ManageLoginTabBarController()

    let window = UIApplication.shared.keyWindow
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let getNone = userDefaults.value(forKey: "lastLogin") as? String{
            
            if getNone == "none"{
                self.loadHomePage(flag: false)
            }
            
        }
//        userDefaults.set("isFirstTime", forKey: "isFirstTime")
//        userDefaults.synchronize()
        sc.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height-50, width: UIScreen.main.bounds.size.width, height: 50)
        sc.scp_style = .SCNormal
        sc.set_view(3, current: 0, tint_color: UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1))
       
        view.addSubview(sc)
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print(indexPath.item)
        btnSkip.tag = indexPath.row
    }
    
    
    @IBAction func btnSkipaction(_ sender: UIButton) {
        
//        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
//        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ChooseServiceViewController") as! ChooseServiceViewController
//        self.navigationController?.pushViewController(nextViewController, animated:true)
//
        userDefaults.set(true, forKey: "introFlag")
        userDefaults.synchronize()
        
        
        if appDelegate.userLogin == false{
             self.loadHomePage(flag: true)
        }
        //self.view.addSubview(window!)
        
    }
    
    func loadHomePage(flag:Bool) {
        Utility.modifiedTabBar(tabBarController: tabbarController)
        
        self.window?.rootViewController = self.tabbarController
        
        self.navigationController?.pushViewController(tabbarController, animated: flag)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IntroScreenCollectionViewCell
        
        cell.lineView.layer.cornerRadius = 2
        
        cell.mainLbl.text = "Information for to help you set up your account. We have tried to make it as easy as possible."
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        sc.scroll_did(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if let indexPath = introCollectionView.indexPathsForVisibleItems.first{
            
            if indexPath.item == 0{
                backGroundImage.image = #imageLiteral(resourceName: "pagerScreen")
            }else if indexPath.item == 1{
                backGroundImage.image = #imageLiteral(resourceName: "background3")
            }else if indexPath.item == 2{
                backGroundImage.image = #imageLiteral(resourceName: "background2")
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

