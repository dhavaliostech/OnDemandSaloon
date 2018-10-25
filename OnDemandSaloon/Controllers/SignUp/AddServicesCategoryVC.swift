
//
//  AddServicesCategoryVC.swift
//  SalonApp
//
//  Created by MANISH CHAUHAN on 7/20/18.
//  Copyright © 2018 MANISH CHAUHAN. All rights reserved.
//

import UIKit
import KRProgressHUD

protocol SendCatToEmployee {
    
    func SendToEmployee(mainCat:[ProviderCat]?)
    
}

protocol SendCatToProviderAccount {
    func sendToProvider(mainCat:[ProviderCat]?)
}

class AddServicesCategoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
   

    @IBOutlet weak var btnContinue: UIButton!
    
    @IBOutlet weak var tableviewdata: UITableView!
    
    
    var selectCatFromEmpoyee = false
    
    var arrayServicesCategory:[String] = ["Hairs","Nose","Legs","Spa","Bridal","Massage","Threading","Pedicure","Medicure"]
    
    var getProviderCat : [ProviderCat] = []
    var getSelectedOBj :[ProviderCat] = []
    var passStringArray:[[String:Any]] = []
    
    var fromEmployeeCat:[ProviderCat] = []
    var fromProviderCat:[ProviderCat] = []
    
    var flagArray:[Int] = []
    var arrCheck:Bool = false
    
    var employeeGetCat = false
    var providerGetCat = false

    var delegateForEmployee:SendCatToEmployee? = nil
    var delegateForProvider:SendCatToProviderAccount? = nil
    
    var serviceTypeProvider = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getCat()
        
        if let getServiceTyper = userDefaults.value(forKey: "serviceType") as? String{
            
            serviceTypeProvider = getServiceTyper
            
        }
        
        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    
    }
    
    func getCat(){
        
        KRProgressHUD.show()
        
        let params = ["provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        SignUpProvider.shared.getProviderCat(parmas: params) { (success, message,response ,selectedCat) in
            
            if success == true{
                
                self.getProviderCat = response
                
                var selectedArray : [SelectedCat] = []
                
                selectedArray = selectedCat
                
                print(selectedArray.count)
                
                for i in self.getProviderCat{
                    
                    for j in selectedArray{
                        
                        if i.mainCatID! == j.mainCatID!{
                            self.flagArray.append(1)
                        }else{
                            self.flagArray.append(0)
                        }
                        
                    }
    
                }
                var value1 = 0
                
                if self.employeeGetCat == true{
           
                    for i in self.fromEmployeeCat{
                        
                        for j in self.getProviderCat{

                            if i.mainCatID == j.mainCatID{
                                self.flagArray[value1] = 1
                                value1 = 0
                                self.getSelectedOBj.append(j)
                                break
                            }
                            value1 = value1 + 1
                        }
                        
                    }
                }
                
                self.tableviewdata.reloadData()
            }else{
                
            }
            KRProgressHUD.dismiss()
        }
        
    }
    
    func postCategory(){
        
        KRProgressHUD.show()
        
        for i in getSelectedOBj{
            let obj = ["category_id":"\(i.mainCatID!)"]
            self.passStringArray.append(obj)
        }
        
        //let params =  ["category_list":self.passStringArray,"provider_id":"\(userDefaults.value(forKey: "pro_id")!)"] as [String:Any]
        var params : [String:Any] = [:]
        if serviceTypeProvider == "1"{
            params = ["category_list":self.passStringArray,"provider_id":"\(userDefaults.value(forKey: "pro_id")!)","reg_service_type":"1"] as [String : Any]
        }else{
            params = ["category_list":self.passStringArray,"provider_id":"\(userDefaults.value(forKey: "pro_id")!)","reg_service_type":"2"] as [String : Any]
        }
        
        SignUpProvider.shared.postCategories(parmas: params) { (success, message) in
            
            if success == true{
                self.performSegue(withIdentifier: "gotoServicesSegue", sender: nil)
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
            }
            KRProgressHUD.dismiss()
        }
   
    }
    
    @IBAction func btnContinueAction(_ sender: UIButton) {
        
        guard self.getSelectedOBj.count != 0 else {
            
            Utility.errorAlert(vc: self, strMessage: "Please select category", errortitle: "")
            return
        }
        
        if employeeGetCat == true{
            delegateForEmployee?.SendToEmployee(mainCat: getSelectedOBj)
        }else if providerGetCat == true{
            delegateForProvider?.sendToProvider(mainCat: getSelectedOBj)
        }
        
        
        guard employeeGetCat == false  else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        
        guard providerGetCat == false  else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        postCategory()
        //self.performSegue(withIdentifier: "gotoServicesSegue", sender: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getProviderCat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddServiceCategoryCell
        cell.lblCategory.text!  = getProviderCat[indexPath.row].mainCat!
        //cell.btnCheck.setImage(#imageLiteral(resourceName: "22_03"), for: .normal)
        cell.btnCheck.tag = indexPath.row
        
        //let flagObj = flagArray[indexPath.row]
        let obj = getProviderCat[indexPath.row]
        if flagArray[indexPath.row] == 1{
             cell.btnCheck.setImage(#imageLiteral(resourceName: "blueCheck"), for: .normal)
            self.getSelectedOBj.append(obj)
        }else{
            cell.btnCheck.setImage(#imageLiteral(resourceName: "blankCheck"), for: .normal)
        }
        
       
        cell.selectionStyle = .none
        return cell
    }
    
    @IBAction func btnCheckmarkAction(_ sender: UIButton) {
        
        
        var value = 0
        let obj = getProviderCat[sender.tag]
        if sender.imageView?.image == #imageLiteral(resourceName: "blueCheck"){
            
            for i in getSelectedOBj{
                if obj.mainCatID! == i.mainCatID!{
                    
                    getSelectedOBj.remove(at: value)
                    self.flagArray[sender.tag] = 0
                    break
                }
                value += 1
            }
        }else{
            
            if serviceTypeProvider == "1"{
                guard self.getSelectedOBj.count != 2  else {
                    //                    Utility.errorAlert(vc: self, strMessage: "Freelancer can not select category more than two.", errortitle: "")
                    return
                }
            }
            self.flagArray[sender.tag] = 1
            self.getSelectedOBj.append(obj)
            
        }
        
        tableviewdata.reloadData()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "gotoServicesSegue"{
            let obj = segue.destination as! Prices_ServicesViewController
            obj.getMainCatObj = getSelectedOBj
        }
        
    }
    

}
