//
//  DashboardViewController.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 30/05/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import KDCircularProgress
import KRProgressHUD

class DashboardViewController: UIViewController {

    @IBOutlet weak var circularProgress: KDCircularProgress!
    @IBOutlet weak var fromDateBtn: UIButton!
    
    @IBOutlet weak var toDateBtn: UIButton!
    
    @IBOutlet weak var btnUser: UIButton!
    let window = UIApplication.shared.keyWindow
    var tabbarControllerCreated = ManageLoginTabBarController()
    let shapeLayer = CAShapeLayer()
    
    var tabbarController = ManageLoginTabBarController()
   // var progress: KDCircularProgress!

    @IBOutlet weak var totalRevenue: UILabel!
    @IBOutlet weak var lbbProgressPercentage: UILabel!
    
    @IBOutlet weak var totalBooking: UILabel!
    
    @IBOutlet weak var clients: UILabel!
    
    var dashBoard:DashBoard!
    var startDate:String!
    var enddate:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.circularProgress.progress = 0
        if appDelegate.changeStoryBoard == true{
            appDelegate.changeStoryBoard = false
        }
 
        let createdView = CGRect()

        let viewPosition = CGPoint(x: view.frame.size.width / 3, y: view.frame.size.height / 2)

         self.btnUser.addTarget(self, action: #selector(btnUserAction(_:)), for: UIControlEvents.touchUpInside)
        self.btnUser.layer.borderWidth = 1
        self.btnUser.layer.borderColor = UIColor.white.cgColor
        self.btnUser.layer.cornerRadius = self.btnUser.frame.size.height / 2
        postDashBoard()
//        circularProgress.animate(fromAngle: -90, toAngle: 180, duration: 1.2) { (completed) in
//            if completed {
//                print("animation stopped, completed")
//            } else {
//                print("animation stopped, was interrupted")
//            }
//        }
        
//        circularProgress.animate(toAngle: 120, duration: 1) { (completed) in
//            if completed {
//                print("animation stopped, completed")
//            } else {
//                print("animation stopped, was interrupted")
//            }
//
//        }
       // self.progressView.animateView(value: 1)
        
        //create TrackLayer
//        let trackLayer = CAShapeLayer()
//        let circularPath = UIBezierPath(arcCenter: viewPosition, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
//
//        trackLayer.path = circularPath.cgPath
//
//        trackLayer.strokeColor = UIColor.lightGray.cgColor
//        trackLayer.lineWidth = 10
//
//        trackLayer.fillColor = UIColor.clear.cgColor
//        view.layer.addSublayer(trackLayer)
        
        //create circular ProgressView
//        let circularPath = UIBezierPath(arcCenter: viewPosition, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
//        shapeLayer.path = circularPath.cgPath
//
//        shapeLayer.strokeColor = UIColor.blue.cgColor
//        shapeLayer.lineWidth = 10
//        shapeLayer.strokeEnd = 0
//        shapeLayer.lineCap = kCALineCapRound
//        shapeLayer.fillColor = UIColor.clear.cgColor
//
//
//        view.layer.addSublayer(shapeLayer)
//        animateTheProgress()
        
        // Do any additional setup after loading the view.
    }

//    func animateTheProgress(){
//
//        let progressAnimation = CABasicAnimation(keyPath: "strokeEnd")
//
//        progressAnimation.toValue = 0.4
//        progressAnimation.duration = 2
//
//        progressAnimation.fillMode = kCAFillModeForwards
//        progressAnimation.isRemovedOnCompletion = false
//
//        shapeLayer.add(progressAnimation, forKey: "urSoBasic")
//    }
 
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
    
    func postDashBoard(){
        KRProgressHUD.show()
       // {"start_date":"","end_date":"","provider_id":"1"}

        startDate = fromDateBtn.titleLabel?.text!
        enddate = toDateBtn.titleLabel?.text!
        
        if startDate == "dd/mm/yyyy"{
            startDate = ""
        }
        
        if enddate == "dd/mm/yyyy"{
            enddate = ""
        }
        
        let post = ["start_date":"\(startDate!)","end_date":"\(enddate!)","provider_id":"\(userDefaults.value(forKey: "pro_id")!)"]
        
        ProviderManager.shared.dashBoardAPIa(params: post) { (success, response, message) in
            
            if success == true{
                self.dashBoard  = response
                
                self.clients.text! = self.dashBoard.total_clients!
                self.totalBooking.text! = self.dashBoard.total_appointments!
                self.totalRevenue.text! = "AED \(self.dashBoard.total_revenue!)"
                self.lbbProgressPercentage.text! = "\(self.dashBoard.daily_progress!) % to go"
                
                let ans = Double(self.dashBoard.daily_progress!)! / 100 * 360
                
                
                print(ans)
                self.circularProgress.progress = ans
                
//                self.circularProgress.animate(fromAngle: -90, toAngle: ans, duration: 0.1) { (completed) in
//                    if completed {
//                        print("animation stopped, completed")
//                    } else {
//                        print("animation stopped, was interrupted")
//                    }
//                }
                
                KRProgressHUD.dismiss()
            }else{
                KRProgressHUD.dismiss()
            }
            
        }
        
    }
    
    @IBAction func searchBtnAction(_ sender: UIButton) {
        
        postDashBoard()
        
    }
    @objc func btnUserAction(_ sender:UIButton){
        
        if let userLoginFlag = userDefaults.value(forKey: "user_id") as? String{
            
            pushView()

        }else {
            loadHomePage()
        }
  
    }
    
    @objc func pushView(){
    let sBoard = UIStoryboard.init(name: "User", bundle: nil)
    let vc = sBoard.instantiateViewController(withIdentifier: "UserTabBar") as! UserTabBarController
    //        vc.hidesBottomBarWhenPushed = false
    vc.hidesBottomBarWhenPushed = true
    userDefaults.set("user", forKey: "lastLogin")
    appDelegate.changeStoryBoard = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func loadHomePage() {
        
        //let window = UIApplication.shared.keyWindow
        // var tabbarController = ManageLoginTabBarController()
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
    
    @IBAction func btnLogoutaction(_ sender: UIButton) {
        //logout
        
    }
    
    @IBAction func fromDateAction(_ sender: UIButton) {
        let alert = UIAlertController(style: .actionSheet, title: "Date Picker", message: "Select Date")
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            Log(date)
            print(date)
            
            let stringDate = "\(date)"
            self.fromDateBtn.setTitle(Utility.convertDateFormater(stringDate, dateFormat: "dd-MM-yyyy"), for: .normal)
        }
        alert.addAction(title: "Done", style: .cancel)
        
        alert.show()
    }
    
    @IBAction func toDateAction(_ sender: UIButton) {
        
        let alert = UIAlertController(style: .actionSheet, title: "Date Picker", message: "Select Date")
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            Log(date)
            let stringDate = "\(date)"
            
            self.toDateBtn.setTitle(Utility.convertDateFormater(stringDate, dateFormat: "dd-MM-yyyy"), for: .normal)
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
        
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
        if segue.identifier == "logout"
        {
            let des = segue.destination as! ChooseServiceViewController
        }
    }
    

}
