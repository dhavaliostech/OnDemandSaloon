//
//  ViewController.swift
//  SalonApp
//
//  Created by MANISH CHAUHAN on 7/16/18.
//  Copyright © 2018 MANISH CHAUHAN. All rights reserved.
//

import UIKit

class ConfirmAppointmentViewController: UIViewController {

    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var secondview: UIView!
    
    @IBOutlet weak var successimage: UIImageView!
    
    @IBOutlet weak var lblConfirmed: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblService: UILabel!
    
    @IBOutlet weak var lblSalonName: UILabel!
    
    @IBOutlet weak var lblStrDate: UILabel!
    
    @IBOutlet weak var lblStrName: UILabel!
    
    @IBOutlet weak var lblStrService: UILabel!
    
    @IBOutlet weak var lblStrSalonName: UILabel!
     @IBOutlet weak var bgViewlayout: NSLayoutConstraint!
    // Button
    @IBOutlet weak var btnOkGotit: UIButton!

    var selectedTime :String!
    var selectedDate:String!
    
    var catServices:[[String:Any]] = []
    
    var salonDetails : SalonDetailsBasedOnId!
    
    var selectedCatSer:[CatSerDetails] = []
    
    var amount = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bgView.layer.cornerRadius = 4.5
        bgView.layer.borderWidth = 0.3
        bgView.layer.borderColor = UIColor.lightGray.cgColor
        bgView.clipsToBounds = true

        secondview.layer.shadowOpacity = 0.18
        secondview.layer.shadowOffset = CGSize(width: 3, height: 2)
        secondview.layer.shadowRadius = 2
        secondview.layer.shadowColor = UIColor.black.cgColor
        secondview.layer.masksToBounds = false
        secondview.layer.borderWidth = 0.4
        secondview.layer.borderColor = UIColor.lightGray.cgColor
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                bgViewlayout.constant = 440
                print("iPhone 5 or 5S or 5C")
            case 1334:
                print("iPhone 6/6S/7/8")
                bgViewlayout.constant = 430
                
            case 1920, 2208:
                bgViewlayout.constant = 440
                print("iPhone 6+/6S+/7+/8+")
                
            case 2436:
                print("iPhone X")
                bgViewlayout.constant = 440
                
            default:
                print("unknown")
            }
        }
        
        self.lblStrDate.text! = "\(selectedDate!),\(selectedTime!)"
        self.lblStrSalonName.text! = "\(salonDetails.business_name!)"
        self.lblStrName.text! = "\(userDefaults.value(forKey: "userFirstName")!) \(userDefaults.value(forKey: "userLastName")!)"
        
        var serviceArray:[String] = []
        
        for i in selectedCatSer{
            serviceArray.append(i.ser_cs_name!)
        }
        
        var mainString = ""
        
        for i in serviceArray{
            if mainString == ""{
                mainString = i
            }else{
                mainString = "\(mainString),\(i)"
            }
        }
        
        self.lblStrService.text! = "\(mainString)"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btnOkGotitAction(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "paymentSegue", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "paymentSegue"{
            let obj = segue.destination as! PaymentCompleteVC
            obj.amount = amount
            obj.date = selectedDate!
            obj.time = selectedTime!
            tabBarController?.tabBar.isHidden = true
        }
        
    }
    

}

