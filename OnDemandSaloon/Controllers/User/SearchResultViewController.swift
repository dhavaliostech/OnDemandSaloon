//
//  SearchResultViewController.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 28/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import FloatRatingView
import SDWebImage

class SearchResultViewController: UIViewController {

    @IBOutlet weak var searchResultCollectionView: UICollectionView!
    
    @IBOutlet weak var btnProvider: UIButton!
    var searchResultArray:[SalonObj] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnProvider.layer.cornerRadius = self.btnProvider.frame.size.height / 2
        self.btnProvider.layer.borderColor = UIColor.white.cgColor
        self.btnProvider.layer.borderWidth = 1
        Utility.chnageBtnTitle(btn: self.btnProvider)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if appDelegate.changeStoryBoard == true{
            appDelegate.changeStoryBoard = false
        }
        tabBarController?.tabBar.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if appDelegate.changeStoryBoard == true{
            self.tabBarController?.tabBar.isHidden = true
        }else{
            self.tabBarController?.tabBar.isHidden = false
        }
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSellServiceAction(_ sender: UIButton) {
        if let getLogin = userDefaults.value(forKey: "pro_id") as? String{
            
            gotoPrvider()
            
        }else{
            createPopUp()
        }
    }
    
    @objc func createPopUp(){
        Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "SearchResultViewController", isLogin: false, isService: true )
    }
    @objc func gotoPrvider(){
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchResultViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FloatRatingViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchResult", for: indexPath) as! SearchResultForCollectionViewCell
        
        let obj = searchResultArray[indexPath.item]
        
        cell.ratingView.delegate = self
        //secondCell.ratingView.editable = true
        cell.ratingView.type = .floatRatings
        
        
        cell.backView.layer.cornerRadius = 5
        //secondCell.backView.layer.borderWidth = 1
        cell.backView.layer.borderColor = UIColor.lightGray.cgColor
        
        cell.layer.cornerRadius = 5
        cell.layer.shadowOpacity = 0.18
        cell.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.layer.shadowRadius = 2
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.masksToBounds = false
        cell.layer.cornerRadius = 8
        
        cell.lblLocation.text! = obj.user_location!
        cell.lblReviews.text! = "\(obj.total_review!) reviews"
        cell.lblHappyCustomer.text! = "\(obj.happy_performance!)% Happy Customers."
        cell.lblSalonName.text! = obj.business_name!
        let rate = Int(Double(obj.rat_out_of_5!)!)
        cell.ratingView.rating = Double(rate)
        cell.salonImage.sd_setImage(with: URL(string: obj.banner_name!), completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! SearchResultForCollectionViewCell
        
        let obj = searchResultArray[indexPath.item]
        
        if obj.id! != ""{
            let sBoard = UIStoryboard.init(name: "User", bundle: nil)
            let vc = sBoard.instantiateViewController(withIdentifier: "ServiceViewController") as! ServiceViewController
            vc.salonID = obj.id!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width , height: 156)
    }
    
    
}
