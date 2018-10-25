//
//  ClientAppointmentTimeViewController.swift
//  dummySalon
//
//  Created by Macbook Pro on 22/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KRProgressHUD


class ClientAppointmentTimeViewController: UIViewController{
    
    
    @IBOutlet weak var firstQueView: UIView!

    @IBOutlet weak var secondQueView: UIView!
    
    @IBOutlet weak var btnuser: UIButton!
    
    @IBOutlet weak var lblFirstAns: UILabel!
    
    @IBOutlet weak var lblSecondAns: UILabel!
    
    @IBOutlet weak var lblFirstQue: UILabel!
    
    @IBOutlet weak var lblSecondQue: UILabel!
    
    
    
     @IBOutlet weak var tableviewdata: UITableView!
    
    var arrayOfque:[AccountSettings] = []
    var selctedQuestionIDArray:[String] = []
    var slectedAnswersObjs:[QuestionAns] = []
    
    var selectedAnswerId = ""
    let window = UIApplication.shared.keyWindow
    var tabbarController = ManageLoginTabBarController()

    var indexselect :Int!
    
    var selectedAnswers: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        self.btnuser.layer.borderColor = UIColor.white.cgColor
        self.btnuser.layer.borderWidth = 1
        self.btnuser.layer.cornerRadius = self.btnuser.frame.size.height / 2
        getQuestionAndAns()
    }

    @IBAction func btnFirstAction(_ sender: UIButton) {
        var answerObj:AccountSettings!
        var selectedObj:QuestionAns!
        var listOfSelectedAnswers:[String] = []
        //QuestionAns
        //AccountSettings
        
        answerObj = arrayOfque[sender.tag]
        
    
        for i in answerObj.answer_list{
            
            if i.answer_que_id! == answerObj.que_id!{
                
                listOfSelectedAnswers.append(i.answer_name!)
                
            }
            
        }

        let alert = UIAlertController(style: .actionSheet, title: "", message: "Category of Services")
        let pickerViewValues: [String] = listOfSelectedAnswers
        // let frameSizes: [CGFloat] = (150...400).map { CGFloat($0) }
        let index = listOfSelectedAnswers.first
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: listOfSelectedAnswers.index(of: index!) ?? 0)
        
        alert.addPickerView(values: [pickerViewValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            self.indexselect = sender.tag
            self.selectedAnswerId = answerObj.answer_list[index.row].ans_id!
            selectedObj = answerObj.answer_list[index.row]
            var questionValue = 0
            var answerValue = 0

            if self.slectedAnswersObjs.count == 0 {
                self.slectedAnswersObjs.append(answerObj.answer_list[index.row])
                self.selctedQuestionIDArray.append(answerObj.que_id!)
                print(self.slectedAnswersObjs.count)
                print(self.selctedQuestionIDArray.count)
            }else{
                
               for k in self.selctedQuestionIDArray{
                
                    if selectedObj.answer_que_id! == k{
                    
                        for j in self.slectedAnswersObjs{
                            if selectedObj.ans_id! != j.ans_id!{
                                self.slectedAnswersObjs.remove(at: answerValue)
                                //self.selctedQuestionIDArray.remove(at: questionValue)
                                self.slectedAnswersObjs.append(answerObj.answer_list[index.row])
                                print("same")
                                print(self.slectedAnswersObjs.count)
                                print(self.selctedQuestionIDArray.count)
                                break
                            }else{
                                
                                
                            }
                        }
                    }
                }
            }
            self.tableviewdata.reloadData()
   
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
    }
   

    func getQuestionAndAns(){
        
        KRProgressHUD.show()
        
        SignUpProvider.shared.accountsSettings(parmas: [:]) { (success, message, response) in
            if success == true{
                self.arrayOfque = response

                self.tableviewdata.reloadData()
           
                KRProgressHUD.dismiss()
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
            }
            KRProgressHUD.dismiss()
        }
    }
    
    
    func accountsetingPost(){
        
        KRProgressHUD.show()
        
        var mainArr :[[String:Any]] = []
        for i in self.slectedAnswersObjs{
            
            for j in self.selctedQuestionIDArray{
                
                if i.answer_que_id! == j{
                    let obj = ["question_id":"\(i.answer_que_id!)","answer_id":"\(i.ans_id!)"]
                    mainArr.append(obj)
                    
                }
            }
            
        }
        
        let paramter = ["quetion_answer_list":mainArr,"provider_id":"\(userDefaults.value(forKey: "pro_id")!)"] as [String : Any]
        
        SignUpProvider.shared.accountsSettingsPostApi(parmas: paramter) { (success, error) in
            
            if success == true{
                KRProgressHUD.dismiss()
                print("Success")
                
            }
            else {
                print(error?.localizedCapitalized)
            }
            KRProgressHUD.dismiss()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        if appDelegate.changeStoryBoard == true{
            self.tabBarController?.tabBar.isHidden = true
            
        }else{
            self.tabBarController?.tabBar.isHidden = false
            
        }
    }
    
    
    @objc func btnUserAction(_ sender:UIButton){
        
        if let userLoginFlag = userDefaults.value(forKey: "user_id") as? String{
            
            loadHomePage()
            
        }else{
            let sBoard = UIStoryboard.init(name: "User", bundle: nil)
            let vc = sBoard.instantiateViewController(withIdentifier: "UserTabBar") as! UserTabBarController
            //        vc.hidesBottomBarWhenPushed = false
            vc.hidesBottomBarWhenPushed = true
            userDefaults.set("user", forKey: "lastLogin")
            appDelegate.changeStoryBoard = true
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
    }
    func loadHomePage() {
        
        Utility.modifiedTabBar(tabBarController: tabbarController)
        appDelegate.changeStoryBoard = true
        tabbarController.loadViewIfNeeded()
        userDefaults.set("none", forKey: "lastLogin")
        //self.window?.rootViewController = self.tabbarController
        if self.window?.rootViewController == self.tabbarController{
            self.didMove(toParentViewController: appDelegate.window?.rootViewController)
        }else{
            self.navigationController?.pushViewController(tabbarController, animated: false)
        }
    }

    @IBAction func btnSaveAction(_ sender: UIButton) {
        accountsetingPost()
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

extension ClientAppointmentTimeViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayOfque.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AccountViewCell
        
        cell.btnAction.tag = indexPath.row
        cell.lblFirstQuestion.tag = indexPath.row

        
        let obj = arrayOfque[indexPath.row]
        
        cell.lblTitle.text! = obj.que_name!
        cell.lblFirstQuestion.text! = obj.answer_list[0].answer_name!
        
       
        
        if indexselect != nil{
            
            if indexselect == indexPath.row{
                
                for i in obj.answer_list{
                    if i.ans_id! == selectedAnswerId{
                        cell.lblFirstQuestion.text = i.answer_name!
                    }
                }
                
            }
            
        }

        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 83
    }

}
