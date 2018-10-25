//
//  Work_day VC.swift
//  SalonApp
//
//  Created by Pratik Zankat on 20/07/18.
//  Copyright © 2018 MANISH CHAUHAN. All rights reserved.
//

import UIKit
import KRProgressHUD

protocol SendHourToEmployee {
    
    func SendToEmployeeHours(hoursAndDay:[WorkingDayHours]?)
    
}

protocol SendHourToProviderAccount {
    func sendToProviderHours(hoursAndDay:[WorkingDayHours]?)
}

class Work_day_VC: UIViewController,UITableViewDelegate,UITableViewDataSource {
 
    
    @IBOutlet weak var txtFieldNoteForClient: UITextField!
    var arrayDay:[String] = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
    var arrayStartTime:[String] = ["10:30 AM","10:30 AM","10:30 AM","10:30 AM","10:30 AM","10:30 AM","10:30 AM"]
    var arrauEndTime : [String] = ["7:00 PM","7:00 PM","7:00 PM","7:00 PM","7:00 PM","7:00 PM","7:00 PM"]

    @IBOutlet weak var tableviewdata: UITableView!
    
    var selectedHours:[WorkingDayHours] = []

    var fromProvider:[WorkingDayHours] = []
    var fromEmployee:[WorkingDayHours] = []
    
    var myHours:[MyOpeningHours] = []
    
    @IBOutlet weak var btnSave: UIButton!
    var arrCheck:Bool = false
    var dateAdd:[String] = []
    
    var flagArray:[Int] = []
    
    var first = false
    let timePicker = UIDatePicker()
    var isTouchIndex :Int!
    
    var haveMyHours = false
    
