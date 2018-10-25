//
//  Prices&ServicesViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 21/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD

class Prices_ServicesViewController: UIViewController,UITextFieldDelegate,sendCat {
  
    

    @IBOutlet weak var priceAndServicesTableView: UITableView!
    
    @IBOutlet var pickerpopUpView: UIView!
    @IBOutlet weak var minPicker: UIPickerView!
    @IBOutlet weak var hourPicker: UIPickerView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var getMainCatObj :[ProviderCat] = []
    var passCatServces:[[String:Any]] = []
    var getCatForService : [SelectedCat] = []
    var arrayOfPrice : [String] = []
    var arrayOfServices : [String] = []
    var arraYOfTime: [String] = []
    
    var arrHours:[String] = ["0h","1h","2h","3h","4h","5h","6h","7h","8h","9h","10h","11h","12h","13h","14h","15h","16h","17h","18h","19h","20h","21h","22h","23h"]
    
    var arrMinutes:[String] = ["0m","5m","10m","15m","20m","25m","30m","35m","40m","45m","50m","55m"]
    var hours = ""
    var minutes = ""
  
    var aarayOFGetServicesData:[ServiceListBasedOnMainCat] = []
    
    var deleteServiceParams:[String:Any] = [:]
    
    var timeindex :Int!
    var priceIndex :Int!
    @IBOutlet var mainView: UIView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCat()
        
        self.priceAndServicesTableView.layer.borderWidth = 0.5
        self.priceAndServicesTableView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        self.heightConstraint.constant = tableViewHeight
        
        self.pickerpopUpView.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    
    var tableViewHeight:CGFloat{
        self.priceAndServicesTableView.layer.layoutIfNeeded()
        return priceAndServicesTableView.contentSize.height
    }
    
    
    func send(getObj: AddCategory?) {
        
        let addNewObj  = getObj!
        
        self.aarayOFGetServicesData.append(ServiceListBasedOnMainCat(dict: ["ser_cat_name":"\(addNewObj.strSer_name)","ser_cat_id":"\(addNewObj.strSer_id!)"]))
        self.priceAndServicesTableView.reloadData()
        self.heightConstraint.constant = self.tableViewHeight
    }
    
    func getCat(){
        
        KRProgressHUD.show()
        
        let params = ["provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        SignUpProvider.shared.getProviderCat(parmas: params) { (success, message,response,selectedCat ) in
            
            if success == true{

                self.getCatForService = selectedCat
                self.getServicesOfCat()
                
            }else{
                
            }
            KRProgressHUD.dismiss()
        }
        
    }
    
