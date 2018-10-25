//
//  SelectDateTimeForAppointmentBookingVC.swift
//  dummySalon
//
//  Created by Macbook Pro on 13/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KDCalendar
import EventKit
import KRProgressHUD
import SDWebImage

class SelectDateTimeForAppointmentBookingVC: UIViewController,CalendarViewDelegate,CalendarViewDataSource{
   
   //calendarView
    @IBOutlet weak var calendarView: CalendarView!

    @IBOutlet weak var btnServices: UIButton!
    
    @IBOutlet weak var employeeListCollectionView: UICollectionView!
    
    @IBOutlet weak var btnPreviousMonth: UIButton!
    @IBOutlet weak var btnNextMonth: UIButton!
    @IBOutlet weak var appointmentTableview: UITableView!
    
    @IBOutlet weak var txtFieldAddServices: UITextField!
    
    @IBOutlet weak var lblMorning: UILabel!
    
    @IBOutlet weak var lblAfternoon: UILabel!
    
    @IBOutlet weak var lblEvening: UILabel!
    
    @IBOutlet weak var morningCollectionView: UICollectionView!
    
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var eveningCollectionView: UICollectionView!
    @IBOutlet weak var afternoonCollectionView: UICollectionView!
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var addMoreServiceView: UIView!
    @IBOutlet weak var employeeLable: UILabel!
    //HeightConstraint
    @IBOutlet weak var morningHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var afternoonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var eveningHeightConstraint: NSLayoutConstraint!
    var dateFormatter = DateFormatter()
    
    @IBOutlet weak var addressViewConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var imgDoostep: UIImageView!
    @IBOutlet weak var imgSaloons: UIImageView!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var serviceTypeView: UIView!
    
    
    var morningTimeArray:[String] = ["10:30 AM","11:15 AM","11:45 AM","12:00 AM","12:30 AM","10:45 AM","2:45 AM","10:30 AM","11:15 AM","11:45 AM","12:00 PM"]
    var noonTimeArray:[String] = ["12:15 PM","12:30 PM","12:45 PM","1:00 PM","1:15 PM","1:30 PM","1:45 PM","2:00 PM", "2:15 PM","2:30 PM","2:45 PM","3:00 PM","3:15 PM","3:30 PM","3:45 PM","4:00 PM","4:15 PM","4:30 PM","4:45 PM","5:00 PM"]
    var eveningArray:[String] = ["5:15 PM","5:30 PM","5:45 PM","6:00 PM","6:15 PM","6:30 PM","6:45 PM","7:00 PM","7:15 PM","7:30 PM","7:45 PM","8:00 PM" ]
    
    var employeeId = ""
    var currentDate :Date!
    var selectedTime = ""
    var totalAmount = ""
    

    var getEmployee:[EmployeeeListAppointment] = []
    
    var selectedObj:[CatSerDetails] = []
    
    var getTimeInfo:[TimeInfo] = []
    
    var catID:[CatDetails] = []
    
    var mainOBJ : SalonDetailsBasedOnId!
    
    var selctedCatAndSer:[[String:Any]] = []
    
    var indexpath : IndexPath!
    var morningIndex : IndexPath!
    var afterNoonIndex : IndexPath!
    var eveningIndex : IndexPath!
   
     let today = Date()
    
    var serviceType = ""
    
    var firstTime = false
    
    var selectedDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDate = today
        employeeListCollectionView.delegate = self
        employeeListCollectionView.dataSource = self

        //bevel(5.0)
        CalendarView.Style.cellShape = .round
        CalendarView.Style.cellColorDefault         = UIColor.clear
        CalendarView.Style.cellColorToday           = UIColor(red:121/255, green:128.00/255, blue:132/255, alpha:1.00)
        CalendarView.Style.cellSelectedBorderColor  = UIColor(red:121/255, green:128/255, blue:132/255, alpha:1.00)
        CalendarView.Style.cellEventColor           = UIColor(red:1.00, green:0.63, blue:0.24, alpha:1.00)
        CalendarView.Style.headerTextColor          = UIColor.white
        CalendarView.Style.cellTextColorDefault     = UIColor.white
        CalendarView.Style.cellTextColorToday       = UIColor.white
    
        
        calendarView.delegate = self
        calendarView.dataSource = self
 