    var employeeGetHour = false
    var providerGetHour = false
    var delegateForEmployee:SendHourToEmployee? = nil
    var delegateForProvider:SendHourToProviderAccount? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in self.arrayDay{
            self.flagArray.append(0)
        }
//        if employeeGetHour == true{
//            var value = 0
//            for i in fromEmployee{
//
//                for j in arrayDay{
//
//                    if i.day == j{
//                        self.arrayStartTime[value] = i.startTime!
//                        self.arrauEndTime[value] = i.endTime!
//
//                        self.selectedHours.append(WorkingDayHours(w_day: i.day!, sTime: i.startTime!, eTime: i.endTime!))
//
//                        self.flagArray[value] = 1
//                        value = 0
//                        break
//                    }
//                    value += 1
//
//                }
//            }
//        }
        getMyHours()
        txtFieldNoteForClient.attributedPlaceholder = NSAttributedString(string: "Notes For Client", attributes: [NSAttributedStringKey.foregroundColor:txtBlueColor])
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
        //appDelegate.changeStoryBoard = true
        
    }
    
    func getMyHours(){
        KRProgressHUD.show()
        
        let params = ["provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        SignUpProvider.shared.myOpeningHours(parmas: params) { (success, message, response) in
            
            if success == true{
                self.myHours = response
                
                if self.myHours.count != 0{
                    self.flagArray.removeAll()
                    for i in self.myHours{
                        self.selectedHours.append(WorkingDayHours(w_day: i.oh_day!, sTime: i.oh_from_time!, eTime: i.oh_to_time!))
                    }
                    for k in self.selectedHours{
                    
                        
                        for j in self.arrayDay{
                            
                            if j == k.day!{
                                self.flagArray.append(1)
                            }else{
                                self.flagArray.append(0)
                            }
                            
                        }
                        
                    }
                    self.haveMyHours = true
                }else{
                    self.flagArray.removeAll()

                    for _ in self.arrayDay{
                        self.flagArray.append(0)
                    }
                    
                }
                
            }else{
                
            }
            self.tableviewdata.reloadData()
            KRProgressHUD.dismiss()
        }
    }
    
    @IBAction func btnBackAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func postWrokingHours(){
        KRProgressHUD.show()
        
        var arrayData:[[String:String]] = []
        for i in selectedHours{
            
            let data = ["oh_day":"\(i.day!)","oh_start_time":"\(i.startTime!)","oh_end_time":"\(i.endTime!)"]
            
            arrayData.append(data)
        }
        
        let params = ["hour_list":arrayData,"provider_id":"\(userDefaults.value(forKey: "pro_id")!)","notes":"\(txtFieldNoteForClient.text!)"] as [String : Any]
        
        SignUpProvider.shared.workingHoursPost(parmas: params) { (success, message) in
            
            if success == true{
                
                self.performSegue(withIdentifier: "selectCatSegue", sender: nil)
                //self.performSegue(withIdentifier: "selectCatSegue", sender: nil)
                KRProgressHUD.dismiss()
            }else{
                KRProgressHUD.dismiss({
                     Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
               
            }
            
        }
        
    }
    @IBAction func btnSaveAction(_ sender: UIButton) {
        
        if employeeGetHour == true{
           
            delegateForEmployee?.SendToEmployeeHours(hoursAndDay: selectedHours)
        }else if providerGetHour == true{
            
            delegateForProvider?.sendToProviderHours(hoursAndDay: selectedHours)
        }
        
        
        guard employeeGetHour == false  else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        
        guard providerGetHour == false  else {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        
        postWrokingHours()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Work_dayCell
        cell.lblDay.text! = arrayDay[indexPath.row]
        //cell.lblEndTime.text! = arrayTime[indexPath.row]
        
        cell.bgview.layer.borderWidth = 1
        cell.bgview.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        
//        cell.btnChekmark.layer.borderWidth = 2
//        cell.btnChekmark.layer.borderColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1).cgColor

        cell.btnChekmark.tag = indexPath.row
        cell.selectionStyle = .none
        
        cell.btnStartTime.tag = indexPath.row
        cell.btnEndTime.tag = indexPath.row
        
        let sTime = arrayStartTime[indexPath.row]
        let eTime = arrauEndTime[indexPath.row]
        let day = arrayDay[indexPath.row]
//        if cell.btnChekmark.isSelected == true{
//            cell.btnChekmark.setImage(#imageLiteral(resourceName: "blueCheck"), for: .normal)
//            arrCheck = true
//        }
//        else {
//            cell.btnChekmark.setImage(#imageLiteral(resourceName: "22_03"), for: .normal)
//            arrCheck = false
//        }
        
        cell.lblStartTime.text! = "\(arrayStartTime[indexPath.row])"
        cell.lblEndTime.text! = "\(arrauEndTime[indexPath.row])"
            let obj = flagArray[indexPath.row]
        
            if obj == 1{
                cell.btnChekmark.setImage(#imageLiteral(resourceName: "blueCheck"), for: .normal)
                //self.selectedHours.append(WorkingDayHours(w_day: day, sTime: sTime, eTime: eTime))
                var tempFlag = false
                if haveMyHours == true{
                    
                    for i in self.myHours{
                        
                        for j in self.arrayDay{
                            if i.oh_day! == j{
                                cell.lblStartTime.text! = "\(i.oh_from_time!)"
                                cell.lblEndTime.text! = "\(i.oh_to_time!)"
                                
                                break
                            }
                        }
//                        if tempFlag == true{
//                            break
//                        }
                        
                    }
                    
                    
                }
                
            
            }else{
                //self.selectedHours.append(WorkingDayHours(w_day: day, sTime: sTime, eTime: eTime))
                cell.btnChekmark.setImage(#imageLiteral(resourceName: "blankCheck"), for: .normal)
                
                if self.employeeGetHour == true{
                }
            }

       
        
        

            print(self.selectedHours.count)
//        guard self.employeeGetHour != true else {
//            return cell
//        }
//
//        guard self.providerGetHour != true else {
//            return cell
//        }
//            guard first != true else{
//                return cell
//            }
//            cell.btnChekmark.setImage(#imageLiteral(resourceName: "blueCheck"), for: .normal)
//            self.flagArray[indexPath.row] = 1
//            self.selectedHours.append(WorkingDayHours(w_day: day, sTime: sTime, eTime: eTime))
//            if indexPath.row == 4{
//
//                first = true
//            }
        
        return cell
    }
   
    @IBAction func endTimeAction(_ sender: UIButton) {
        let alert = UIAlertController(style: .actionSheet, title: "Select Time")
        
        alert.addDatePicker(mode: UIDatePickerMode.time, date: nil) { (dateTime) in
            self.arrauEndTime[sender.tag] = Utility.convertDateFormater("\(dateTime)", dateFormat: "h:mm a")
           
        }
        
        alert.addAction(image: nil, title: "Done", color: nil, style: UIAlertActionStyle.default, isEnabled: true) { (dateTimeAction) in

            self.selectedHours.removeAll()
            self.tableviewdata.reloadData()
            //self.first = false
        }
        alert.show()
    }
    
    @IBAction func startTimeAction(_ sender: UIButton) {
        let alert = UIAlertController(style: .actionSheet, title: "Select Time")
        
        alert.addDatePicker(mode: UIDatePickerMode.time, date: nil) { (dateTime) in
            
            self.arrayStartTime[sender.tag] = Utility.convertDateFormater("\(dateTime)")
            print(Utility.convertDateFormater("\(dateTime)"))
            
            
        }
        
        alert.addAction(image: nil, title: "Done", color: nil, style: UIAlertActionStyle.default, isEnabled: true) { (dateTimeAction) in
            self.selectedHours.removeAll()
            self.tableviewdata.reloadData()
            //self.first = false
        }
        alert.show()
    }
    
    

    @IBAction func btnCheckmarkAction(_ sender: UIButton) {
        isTouchIndex = sender.tag
        
        let dayObj = arrayDay[sender.tag]
        let starTimeObj = arrayStartTime[sender.tag]
        let endTimeObj = arrauEndTime[sender.tag]
        

        
        var value = 0
        if sender.imageView?.image == #imageLiteral(resourceName: "blueCheck"){
            for i in selectedHours{
                if i.day == dayObj{
                    
                    self.selectedHours.remove(at: value)
                    print(i.day)
                    self.flagArray[sender.tag] = 0
                    break
                }
                value += 1
            }
        }else{
            print(dayObj)
             self.flagArray[sender.tag] = 1
            self.selectedHours.append(WorkingDayHours(w_day: dayObj, sTime: starTimeObj, eTime: endTimeObj))
        }
        
        
        tableviewdata.reloadData()
        
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var touch: UITouch? = touches.first
        //location is relative to the current view
        // do something with the touched point
        if touch?.view != timePicker {
            timePicker.removeFromSuperview()
        }
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
        
        if segue.identifier == "selectCatSegue"{
            let obj = segue.destination as! AddServicesCategoryVC
        }
        
    }
 

}
