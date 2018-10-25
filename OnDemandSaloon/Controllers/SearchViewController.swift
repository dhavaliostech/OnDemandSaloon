//
//  SearchViewController.swift
//  OnDemandSaloon
//
//  Created by Pratik Zankat on 09/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//
//RangeSeekSlider
import UIKit
import RangeSeekSlider
import KRProgressHUD
import FloatRatingView

class SearchViewController: UIViewController,RangeSeekSliderDelegate,FloatRatingViewDelegate,UIGestureRecognizerDelegate {

    @IBOutlet var btnSell: UIButton!
    @IBOutlet var btnSearch: UIButton!
    @IBOutlet var lblPricefilterData: UILabel!
    @IBOutlet var lblPricefilter: UILabel!
    @IBOutlet var btnFifth: UIButton!
    @IBOutlet var btnFourth: UIButton!
    @IBOutlet var btnThird: UIButton!
    @IBOutlet var btnSecond: UIButton!
    @IBOutlet var btnFirst: UIButton!
    @IBOutlet var lblRating: UILabel!
    @IBOutlet var ratingBackView: UIView!
    @IBOutlet var lblCategory: UILabel!
    @IBOutlet var categoryBackView: UIView!
    @IBOutlet var lblService: UILabel!
    @IBOutlet var serviceBackView: UIView!
    @IBOutlet var lblLocation: UILabel!
    @IBOutlet var locationBackView: UIView!
    @IBOutlet var lblCity: UILabel!
    @IBOutlet var cityBackView: UIView!
    @IBOutlet var lblStates: UILabel!
    @IBOutlet var statesBackView: UIView!
    @IBOutlet var lblCountry: UILabel!
    @IBOutlet var countryBackView: UIView!
    @IBOutlet var prizeFilterSlider: RangeSeekSlider!
    @IBOutlet var navigationView: UIView!
    
    @IBOutlet weak var ratingView: FloatRatingView!
    //Response Data
    var allDataForSearchSalon:GetSearchData!
    var contryArr:[GetContry] = []
    var cityArr:[GetCities] = []
    var locationArr:[GetLocation] = []
    var mainCatArr:[MainCategory] = []
    
    //Sub cat response data
    var getSalonSubCat :[ServiceDetails] = []
    
    //Selected obj
    var catId:String!
    var serviceId:String!
    var contry:String!
    var selectCity:String!
    var selectedLocation:String!
    var rating:Int!
    /////////////////////////////
    
    var objectProfile:SideMenuViewController!
    var isMenu:Bool = false
    var backgroundView = UIView()
    
    //static
    var arrCountry:[String] = []
    var arrstates :[String] = []
    var city :[String] = []
    var arrcat:[String] = []
    var arrService :[String] = []
    var arrLocation :[String] = []
    
    //Min and max value
    var minValue :Int!
    var maxValue:Int!
    
    var isChangeValue = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prizeFilterSlider.delegate = self
        
        prizeFilterSlider.handleImage = #imageLiteral(resourceName: "slider1")
        prizeFilterSlider.handleDiameter = 13
        
        prizeFilterSlider.selectedHandleDiameterMultiplier = 1.5
        prizeFilterSlider.handleColor = UIColor.gray
        //prizeFilterSlider.initialColor = UIColor.lightGray
        prizeFilterSlider.colorBetweenHandles = txtBlueColor
        prizeFilterSlider.lineHeight = 10.0
        prizeFilterSlider.numberFormatter.positivePrefix = "AED"
        prizeFilterSlider.numberFormatter.positiveSuffix = ""
        
        btnSell.layer.borderWidth = 1
        btnSell.layer.borderColor = UIColor.white.cgColor
        btnSell.layer.cornerRadius = 15
        
        ratingView.delegate = self
        ratingView.contentMode = UIViewContentMode.scaleAspectFit
        ratingView.type = .wholeRatings
        ratingView.editable = true
       
        
        setUpUI(setView: ratingBackView)
        setUpUI(setView: categoryBackView)
        setUpUI(setView: serviceBackView)
        setUpUI(setView: locationBackView)
        setUpUI(setView: cityBackView)
        setUpUI(setView: countryBackView)
       // btnSell.clipsToBounds = true
        
