//
//  CompanyInfoVC.swift
//  demo1
//
//  Created by PS on 02/08/18.
//  Copyright © 2018 PS. All rights reserved.
//

import UIKit

class CompanyInfoVC: UIViewController {

    @IBOutlet weak var PhotoCollectionView: UICollectionView!
    @IBOutlet weak var phoneNobackVIew: UIView!
    @IBOutlet weak var nameBackVIew: UIView!
    @IBOutlet weak var addressBackView: UIView!
    @IBOutlet weak var workingHoursBackView: UIView!
    @IBOutlet weak var emailBackView: UIView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblWorkingHours: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PhotoCollectionView.clipsToBounds = true
        emailBackView.layer.borderWidth = 1
        emailBackView.layer.cornerRadius = 4
        emailBackView.clipsToBounds = true
        emailBackView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0,alpha: 1.0).cgColor
        
        phoneNobackVIew.layer.borderWidth = 1
        phoneNobackVIew.layer.cornerRadius = 4
        phoneNobackVIew.clipsToBounds = true
        phoneNobackVIew.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0,alpha: 1.0).cgColor
        
        addressBackView.layer.borderWidth = 1
        addressBackView.layer.cornerRadius = 4
        addressBackView.clipsToBounds = true
        addressBackView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0,alpha: 1.0).cgColor
        
        workingHoursBackView.layer.borderWidth = 1
        workingHoursBackView.layer.cornerRadius = 4
        workingHoursBackView.clipsToBounds = true
        workingHoursBackView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0,alpha: 1.0).cgColor
        
        nameBackVIew.layer.borderWidth = 1
        nameBackVIew.layer.cornerRadius = 4
        nameBackVIew.clipsToBounds = true
        nameBackVIew.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0,alpha: 1.0).cgColor
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK:- Button Action
    
    @IBAction func btnBackaction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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

extension CompanyInfoVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        photoCell.Photo.image = #imageLiteral(resourceName: "background2")
        return photoCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let Width = self.PhotoCollectionView.frame.size.width/4 - 10
        let height = Width
        let size = CGSize(width: Width, height: height)
        return size
    }
    
    
}
