//
//  AddServiceViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 21/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//



import UIKit
import KRProgressHUD
class AddServiceViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    

    @IBOutlet weak var selectCategoryView: UIView!
    @IBOutlet weak var txtFieldService: UITextField!
    
    @IBOutlet weak var addedServiceTableView: UITableView!
    
    @IBOutlet weak var lblAddCategory: UILabel!
    @IBOutlet weak var addCategoryname: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var arrayOfServices : [String] = []
    
    var getMAinCat : [ListOfMainCategories] = []
    
    var selectObj :AddData!
    var selectedCat :ListOfMainCategories!
    var createdData : [String] = [""]
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedCat = nil
        
        getMainCat()
        self.selectCategoryView.layer.borderWidth = 1
        self.selectCategoryView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        
        self.txtFieldService.attributedPlaceholder = NSAttributedString(string: "What is a name of the service?", attributes: [NSAttributedStringKey.foregroundColor : UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)])
        
        self.addedServiceTableView.layer.borderWidth = 0.5
        self.addedServiceTableView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        self.heightConstraint.constant = tableViewHeight

        
            self.addedServiceTableView.isHidden = true
    
        
        // Do any additional setup after loading the view.
    }
    var tableViewHeight:CGFloat{
        
        self.addedServiceTableView.layoutIfNeeded()
        return addedServiceTableView.contentSize.height
    }

    
    func getMainCat(){
        
        KRProgressHUD.show()
        
        //let params = ["provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        let params = ["provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        SignUpProvider.shared.getListOfMainCatAPI(parmas: params) { (success, message, response) in
            
            if success == true{
                self.getMAinCat = response
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
            }
            KRProgressHUD.dismiss()
        }
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func addServicesCategoryAction(_ sender: UIButton) {
        
        for i in getMAinCat{
            self.arrayOfServices.append(i.ser_Name!)
        }
        guard getMAinCat.count != 0 else {
            return
        }
        self.createdData[0] = arrayOfServices[0]
        let alert = UIAlertController(style: .actionSheet, title: "", message: "")
        let index = arrayOfServices.first
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: arrayOfServices.index(of: index!) ?? 0)
        alert.addPickerView(values: [arrayOfServices], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            //            self.lblCity.text = self.city[index.row]
            //self.appDelegate.service = "\()"
            print(self.arrayOfServices[index.row])
            self.appDelegate.service = self.arrayOfServices[index.row]
            self.lblAddCategory.text = self.arrayOfServices[index.row]
            self.selectedCat = self.getMAinCat[index.row]
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
        
    }
    
    @IBAction func addDuretionAndPriceAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Add Duration and Time", message: "", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (txtField) in
            txtField.placeholder = "Enter Duration"
            txtField.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
            
        }
        alert.addTextField { (priceField) in
            priceField.placeholder = "Enter Price"
            priceField.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
            priceField.keyboardType = .decimalPad
        }
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.default, handler: { (action) in
            let firstText = alert.textFields![0] as UITextField
            let secondText = alert.textFields![1] as UITextField
            self.appDelegate.time = firstText.text!
            self.appDelegate.price = "AED \(secondText.text!))"
            self.addedServiceTableView.reloadData()
            self.addedServiceTableView.isHidden = false
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
    
            self.selectObj = AddData(price: self.appDelegate.price, duration: self.appDelegate.time, service: self.txtFieldService.text!)
            
            addService()
        
    }

    @IBAction func saveAndAddAnotherAction(_ sender: UIButton) {
         addService()
         self.addedServiceTableView.isHidden = true
         self.txtFieldService.text = ""
        self.lblAddCategory.text = "Service Category"
    }
    
    
    func addService(){
    
        guard self.txtFieldService.text != "" else {
            Utility.errorAlert(vc: self, strMessage: "Please enter service.", errortitle: "")
            return
        }
        
        guard self.selectObj.duration! != "" else {
            Utility.errorAlert(vc: self, strMessage: "Please enter duration of the service.", errortitle: "")
            return
        }
        guard self.selectObj.price! != "" else {
            Utility.errorAlert(vc: self, strMessage: "Please enter duration of the price.", errortitle: "")
            return
        }
        
        KRProgressHUD.show()
        
        let params = ["service_name":"\(selectObj.serviceName!)","service_cat_id":"\(self.selectedCat.ser_ID!)","service_price":"\(selectObj.price!)","service_duration":"\(selectObj.duration!)","provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        SignUpProvider.shared.addServiceOfCat(parmas: params) { (success, message) in
            
            if success == true{
                KRProgressHUD.dismiss({
                    let alert = UIAlertController(title: "", message: "\(message!)", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                })
                
                self.navigationController?.popViewController(animated: true)
            }else{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: "\(message!)", alerttitle: "")
                })
            }
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addServiceCell") as! AddServiceTableViewCell
        if oddEven(value: Int(indexPath.row)){
            cell.backView.backgroundColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        }else{
            cell.backView.backgroundColor = UIColor.white
        }
        
        if appDelegate.service != ""{
            cell.lblDuration.text = appDelegate.time
            cell.lblPrice.text = appDelegate.price
            cell.lblPriceType.text = "Fixed"
        }
        
        cell.selectionStyle = .none
        tableView.tableFooterView = UIView()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell")
        cell?.selectionStyle = .none
        tableView.tableFooterView = UIView()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func oddEven(value:Int) -> Bool{
        
        var status = false
        
        if value % 2 == 0{
            
            status = true
            return status
        }else {
            status = false
            return status
        }
        
        
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

class AddData:NSObject{
    
    var serviceName:String!
    var price:String!
    var duration:String!
    
    init(price:String,duration:String?,service:String?) {
        serviceName = service
        self.price = price
        self.duration = duration
    }
    
}
