//
//  PackagesVC.swift
//  SalonApp
//
//  Created by Pratik Zankat on 19/07/18.
//  Copyright © 2018 MANISH CHAUHAN. All rights reserved.
//

import UIKit
import KRProgressHUD

class PackagesVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet var btnMenu: NSLayoutConstraint!
    
    @IBOutlet var lblPackages: UILabel!
    
    @IBOutlet var btnService: UIButton!
    
    @IBOutlet var btnStandard: UIButton!
    
    @IBOutlet var btnAdvance: UIButton!
    
    @IBOutlet var btnPremier: UIButton!
    
    @IBOutlet var collectionviewdata: UICollectionView!
    
    var packages:Packages!
    
    
    
    var advanceArray:[String] = []
    var standardArray:[String] = []
    var premierArray:[String] = []
    
    var advanceObj :Advance!
    var standardObj:Standard!
    var premierObj:Premier!
    
    var currentPackage :String!
    
    var isStandar = false
    var isAdvance = false
    var isPremier = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getPackages()
        
        btnService.layer.cornerRadius = btnService.frame.size.height / 2
        btnService.layer.borderWidth = 1
        btnService.layer.borderColor = UIColor.white.cgColor
        btnService.clipsToBounds = true
       
        
        //btnStandard.isSelected = true

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Utility.chnageBtnTitle(btn: btnService)
        if appDelegate.changeStoryBoard == true{
            appDelegate.changeStoryBoard = false
        }
        tabBarController?.tabBar.isHidden = false
        //tabBarController?.hidesBottomBarWhenPushed = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if appDelegate.changeStoryBoard == true{
            self.tabBarController?.tabBar.isHidden = true
        }else{
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    func getPackages(){
        KRProgressHUD.show()

        UserManager.shared.viewPackages(param: [:]) { (suceess, responseData, message) in
            
            if suceess == true{
                self.packages = responseData
                
                self.advanceObj = self.packages.advance
                self.standardObj = self.packages.standard
                self.premierObj = self.packages.premier
 
                self.advanceArray = self.advanceObj.pack_desc!.components(separatedBy: "\r\n")
                self.standardArray = self.standardObj.pack_desc!.components(separatedBy: "\r\n")
                self.premierArray = self.standardObj.pack_desc!.components(separatedBy: "\r\n")
               
                self.btnStandard.alpha = 1
                self.btnAdvance.alpha = 0.5
                self.btnPremier.alpha = 0.5
                self.currentPackage = "Standard"
                self.isStandar = true
                
                self.collectionviewdata.reloadData()
            }else{
                
            }
            KRProgressHUD.dismiss()
        }
    }
    
    @IBAction func btnBuyNowaction(_ sender: UIButton) {
        
        if let getLogin = userDefaults.value(forKey: "userLogin") as? Bool{
            if getLogin == true{
                
                gotoPayAction()
            }else{
                Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "PackagesVC", isLogin: true, isService: false)
            }
        }else{
            Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "PackagesVC", isLogin: true, isService: false)
        }
        
    }
    
    func gotoPayAction(){
        let obj = UIStoryboard.init(name: "User", bundle: nil)
        let vc = obj.instantiateViewController(withIdentifier: "PaymentCompleteVC") as! PaymentCompleteVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSellYourServices(_ sender: UIButton) {
        
        if let getLogin = userDefaults.value(forKey: "serviceProviderLogin") as? Bool{
            if getLogin == true{
               gotoServiceProvider()
            }else{
               createPopUp()
            }
        }else{
            createPopUp()
        }
        
    }
    
    @objc func createPopUp(){
        Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "PackagesVC", isLogin: false, isService: true )
    }
    
    @objc func gotoServiceProvider(){
        let sBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sBoard.instantiateViewController(withIdentifier: "MainTabBarViewController") as! MainTabBarViewController
        appDelegate.changeStoryBoard = true
        //tabBarController?.hidesBottomBarWhenPushed = true
        vc.hidesBottomBarWhenPushed = true
        vc.loadViewIfNeeded()

        tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func btnStandaedAction(_ sender: UIButton) {
        var current = Int()
        
        if sender.tag == 1{
           
                btnStandard.alpha = 1
                btnAdvance.alpha = 0.5
                btnPremier.alpha = 0.5
                currentPackage = "Standard"
                //collectionviewdata.reloadData()
                collectionviewdata.scrollToItem(at: IndexPath(item: 0, section: 0), at: UICollectionViewScrollPosition.left, animated: true)
                current = sender.tag
            
                print("Sucsses")
        }
       else  if  sender.tag == 2{
        
                btnAdvance.alpha = 1
                btnStandard.alpha = 0.5
                btnPremier.alpha = 0.5
                currentPackage = "Advance"
            if current > 1{
                collectionviewdata.scrollToItem(at: IndexPath(item: 1, section: 0), at: .right, animated: true)
            }else{
                collectionviewdata.scrollToItem(at: IndexPath(item: 1, section: 0), at: .left, animated: true)
            }
            
            current = sender.tag
            print("Sucsses")
           
        }
      else if sender.tag == 3{
           
                btnAdvance.alpha = 0.5
                btnStandard.alpha = 0.5
                btnPremier.alpha = 1
                current = sender.tag
                currentPackage = "Premier"
                isPremier = true
                collectionviewdata.scrollToItem(at: IndexPath(item: 2, section: 0), at: .right, animated: true)
            
                print("Sucsses")
            
      }
     
        collectionviewdata.reloadData()
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PackagesCell
        
        cell.serviceTableView.delegate = self
        cell.serviceTableView.dataSource = self
        //cell.serviceTableView.reloadData()
        
        if isStandar{
            cell.serviceTableView.reloadData()
            isStandar = false
            cell.lblPrice.text = "$ \(standardObj.pack_price!)"
            
        }else if isAdvance{
            cell.serviceTableView.reloadData()
            isAdvance = false
            cell.lblPrice.text = "$ \(advanceObj.pack_price!)"
        }else if isPremier{
            cell.serviceTableView.reloadData()
            isPremier = false
            cell.lblPrice.text = "$ \(premierObj.pack_price!)"
        }
        cell.serviceConstraint.constant = cell.serviceTableView.contentSize.height
    
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                cell.buyConstraint.constant = 0
                //cell.serviceConstraint.constant = 120
                print("iPhone 5 or 5S or 5C")
            case 1334:
                print("iPhone 6/6S/7/8")
                cell.buyConstraint.constant = -5
                //cell.serviceConstraint.constant = 150
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                cell.buyConstraint.constant = -7
                //cell.serviceConstraint.constant = 150
            case 2436:
                print("iPhone X")
                cell.buyConstraint.constant = -7
            default:
                print("unknown")
            }
        }
        cell.btnBuyNow.layer.cornerRadius = cell.btnBuyNow.frame.size.height / 2
        cell.btnBuyNow.clipsToBounds = true
        cell.btnBuyNow.layer.borderWidth = 0.8
        cell.btnBuyNow.layer.borderColor = UIColor.lightGray.cgColor
        cell.btnBuyNow.layer.masksToBounds = false
        cell.btnBuyNow.layer.shadowColor = UIColor.clear.cgColor
        cell.btnBuyNow.layer.shadowOpacity = 0.5
        cell.btnBuyNow.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.btnBuyNow.layer.shadowRadius = 1
        
        
//      cell.btnBuyNow.layer.shadowPath = UIBezierPath(rect:CGRect(x: 0.5, y: 0.5, width:  cell.btnBuyNow.frame.size.width, height:  cell.btnBuyNow.frame.size.height)).cgPath
//       cell.btnBuyNow.layer.shouldRasterize = true
 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let Width = collectionviewdata.frame.size.width
        return CGSize(width:Width , height:collectionView.frame.size.height)
        
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

extension PackagesVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        if currentPackage == "Standard"{
            return standardArray.count
        }else if currentPackage == "Advance"{
            return advanceArray.count
        }else if currentPackage == "Premier"{
            return premierArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        if currentPackage == "Standard"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell")!
            cell.textLabel?.text = standardArray[indexPath.row]
            return cell
        }else if currentPackage == "Advance"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell")!
            cell.textLabel?.text = advanceArray[indexPath.row]
            return cell
        }else if currentPackage == "Premier"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "serviceCell")!
            cell.textLabel?.text = premierArray[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