    func getServicesOfCat(){
        KRProgressHUD.show()
        
        
        var getData : [[String:Any]] = []
        
        for i in getCatForService{
            let obj = ["category_id":"\(i.mainCatID!)"]
            getData.append(obj)
        }
        
        let params = ["category_list":getData,"provider_id":"\(userDefaults.value(forKey: "pro_id")!)"] as [String : Any]
        
        SignUpProvider.shared.getServicesOfcat(parmas: params) { (success, message, response) in
            
            if success == true{
                print(message!)

                for i in self.getCatForService{
                    
                    for j in response{
                        if i.mainCatID! == j.ser_cat_parent!{
                            
                            self.aarayOFGetServicesData.append(j)
                            
                        }
                    }
                }
                
//                for i in self.aarayOFGetServicesData{
//                    self.arraYOfTime.append("AED\(i.ser_cat_time!)")
//                    self.arrayOfPrice.append("AED\(i.ser_cat_price!)")
//                }
                
                self.priceAndServicesTableView.reloadData()
                self.heightConstraint.constant = self.tableViewHeight
                self.perform(#selector(self.dismissLoader), with: nil, afterDelay: 2)
                
                
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
            }
            
        }
    }
    
    @objc func dismissLoader(){
        KRProgressHUD.dismiss()
    }
    
    func postCatServices(){
        KRProgressHUD.show()
        
        
        for i in aarayOFGetServicesData{
            let data = ["ser_cs_id":"\(i.ser_cat_id!)","ser_cs_name":"\(i.ser_cat_name!)","ser_cs_parent":"\(i.ser_cat_parent!)","ser_cs_price":"\(i.ser_cat_price!)","ser_cs_time":"\(i.ser_cat_time!)"]
            
            self.passCatServces.append(data)
        }
        
        let params = ["category_service_list":passCatServces,"provider_id":"\(userDefaults.value(forKey: "pro_id")!)"] as [String:Any]
        
        SignUpProvider.shared.postCatServiceAPI(parmas: params) { (success, message) in
            
            if success == true{
                self.performSegue(withIdentifier: "goToSubscription", sender: nil)
            }else{
                
            }
            KRProgressHUD.dismiss()
        }
        
    }
    
    
   
   
    @IBAction func btnOkAction(_ sender: UIButton) {

        if hours == "" && minutes != ""{
            aarayOFGetServicesData[timeindex].ser_cat_time! = "\(minutes)"
        }else if hours != "" && minutes == "" {
            aarayOFGetServicesData[timeindex].ser_cat_time! = "\(hours)"
        }else{
            aarayOFGetServicesData[timeindex].ser_cat_time! = "\(hours) : \(minutes)"
        }
        print(aarayOFGetServicesData[timeindex].ser_cat_time!)
        self.mainView.removeFromSuperview()
        
        self.priceAndServicesTableView.reloadData()
    }
    
    
    
    @IBAction func saveCatServicesAction(_ sender: UIButton) {
       
        
        postCatServices()
    }
    
    @IBAction func addServicesAction(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "addCatServices", sender: nil)
        
    }
    @IBAction func addCategoryAction(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "addCatSegue", sender: nil)
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)

    }
    
    @IBAction func btdDeleteAction(_ sender: UIButton) {
        
        //
        deleteServiceParams = ["provider_id":"\(userDefaults.value(forKey: "pro_id")!)","service_id":"\(self.aarayOFGetServicesData[sender.tag].ser_cat_id!)"]
        self.deletService(param:deleteServiceParams)
        self.aarayOFGetServicesData.remove(at: sender.tag)
//        self.arrayOfPrice.remove(at: sender.tag)
//        self.arraYOfTime.remove(at: sender.tag)
//        self.arrayOfServices.remove(at: sender.tag)
        self.priceAndServicesTableView.reloadData()
        self.heightConstraint.constant = tableViewHeight
        
    }
    
    
    func deletService(param:[String:Any]){

        KRProgressHUD.show()
        
        SignUpProvider.shared.deletCatServices(parmas: param) { (success, message) in
            
            if success == true{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: "\(message!)", alerttitle: "")
                })
            }else{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: "\(message!)", alerttitle: "")
                })
            }
            
        }
        
    }
    
    @IBAction func btnTimeAction(_ sender: UIButton) {
        timeindex = sender.tag
        self.mainView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        
        view.addSubview(self.mainView)
        
    }
 
    @IBAction func priceTxtFieldAction(_ sender: UITextField) {
        priceIndex = sender.tag
        
        let getPrice = sender.text!
        
       // getPrice.ch
        
       // aarayOFGetServicesData[priceIndex].ser_cat_price!  = sender.text!
        self.heightConstraint.constant = tableViewHeight
        self.priceAndServicesTableView.reloadData()
        print(aarayOFGetServicesData[priceIndex].ser_cat_price!)
    }
    
    @IBAction func btnPriceAction(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Price", message: "", preferredStyle: .alert)
        alert.addOneTextField(configuration: { (textField) in
            textField.becomeFirstResponder()
            textField.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
            textField.placeholder = "Please Enter Your Price."
            textField.left(image: #imageLiteral(resourceName: "edit"), color: .black)
            textField.leftViewPadding = 12
            textField.borderWidth = 1
            textField.cornerRadius = 8
            textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
            textField.backgroundColor = nil
            //textField.keyboardAppearance = .default
            textField.keyboardType = .decimalPad
            textField.delegate = self
            textField.returnKeyType = .done
            textField.action { textField in
                // validation and so on
                print(textField.text!)
                self.aarayOFGetServicesData[sender.tag].ser_cat_price!  = "\(textField.text!)"
                self.heightConstraint.constant = self.tableViewHeight
                self.priceAndServicesTableView.reloadData()
                print(self.aarayOFGetServicesData[sender.tag].ser_cat_price!)
            }
            
        })
        alert.addAction(title: "OK", style: .cancel)
        alert.show()
 
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
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
        
        if segue.identifier == "goToSubscription"{
            let segueOBJ = segue.destination as! SubscriptionViewController
            
        }else if segue.identifier == "addCatSegue"{
            
            let obj = segue.destination as! AddCategoryViewController
            obj.delegate = self
        }else if segue.identifier == "addCatServices"{
            let obj = segue.destination  as! AddServiceViewController
        }
        
    }
 

}

extension Prices_ServicesViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aarayOFGetServicesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
            let cell = tableView.dequeueReusableCell(withIdentifier: "price&ServicesCell") as! PriceAndServicesTableViewCell
        cell.selectionStyle = .none
        let objOfServices = aarayOFGetServicesData[indexPath.row]
        cell.lblServices.text = objOfServices.ser_cat_name!
        cell.lblTime.text = objOfServices.ser_cat_time!
        cell.lblPrice.text = "AED\(objOfServices.ser_cat_price!)"
        cell.btnTime.tag = indexPath.row
        //cell.txtFieldPrice.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        cell.btnPrice.tag = indexPath.row
        
        if oddEven(value: Int(indexPath.row)){
            cell.backView.backgroundColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
            print("True")
        }else{
            cell.backView.backgroundColor = UIColor.white
            print("False")

        }
        
        tableView.tableFooterView = UIView()
        return cell
   
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell")
        cell?.selectionStyle = .none
        tableView.tableFooterView = UIView()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension Prices_ServicesViewController : UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if hourPicker == pickerView{
            return  arrHours.count
            
        }else{
            return arrMinutes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if hourPicker == pickerView{
            return arrHours[row]
            
        }else{
            return arrMinutes[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        if hourPicker == pickerView{
            if arrHours[row] != ""{
                hours = arrHours[row]
            }
        }
        else{
            if arrMinutes[row] != ""{
                
                minutes = arrMinutes[row]
            }
        }
        
        
        
        self.view.endEditing(true)
    }
}