        calendarView.direction = .horizontal
        calendarView.multipleSelectionEnable = false
        calendarView.marksWeekends = true
        calendarView.layer.cornerRadius = 10
        
        self.btnServices.layer.cornerRadius = 15
        self.btnServices.layer.borderWidth = 1
        self.btnServices.layer.borderColor = UIColor.white.cgColor
        
        morningHeightConstraint.constant = morningCollectionHeight
        afternoonHeightConstraint.constant = afternoonCollectionHeight
        eveningHeightConstraint.constant = eveningCollectionHeight

        self.imgDoostep.image = #imageLiteral(resourceName: "radioOn")
        self.imgSaloons.image = #imageLiteral(resourceName: "radioOff")
        
        self.serviceType = "2"
        self.addressViewConstraintHeight.constant = 50
        
        self.serviceTypeView.layer.borderWidth = 1
        self.serviceTypeView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        // Do any additional setup after loading the view.
    }

    var morningCollectionHeight:CGFloat{
        
        self.morningCollectionView.layoutIfNeeded()
        return self.morningCollectionView.contentSize.height
        
    }
    var afternoonCollectionHeight:CGFloat{
        self.afternoonCollectionView.layoutIfNeeded()
        return self.afternoonCollectionView.contentSize.height
    }
    var eveningCollectionHeight:CGFloat{
        self.eveningCollectionView.layoutIfNeeded()
        return self.eveningCollectionView.contentSize.height
    }
    @IBAction func btnAddMoreServices(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addMoreServicesAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSellYourService(_ sender: UIButton) {
        
        if let getLogin = userDefaults.value(forKey: "pro_id") as? String{
            
            gotServiceoProvider()
            
        }else{
             createPopUpp()
        }
        
    }
    
    @IBAction func btnSelectType(_ sender: UIButton) {
        
        self.imgSaloons.image = #imageLiteral(resourceName: "radioOff")
        self.imgDoostep.image = #imageLiteral(resourceName: "radioOff")
        
        if sender.tag == 1{
            self.imgDoostep.image = #imageLiteral(resourceName: "radioOn")
            self.addressViewConstraintHeight.constant = 50
            
            self.serviceType = "2"
        }else{
            self.imgSaloons.image = #imageLiteral(resourceName: "radioOn")
            self.addressViewConstraintHeight.constant = 0
            
            self.serviceType = "1"
        }
        
    }
    
    @objc func createPopUpp(){
        Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "SelectDateTimeForAppointmentBookingVC", isLogin: false, isService: true )
    }
    
    @objc func gotServiceoProvider(){
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
//    /selectTimeSegue
    @IBAction func leftAction(_ sender: UIButton) {
        calendarView.goToPreviousMonth()
    }
    
    @IBAction func btnConfirm(_ sender: UIButton) {
        postAppointment()
//        let storyBoard = UIStoryboard.init(name: "User", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: "ConfirmAppointmentViewController") as! ConfirmAppointmentViewController
//
//        self.tabBarController?.tabBar.isHidden = true
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func rightAction(_ sender: UIButton) {
        calendarView.goToNextMonth()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Utility.chnageBtnTitle(btn: btnServices)

        currentDate = today
        self.calendarView.setDisplayDate(today, animated: false)
        tabBarController?.tabBar.isHidden = false
        //self.calendarView.selectDate(today)
        if appDelegate.changeStoryBoard == true{
            appDelegate.changeStoryBoard = false
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
    
    func postAppointment(){
        
        guard selectedTime != "" else {
            Utility.errorAlert(vc: self, strMessage: "Please select time for book appointment.", errortitle: "")
            return
        }
        
        if self.imgDoostep.image == #imageLiteral(resourceName: "radioOn"){

            guard self.txtAddress.text! != "" else {
                Utility.errorAlert(vc: self, strMessage: "Please enter your home address.", errortitle: "")
                return
            }
        }
        

        KRProgressHUD.show()

        
        var obj : [[String:Any]] = []
        
        var flag :Bool!
        for i in catID{
            flag = false
            for j in selectedObj{
            
                if i.ser_ID! == j.ser_cs_parent!{
                    flag = true
                    let obj1 = ["sub_cat_id":"\(j.ser_cs_id!)"]
                    
                    obj.append(obj1)
                }
                
            }
            print(i.ser_ID!)
            print(i.ser_name!)

            print(obj)
            if flag == true{
                self.selctedCatAndSer.append(["category_id":"\(i.ser_ID!)","sub_categories":obj])
                obj.removeAll()
            }
            
            
        }
    
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: currentDate)
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = "dd-mm-yyyy"
        let myStringafd = formatter.string(from: yourDate!)
        print(myStringafd)
        //currentDate  = Utility.convertDateFormater("\(currentDate)", dateFormat: "dd-mm-yyyy")
        
        let param = ["category_data":self.selctedCatAndSer,"date":"\(myStringafd)","time":"\(selectedTime)","service_pro_id":"\(mainOBJ.serviceProviderId!)","user_id":"\(userDefaults.value(forKey: "user_id")!)","emp_id":"\(employeeId)","service_type":"\(serviceType)","door_step_address":"\(self.txtAddress.text!)"] as [String : Any]
        
        UserManager.shared.bookAppointMent(parmas: param) { (success, message) in
            
            if success == true{

                let alert = UIAlertController(title: "", message: "\(message!)", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                    
                    let storyBoard = UIStoryboard.init(name: "User", bundle: nil)
                    let vc = storyBoard.instantiateViewController(withIdentifier: "ConfirmAppointmentViewController") as! ConfirmAppointmentViewController
                    //mainOBJ.serviceProviderId!
                    vc.selectedTime = self.selectedTime
                    vc.selectedDate = myStringafd
                    vc.catServices = self.selctedCatAndSer
                    vc.salonDetails = self.mainOBJ
                    vc.selectedCatSer = self.selectedObj
                    vc.amount = self.totalAmount
                    self.tabBarController?.tabBar.isHidden = true
                    self.navigationController?.pushViewController(vc, animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
               KRProgressHUD.dismiss()
            }else{
                KRProgressHUD.dismiss({
                    Utility.showAlert(vc: self, strMessage: "\(message!)", alerttitle: " ")
                })
            }
            
        }
        
    }
    
    func calendar(_ calendar: CalendarView, didScrollToMonth date: Date) {
        //print(date)
        
    }
    
    func calendar(_ calendar: CalendarView, didSelectDate date: Date, withEvents events: [CalendarEvent]) {
        print(date)
        print("Did Select: \(date) with \(events.count) events")
        for event in events {
            print("\t\"\(event)\" - Starting at:\(event)")
        }
        
        print(date)
        selectedTime = ""
        currentDate = date
        self.morningCollectionView.reloadData()
        self.afternoonCollectionView.reloadData()
        self.eveningCollectionView.reloadData()
        self.employeeListCollectionView.reloadData()
        
        morningHeightConstraint.constant = morningCollectionHeight
        afternoonHeightConstraint.constant = afternoonCollectionHeight
        eveningHeightConstraint.constant = eveningCollectionHeight
    }

    func calendar(_ calendar: CalendarView, canSelectDate date: Date) -> Bool {
        
        return true
    }
    
    func calendar(_ calendar: CalendarView, didDeselectDate date: Date) {
        
    }
    
    func calendar(_ calendar: CalendarView, didLongPressDate date: Date) {
        
    }
    
    func startDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = -3
        let today = Date()
        let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)
        return today
    }
    
    func endDate() -> Date {
        var dateComponents = DateComponents()
        
        dateComponents.year = 2;
        let today = Date()
        
        let twoYearsFromNow = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
        
        return twoYearsFromNow
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


extension SelectDateTimeForAppointmentBookingVC :UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let todayWeekday = Calendar.current.component(.weekday, from: currentDate)
        
        print(todayWeekday)
        var day = ""
        var selctedDay = ""
        
        switch todayWeekday{
            
        case 1:
            day = "Sunday"
            
        case 2:
            day = "Monday"
            
        case 3:
            day = "Tuesday"
            
        case 4:
            day = "Wednesday"
            
        case 5:
            day = "Thursday"
            
        case 6:
            day = "Friday"
            
        case 7:
            day = "Saturday"
            
        default:
            break
            
        }
        
        for i in getTimeInfo{
            
            if day == i.oh_day!{
                selctedDay = "\(i.oh_day!)"
            }
            
        }
        if selctedDay != ""{
            self.employeeLable.isHidden = false
            //self.addressViewConstraintHeight.constant = 50
            self.serviceTypeView.isHidden = false
            self.btnConfirm.isHidden = false
            self.addMoreServiceView.isHidden = false
            //self.mainScrollView.isScrollEnabled = true
            if collectionView == employeeListCollectionView{
                return getEmployee.count
            }else if collectionView.tag == 1 {
                self.lblMorning.isHidden = false
                return morningTimeArray.count
                
            }else if collectionView.tag == 2 {
                self.lblAfternoon.isHidden = false
                return noonTimeArray.count
                
            }else if collectionView.tag == 3 {
                self.lblEvening.isHidden = false
                self.lblStatus.isHidden = true
                
                return eveningArray.count
            }
        }else{
            self.employeeLable.isHidden = true
            //self.addressViewConstraintHeight.constant = 0
            self.serviceTypeView.isHidden = true
            self.btnConfirm.isHidden = true
            self.addMoreServiceView.isHidden = true
            //self.mainScrollView.isScrollEnabled = false
            if collectionView == employeeListCollectionView{
                return 0
            }else if collectionView.tag == 1 {
                self.lblMorning.isHidden = true
                return 0
            }else if collectionView.tag == 2 {
                self.lblAfternoon.isHidden = true

                return 0
            }else if collectionView.tag == 3 {
                self.lblEvening.isHidden = true
                self.lblStatus.isHidden = false
                morningCollectionView.bringSubview(toFront: self.lblStatus)
                self.lblStatus.text! = "No Appointments Available."
                
                return 0
            }else{
                return 0
            }
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Utility.convertDateFormater("\(currentDate)", dateFormat: "weekday")
       
        
            if collectionView == employeeListCollectionView{
                let employeeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "employeeCell", for: indexPath) as! EmployeeCollectionViewCell
                
                let employee = getEmployee[indexPath.row]
                
                employeeCell.lblEmployee.text! = employee.em_fname!
                
                if indexPath.row == 0{
                    employeeCell.imgEmployee.image = #imageLiteral(resourceName: "proICon")
                    
                    if firstTime == false{
                        firstTime = true
                        self.employeeId = "\(employee.em_id!)"
                    }
                    
                }
                else{
                    employeeCell.imgEmployee.image = #imageLiteral(resourceName: "proWhite")
                }
                
                if indexpath != nil{
                    if indexpath == indexPath{
                        employeeCell.imgEmployee.image = #imageLiteral(resourceName: "proICon")
                    }else {
                        employeeCell.imgEmployee.image = #imageLiteral(resourceName: "proWhite")
                    }
                }
                
                return employeeCell
            }else{
                if collectionView.tag == 1{
                    let morningCell = collectionView.dequeueReusableCell(withReuseIdentifier: "appointmentCell", for: indexPath) as! AppointmentTimeCollectionViewCell
                    
                    morningCell.lblTime.text = morningTimeArray[indexPath.item]
                    
                    
                    morningCell.layer.borderWidth = 1
                    morningCell.layer.cornerRadius = 2
                    morningCell.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
                    
                    morningCell.backgroundColor = UIColor.white
                    morningCell.lblTime.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
                    
                    if morningIndex != nil{
                        if morningIndex == indexPath{
                            morningCell.backgroundColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
                            morningCell.lblTime.textColor = UIColor.white
                            selectedTime = morningTimeArray[morningIndex.item]
                        }else{
                            morningCell.backgroundColor = UIColor.white
                            morningCell.lblTime.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
                        }
                    }
                    
                    return morningCell
                    
                }else if collectionView.tag == 2{
                    let afternoonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "afternoonCell", for: indexPath) as! AfternoonCollectionViewCell
                    
                    afternoonCell.lblTime.text = noonTimeArray[indexPath.item]
                    afternoonCell.layer.borderWidth = 1
                    afternoonCell.layer.cornerRadius = 2
                    afternoonCell.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
                    
                    afternoonCell.backgroundColor = UIColor.white
                    afternoonCell.lblTime.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
                    if afterNoonIndex != nil{
                        if afterNoonIndex == indexPath{
                            afternoonCell.backgroundColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
                            afternoonCell.lblTime.textColor = UIColor.white
                            selectedTime = noonTimeArray[afterNoonIndex.item]
                        }else{
                            afternoonCell.backgroundColor = UIColor.white
                            afternoonCell.lblTime.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
                        }
                    }
                    
                    return afternoonCell
                    
                }else if collectionView.tag == 3{
                    let eveningCell = collectionView.dequeueReusableCell(withReuseIdentifier: "eveningCell", for: indexPath) as! EveningCollectionViewCell
                    
                    eveningCell.lblTime.text = eveningArray[indexPath.item]
                    eveningCell.layer.borderWidth = 1
                    eveningCell.layer.cornerRadius = 2
                    eveningCell.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
                    eveningCell.backgroundColor = UIColor.white
                    eveningCell.lblTime.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
                    
                    if eveningIndex != nil{
                        if eveningIndex == indexPath{
                            eveningCell.backgroundColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
                            eveningCell.lblTime.textColor = UIColor.white
                            
                            selectedTime = eveningArray[eveningIndex.item]
                        }else{
                            eveningCell.backgroundColor = UIColor.white
                            eveningCell.lblTime.textColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1)
                        }
                    }
                    
                    return eveningCell
                }
            
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == employeeListCollectionView{
   
            indexpath = indexPath
            let employee = getEmployee[indexPath.row]
            employeeId = employee.em_id!
            
            
            self.employeeListCollectionView.reloadData()
            
        }else if collectionView == morningCollectionView{
            
            morningIndex = indexPath
            afterNoonIndex = nil
            eveningIndex = nil
            self.morningCollectionView.reloadData()
            self.afternoonCollectionView.reloadData()
            self.eveningCollectionView.reloadData()
        }else if collectionView == afternoonCollectionView{
            morningIndex = nil
            eveningIndex = nil
            afterNoonIndex = indexPath
            self.morningCollectionView.reloadData()
            self.afternoonCollectionView.reloadData()
            self.eveningCollectionView.reloadData()
            
        }else if collectionView == eveningCollectionView{
            morningIndex = nil
            afterNoonIndex = nil
            eveningIndex = indexPath
            self.morningCollectionView.reloadData()
            self.afternoonCollectionView.reloadData()
            self.eveningCollectionView.reloadData()
        }
    }
}

extension SelectDateTimeForAppointmentBookingVC:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == employeeListCollectionView{
            return CGSize(width: collectionView.frame.size.width / 5 - 15, height: collectionView.frame.size.height)
        }else if collectionView.tag == 1{

            //collectionView.collectionViewLayout.collectionViewContentSize.height
            
            return CGSize(width: collectionView.frame.size.width / 5 - 13 , height: 30)
            
        }else if collectionView.tag == 2{
            return CGSize(width: collectionView.frame.size.width /  5 - 13  , height: 30)
        }else if collectionView.tag == 3{
            return CGSize(width: collectionView.frame.size.width / 5 - 13, height: 30)
        }else {
            return CGSize()
        }
        
        
    }
    
}
