//
//  AddCategoryViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 21/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD

protocol sendCat {
    
    func send(getObj:AddCategory?)
    
}

class AddCategoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var txtFieldAddCategory: UITextField!
    
    @IBOutlet weak var btnAddCategory: UIButton!
    
    @IBOutlet weak var categoryTableview: UITableView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    
    var delegate : sendCat? = nil
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    var getnewCat:AddCategory!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.categoryTableview.layer.borderWidth = 0.5
        self.categoryTableview.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        self.heightConstraint.constant = tableViewHeight
        // Do any additional setup after loading the view.
    }

    @IBAction func btnAddCategoryAction(_ sender: UIButton) {
        
        guard self.txtFieldAddCategory.text! != "" else {
            
            Utility.errorAlert(vc: self, strMessage: "Please enter your category.", errortitle: "")
            return
        }
        
        addCategory()
        //self.appDelegate.service = "\(txtFieldAddCategory.text!)"
        self.appDelegate.price = ""
        self.appDelegate.time = ""
//        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    var tableViewHeight:CGFloat{
        
        self.categoryTableview.layoutIfNeeded()
        return categoryTableview.contentSize.height
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addCategoryCell") as! AddCategoryCell
        
        if oddEven(value: Int(indexPath.row)){
            cell.backView.backgroundColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        }else{
            cell.backView.backgroundColor = UIColor.white
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
    
    func addCategory(){
        
        
        KRProgressHUD.show()
        
        //let params = ["cat_name":"\(txtFieldAddCategory.text!)","provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        let params = ["cat_name":"\(txtFieldAddCategory.text!)","provider_id":"1"]
        
        SignUpProvider.shared.addCategoryAPI(parmas: params) { (success, message, response) in
            
            
            if success == true{
                KRProgressHUD.dismiss({
                    let alert = UIAlertController(title: "Add Category", message: "\(message!)", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        self.getnewCat = response
                        self.delegate?.send(getObj: self.getnewCat)
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                })
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "Add Category")
                })
            }
            
        }
        
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
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
