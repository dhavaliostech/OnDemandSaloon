//
//  UserHomeViewController.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 06/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD
import SDWebImage

class UserHomeViewController: UIViewController,UITextFieldDelegate{
   
    
    
    @IBOutlet weak var mainTableView: UITableView!
    
   
    @IBOutlet weak var btnServices: UIButton!
    var catagoryArrayOfCollection : [String] = ["Hair Salons","Nail Spa","Bridal Make up","Spa Massage","Brows","Body Art","Mani Cure","Facial"]
    var arrServices: [ListOfMainCategories] = []
    var arrSearchData:[ListOfMainCategories] = []
    var getService: [ListOfMainCategories] = []
    var arrayOFFisrtCollection : [UIImage] = [#imageLiteral(resourceName: "nearBy"),#imageLiteral(resourceName: "offers")]
    //var catagoryArrCollection: [UIImage] = [#imageLiteral(resourceName: "hairSalon"),#imageLiteral(resourceName: "nailSpa"),#imageLiteral(resourceName: "bridalMakeup"),#imageLiteral(resourceName: "spaMasssage"),#imageLiteral(resourceName: "brows"),#imageLiteral(resourceName: "bodyArt"),#imageLiteral(resourceName: "maniCure"),#imageLiteral(resourceName: "facial")]
    
    var catCollectionHeight :CGFloat!
    
    @IBOutlet weak var FirstCollectionView: UICollectionView!
    
    @IBOutlet weak var SecondCollectionView: UICollectionView!
    
    var isSearch = false
    
    var isFirstFlag = false
    
    var collectionViewHeight = 0
    
    @IBOutlet weak var txtFieldSearchBar: UITextField!
    
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         txtFieldSearchBar.addTarget(self, action: #selector(self.didChangeText), for: .editingChanged)
        
        getCategories()
        
        if appDelegate.changeStoryBoard == true{
            appDelegate.changeStoryBoard = false
        }
        
        self.btnServices.layer.borderWidth = 1
        self.btnServices.layer.borderColor = UIColor.white.cgColor
        self.btnServices.layer.cornerRadius = self.btnServices.height / 2

        self.tabBarController?.tabBar.isHidden = false
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Utility.chnageBtnTitle(btn: btnServices)
        tabBarController?.tabBar.isHidden = false
        tabBarController?.hidesBottomBarWhenPushed = false
        if appDelegate.changeStoryBoard == true{
            appDelegate.changeStoryBoard = false
        }
        if appDelegate.isLogin == true{
            let sBaord = UIStoryboard.init(name: "User", bundle: nil)
            let vc = sBaord.instantiateViewController(withIdentifier: "ServiceViewController") as! ServiceViewController
            
            let getID = userDefaults.value(forKey: "slected_Book_LoginObj") as? [String:Any]
            vc.hidesBottomBarWhenPushed = true
            //vc.loadViewIfNeeded()
            vc.salonID = getID!["salonID"] as! String
            self.navigationController?.pushViewController(vc, animated: false)
            
        }else if appDelegate.rateLogin == true{
            let sBaord = UIStoryboard.init(name: "User", bundle: nil)
            let vc = sBaord.instantiateViewController(withIdentifier: "ServiceViewController") as! ServiceViewController
            
            let getID = userDefaults.value(forKey: "rateLogin") as? [String:Any]
            vc.hidesBottomBarWhenPushed = true
            //vc.loadViewIfNeeded()
            vc.salonID = getID!["salonID"] as! String
            self.navigationController?.pushViewController(vc, animated: false)
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if appDelegate.changeStoryBoard == true{
            self.tabBarController?.tabBar.isHidden = true
            
        }else{
            self.tabBarController?.tabBar.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    var collectioNHeight : CGFloat{
        
        SecondCollectionView.layoutIfNeeded()
        return SecondCollectionView.contentSize.height
    }
    
    @IBAction func searchAction(_ sender: UITextField) {
        
        let searchtext = txtFieldSearchBar.text
        
        arrSearchData = arrServices.filter { $0.ser_Name!.lowercased().contains((searchtext?.lowercased())!)}
        isSearch = true
        SecondCollectionView.reloadData()
        //collectionHeight.constant = collectioNHeight
    }
    
    @objc func didChangeText(textField:UITextField) {
        let searchtext = txtFieldSearchBar.text
        
        arrSearchData = arrServices.filter { $0.ser_Name!.lowercased().contains((searchtext?.lowercased())!)}
        isSearch = true
        SecondCollectionView.reloadData()

        //collectionHeight.constant = collectioNHeight
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField == txtFieldSearchBar
        {
            if txtFieldSearchBar.text == ""
            {
                isSearch = false

                SecondCollectionView.reloadData()
                
            }else{

                SecondCollectionView.reloadData()
                
            }
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnNextaction(_ sender: UIButton) {
        if sender.tag == 0{
           self.performSegue(withIdentifier: "nearBySegue", sender: nil)
        }else if sender.tag == 1{
            self.performSegue(withIdentifier: "todayOffersSegue", sender: nil)
            
        }
    }
    
    @IBAction func btnSearchToFIlterAction(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "User", bundle: nil)
        let disVC = storyBoard.instantiateViewController(withIdentifier: "FilterResultViewController") as? FilterResultViewController
        disVC?.isSearch = true
        self.navigationController?.pushViewController(disVC!, animated: false)
    }
    
    @IBAction func btnSelectedaction(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "User", bundle: nil)
        let disVC = storyBoard.instantiateViewController(withIdentifier: "FilterResultViewController") as? FilterResultViewController
        disVC?.catID = arrServices[sender.tag]
        self.navigationController?.pushViewController(disVC!, animated: true)
    }
    
    
    //Get Data From API
    func getCategories(){
        KRProgressHUD.show()
        UserManager.shared.list_of_services(parametrs: [:]) { (responseData, success,message) in
            
            if success == true{
                self.arrServices = responseData
                self.SecondCollectionView.reloadData()
                KRProgressHUD.dismiss()
            }else{
                KRProgressHUD.dismiss({
                     Utility.errorAlert(vc: self, strMessage: "\(message)", errortitle: "")
                })
               
            }
            
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "packagesSegue"{
            let obj = segue.destination as! PackagesVC
            tabBarController?.tabBar.isHidden = false
        }
        else if segue.identifier == "showservices"
        {
            let dis = segue.destination as! FilterResultViewController
            tabBarController?.tabBar.isHidden = false

        }else if segue.identifier == "todayOffersSegue"{
                let obj = segue.destination as! TodayOffersVC
            tabBarController?.tabBar.isHidden = false

        }else if segue.identifier == "nearBySegue"{
            let obj = segue.destination as! NearByVC
            tabBarController?.tabBar.isHidden = false

        }
        
    }

}

extension UserHomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView.tag == 1{
            
            return 2
        }
        else {
            if isSearch == true{
                return arrSearchData.count
            }else{
                return arrServices.count
            }

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            
            let firstCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCollectionCell", for: indexPath) as! FirstCollectionCell
            
            
            firstCollectionViewCell.backView.layer.cornerRadius = 5
            firstCollectionViewCell.image.image = arrayOFFisrtCollection[indexPath.row]
            if indexPath.row == 0{
                firstCollectionViewCell.nameLbl.text! = "Near By"
            }else if indexPath.row == 1{
                firstCollectionViewCell.nameLbl.text! = "Today's Offers"
            }
           
            firstCollectionViewCell.layer.cornerRadius = 5
            firstCollectionViewCell.layer.shadowOpacity = 0.18
            firstCollectionViewCell.layer.shadowOffset = CGSize(width: 0, height: 2)
            firstCollectionViewCell.layer.shadowRadius = 2
            firstCollectionViewCell.layer.shadowColor = UIColor.black.cgColor
            firstCollectionViewCell.layer.masksToBounds = false
            firstCollectionViewCell.layer.cornerRadius = 8
            
            firstCollectionViewCell.btnNext.tag = indexPath.item
            return firstCollectionViewCell
        }
        else {
            
            let secondCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CatagorySelectionCollectionViewCell
            secondCollectionViewCell.catagoryImage.layer.borderWidth = 0.5
            secondCollectionViewCell.catagoryImage.layer.borderColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1).cgColor
            
            secondCollectionViewCell.catagoryImage.clipsToBounds = true
            secondCollectionViewCell.catagoryImage.layoutIfNeeded()
            
            secondCollectionViewCell.btnSected.tag = indexPath.item
            
            if isSearch == true{
                let obj = arrSearchData[indexPath.row]
                
                secondCollectionViewCell.catagoryName.text! = obj.ser_Name!
                secondCollectionViewCell.catagoryImage.sd_setImage(with: URL(string: obj.ser_Img!), completed: nil)

            }else{
                
                let obj = arrServices[indexPath.row]
                print(obj.ser_Name)
                secondCollectionViewCell.catagoryName.text! = obj.ser_Name!
                
                secondCollectionViewCell.catagoryImage.sd_setImage(with: URL(string: obj.ser_Img!), completed: nil)
                SecondCollectionView.layoutIfNeeded()
                
                if catCollectionHeight != nil{
                    self.collectionHeight.constant = catCollectionHeight
                }else{
                    collectionHeight.constant = SecondCollectionView.contentSize.height
                    self.catCollectionHeight  = collectionHeight.constant
                }
                
            }
            
            return secondCollectionViewCell
        }
        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        if collectionView.tag == 1{
            let totalCellWidth = 90 * 2
            print(totalCellWidth)
            let totalSpacingWidth = collectionView.frame.size.width / 3 * (2 - 1)
            
            print(totalSpacingWidth)
            let sum = CGFloat(totalCellWidth) + totalSpacingWidth
            
            let leftInset = (collectionView.frame.size.width - CGFloat(sum))
            let rightInset = leftInset
            
            print(leftInset)
            return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
        }
        
        
        return UIEdgeInsetsMake(0, 0, 0, 0 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 1{
            
            return CGSize(width: 100 , height:  80)
        }else{

            if UIDevice().userInterfaceIdiom == .phone{
                switch UIScreen.main.nativeBounds.height{
                    
                case 1136:
 
                    let width = collectionView.frame.size.width / 4
                    
                    let height = collectionView.frame.size.height / 2
                    
                    return CGSize(width: width, height: height - 30)
                default:
                    
                    
                    let width = collectionView.frame.size.width / 4
                    
                    let height = collectionView.frame.size.height / 2

                    print(SecondCollectionView.frame.size.height)
                    print(width)
                    print(height)
                    return CGSize(width: width, height: width + 20)
                }
            }
            
            return CGSize()
            
        }
        
    }
 
}