       getData()
        
        // Do any additional setup after loading the view.
    }
    
    func getData(){
        KRProgressHUD.show()
        UserManager.shared.getSearchDataInSearchTab(param: [:]) { (success, responseData, error) in
            
            if success == true{
                
                self.allDataForSearchSalon = responseData
                
                 self.contryArr = self.allDataForSearchSalon.contryArray
                
                self.cityArr.append(GetCities(dict: ["city_name":"All"]))
                    
                for i in self.allDataForSearchSalon.cityArray{
                    self.cityArr.append(i)
                }
                
                self.locationArr.append(GetLocation(dict: ["loc_name":"All"]))
                
                for j in self.allDataForSearchSalon.locationArray{
                    self.locationArr.append(j)
                }
                
                self.mainCatArr.append(MainCategory(dict: ["ser_name":"All"]))
                for k in self.allDataForSearchSalon.getAllTheCategories{
                    self.mainCatArr.append(k)
                }
                
                
                self.lblPricefilterData.text = "Price AED\(self.allDataForSearchSalon.minValue!) - AED\(self.allDataForSearchSalon.maxValue!)"
                self.lblCity.text = self.cityArr[0].cityName!
               
                
                self.lblLocation.text = self.locationArr[0].locName!

                self.lblCountry.text = self.contryArr[0].contry_Name!

                self.lblCategory.text = self.mainCatArr[0].ser_name!

                self.lblService.text = "All"
  
                self.minValue = Int(self.allDataForSearchSalon.minValue!)
                self.maxValue = Int(self.allDataForSearchSalon.maxValue!)
                self.rating = 0
                self.prizeFilterSlider.minValue = CGFloat(self.minValue!)
                self.prizeFilterSlider.maxValue = CGFloat(self.maxValue!)
                self.prizeFilterSlider.selectedMinValue = CGFloat(self.minValue!)
                self.prizeFilterSlider.selectedMaxValue = CGFloat(self.maxValue!)
                
                self.selectCity = self.cityArr[0].cityName!
                self.selectedLocation = self.locationArr[0].locName!
                self.contry = self.contryArr[0].contry_Name!
                self.catId = self.mainCatArr[0].ser_id!
                self.catId = ""
                self.serviceId = ""
                self.selectedLocation = ""
                self.selectCity = ""
                //self.serviceId = self.mainCatArr[0].service_data[0].ser_cat_ID!
                
                KRProgressHUD.dismiss()
            }else{
                
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(error!)", errortitle: "")
                })
                
            }
           
        }
        
    }
    
    func setUpUI(setView:UIView){
        setView.layer.borderWidth = 1
        setView.layer.cornerRadius = 4
        setView.clipsToBounds = true
        setView.layer.borderColor = UIColor(red: 219.0/255.0, green: 223.0/255.0, blue: 226.0/255.0, alpha: 1.0).cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Utility.chnageBtnTitle(btn: btnSell)

        if appDelegate.changeStoryBoard == true{
            appDelegate.changeStoryBoard = false
        }
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

    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        
        self.minValue = Int(minValue)
        self.maxValue = Int(maxValue)
        
        self.lblPricefilterData.text = "Price AED\(self.minValue!) - AED\(self.maxValue!)"
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        
        self.rating = Int(rating)
        print(self.rating)
    }
    
    @IBAction func btnSearchaction(_ sender: UIButton) {
  
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        KRProgressHUD.show()
        var params : [String:Any]!
        
        params = ["country":"\(contry!)","cat_id":"\(catId!)","category_service_id":"\(serviceId!)","location":"\(selectedLocation!)","city":"\(selectCity!)","min_price":"\(self.minValue!)","max_price":"\(self.maxValue!)","rating":"\(rating!)"]

        UserManager.shared.searchFilterAPI(param: params) { (success, responseData,message) in
            
            if success == true{
                
                var getData :[SalonObj] = []
                getData = responseData
                print("success API")
                 self.performSegue(withIdentifier: "searchResultSegue", sender: getData)
                KRProgressHUD.dismiss()
            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
            }
        }
    }
    
    
    @IBAction func btnCategoryaction(_ sender: UIButton) {
        
            arrcat.removeAll()
            
            for i in mainCatArr{
                arrcat.append(i.ser_name!)
            }
            
            self.lblCategory.text = self.arrcat[0]
            let alert = UIAlertController(style: .actionSheet, title: "", message: "Select Category")
            let pickerViewValues: [String] = arrcat
            // let frameSizes: [CGFloat] = (150...400).map { CGFloat($0) }
            let index = arrcat.first
            let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: arrcat.index(of: index!) ?? 0)
            
            alert.addPickerView(values: [pickerViewValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
                self.lblCategory.text = self.arrcat[index.row]
                self.getSalonSubCat.removeAll()
                self.getSalonSubCat.append(ServiceDetails(dict: ["ser_cat_name":"All"]))
                self.lblService.text = "All"
                for i in self.mainCatArr[index.row].service_data{
                    self.getSalonSubCat.append(i)
                }

                self.catId! = self.mainCatArr[index.row].ser_id!
                
            }
            alert.addAction(title: "Done", style: .cancel)
            alert.show()
        
    }
    
    
    
    @IBAction func btnserviceaction(_ sender: UIButton) {
        
        if self.getSalonSubCat.count != 0{
            
            arrService.removeAll()
            for i in getSalonSubCat{
                arrService.append(i.ser_cat_Name!)
            }
            
            self.lblService.text = self.arrService[0]
            let alert = UIAlertController(style: .actionSheet, title: "", message: "Category of Services")
            let pickerViewValues: [String] = arrService
            // let frameSizes: [CGFloat] = (150...400).map { CGFloat($0) }
            let index = arrService.first
            let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: arrService.index(of: index!) ?? 0)
            
            alert.addPickerView(values: [pickerViewValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
                self.lblService.text = self.arrService[index.row]
                self.serviceId! = self.getSalonSubCat[index.row].ser_cat_ID!
                
            }
            alert.addAction(title: "Done", style: .cancel)
            alert.show()
        
        }

    }
    
    
    @IBAction func btnSellYourService(_ sender: UIButton) {
 
        if let getLogin = userDefaults.value(forKey: "pro_id") as? String{
            
            gotoProvider()
            
        }else{
            createPopUp()
        }
     
    }
    
    @objc func createPopUp(){
        Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "SearchViewController", isLogin: false, isService: true )
    }
    @objc func gotoProvider(){
 
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
    
    @IBAction func btnlocationaction(_ sender: UIButton) {//areaArray

        guard arrLocation.count != 0 else {
            
            Utility.errorAlert(vc: self, strMessage: "Please select city first.", errortitle: "")
            return
        }
        
        self.lblLocation.text = arrLocation[0]
        let alert = UIAlertController(style: .actionSheet, title: "", message: "Select Location")
        let pickerViewValues: [String] = arrLocation
        // let frameSizes: [CGFloat] = (150...400).map { CGFloat($0) }
        let index = arrLocation.first
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: arrLocation.index(of: index!) ?? 0)
        
        alert.addPickerView(values: [pickerViewValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in

            self.lblLocation.text = self.arrLocation[index.row]
            
            if self.lblLocation.text == "All"{
                self.selectedLocation! = ""
            }else{
                 self.selectedLocation! = self.lblLocation.text!
            }
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
    }
    
    @IBAction func btnCityaction(_ sender: UIButton) {
        city.removeAll()
        for i in cityArr{
            city.append(i.cityName!)
        }
        
        self.lblCity.text = city[0]
        let alert = UIAlertController(style: .actionSheet, title: "", message: "Select Cities")
        let pickerViewValues: [String] = city
        // let frameSizes: [CGFloat] = (150...400).map { CGFloat($0) }
        let index = city.first
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: city.index(of: index!) ?? 0)
        
        alert.addPickerView(values: [pickerViewValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            self.lblCity.text = self.city[index.row]
            self.selectCity! = self.lblCity.text!
           // arrLocation
            //locationArr
            self.arrLocation.append("All")
            let cityID = self.cityArr[index.row].city_id!
            for i in self.locationArr{
                if i.city_ID! == cityID{
                    self.arrLocation.append(i.locName!)
                }
            }
            
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
    }
    
    
    
    @IBAction func btnCountry(_ sender: UIButton) {
        self.arrCountry.removeAll()
        for i in contryArr{
            self.arrCountry.append(i.contry_Name!)
        }
        
        self.lblCountry.text = self.arrCountry[0]
        let alert = UIAlertController(style: .actionSheet, title: "", message: "Category of Services")
        let pickerViewValues: [String] = arrCountry
        // let frameSizes: [CGFloat] = (150...400).map { CGFloat($0) }
        let index = arrCountry.first
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: arrCountry.index(of: index!) ?? 0)
        
        alert.addPickerView(values: [pickerViewValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            self.lblCountry.text = self.arrCountry[index.row]
            self.contry! = self.lblCountry.text!
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
    }

    @IBAction func btnFifthRatingaction(_ sender: UIButton) {
        btnFifth.setImage(#imageLiteral(resourceName: "selectedRating"), for: .normal)
        btnFourth.setImage(#imageLiteral(resourceName: "selectedRating"), for: .normal)
        btnThird.setImage(#imageLiteral(resourceName: "selectedRating"), for: .normal)
        btnSecond.setImage(#imageLiteral(resourceName: "selectedRating"), for: .normal)
        btnFirst.setImage(#imageLiteral(resourceName: "selectedRating"), for: .normal)
        
        self.rating = 5
        
    }
    @IBAction func btnFourthRatingaction(_ sender: UIButton) {
        btnFifth.setImage(#imageLiteral(resourceName: "unselectedRating"), for: .normal)
        btnFourth.setImage(#imageLiteral(resourceName: "selectedRating"), for: .normal)
        btnThird.setImage(#imageLiteral(resourceName: "selectedRating"), for: .normal)
        btnSecond.setImage(#imageLiteral(resourceName: "selectedRating"), for: .normal)
        btnFirst.setImage(#imageLiteral(resourceName: "selectedRating"), for: .normal)
        self.rating = 4

    }
    @IBAction func btnThirdRatingaction(_ sender: UIButton) {
        btnFifth.setImage(#imageLiteral(resourceName: "unselectedRating"), for: .normal)
        btnFourth.setImage(#imageLiteral(resourceName: "unselectedRating"), for: .normal)
        btnThird.setImage(#imageLiteral(resourceName: "selectedRating"), for: .normal)
        btnSecond.setImage(#imageLiteral(resourceName: "selectedRating"), for: .normal)
        btnFirst.setImage(#imageLiteral(resourceName: "selectedRating"), for: .normal)
        self.rating = 3
    }
    @IBAction func btnSecondRatingaction(_ sender: UIButton) {
        btnFifth.setImage(#imageLiteral(resourceName: "unselectedRating"), for: .normal)
        btnFourth.setImage(#imageLiteral(resourceName: "unselectedRating"), for: .normal)
        btnThird.setImage(#imageLiteral(resourceName: "unselectedRating"), for: .normal)
        btnSecond.setImage(#imageLiteral(resourceName: "selectedRating"), for: .normal)
        btnFirst.setImage(#imageLiteral(resourceName: "selectedRating"), for: .normal)
        self.rating = 2
    }
    @IBAction func btnFirstRatingaction(_ sender: UIButton) {
        btnFifth.setImage(#imageLiteral(resourceName: "unselectedRating"), for: .normal)
        btnFourth.setImage(#imageLiteral(resourceName: "unselectedRating"), for: .normal)
        btnThird.setImage(#imageLiteral(resourceName: "unselectedRating"), for: .normal)
        btnSecond.setImage(#imageLiteral(resourceName: "unselectedRating"), for: .normal)
        btnFirst.setImage(#imageLiteral(resourceName: "selectedRating"), for: .normal)
        self.rating = 1
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
        
        if segue.identifier == "searchResultSegue"{
            let obj = segue.destination as! SearchResultViewController
            tabBarController?.tabBar.isHidden = false
            obj.searchResultArray = sender as! [SalonObj] 
        }
    }
 

}

