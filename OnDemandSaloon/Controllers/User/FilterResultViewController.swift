//
//  FilterResultViewController.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 09/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import RangeSeekSlider
import FloatRatingView
import KRProgressHUD
import SDWebImage

class FilterResultViewController: UIViewController,RangeSeekSliderDelegate,FloatRatingViewDelegate,UITextFieldDelegate{
    
    @IBOutlet weak var lblShowPrice: UILabel!
    @IBOutlet weak var searchTextField: UITextField!

    @IBOutlet weak var categoryColllectionView: UICollectionView!
    
    
    //Filter Outlets
    @IBOutlet weak var filterBackView: UIView!
    
    @IBOutlet weak var contryLbl: UILabel!
    
    @IBOutlet weak var stateLbl: UILabel!
    
    @IBOutlet weak var cityLbl: UILabel!
    
    @IBOutlet weak var resultLbl: UILabel!
    
    @IBOutlet weak var btnResult: UIButton!
    @IBOutlet weak var btnContry: UIButton!
    @IBOutlet weak var btnState: UIButton!
    @IBOutlet weak var btnCity: UIButton!
    
    @IBOutlet weak var prizeFilterSlider: RangeSeekSlider!
    
    @IBOutlet weak var ratingView: FloatRatingView!
    
    @IBOutlet weak var btnServices: UIButton!
    
     @IBOutlet weak var searchResultCollectionView: UICollectionView!
    
    @IBOutlet weak var btnLocationAndResultCount: UIButton!
    @IBOutlet weak var lblSalonAlert: UILabel!
    
    
    var stringArray: [String] = ["All","Hair cut","Hair color","Hair Shampoo","Hair spa"]
    
    var arrCountry: [GetContry] = []
    var arrCity:[GetCities] = []
    var location : [GetLocation] = []
    
    var serviceArray : [ServiceDetails] = []
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var arraayOFWidth : [CGFloat] = []
    
    var catID:ListOfMainCategories!
    var filterDataBasedOnId :FilterDetailsById!
    
    var arrayDetails:[SalonObj] = []
    var getSelectedObj :SalonObj!
    
    let tabbarController = ManageLoginTabBarController()
    
    var isID = false
    var isSearch = false

    var serviceIndex : Int!

    //Filter Var
    var filterArray :[SalonObj] = []
    var isFilterOn = false
    
    var searchArray :[SalonObj] = []
    var isSearchByName = false
    var contryfilter = ""
    var cityfilter = ""
    var locationfilter = ""
    var minFilter = ""
    var maxFilter = ""
    var ratingfilter :Int!
    var catServiceId = ""

    var cityId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        searchArray.removeAll()
        self.prizeFilterSlider.delegate = self
        
        prizeFilterSlider.handleImage = #imageLiteral(resourceName: "slider1")
        prizeFilterSlider.handleDiameter = 13
        prizeFilterSlider.selectedHandleDiameterMultiplier = 1.5
        self.prizeFilterSlider.handleColor = UIColor.gray
        self.self.prizeFilterSlider.initialColor = txtBlueColor
        self.prizeFilterSlider.colorBetweenHandles = txtBlueColor
        self.prizeFilterSlider.lineHeight = 10.0
        self.prizeFilterSlider.numberFormatter.positivePrefix = ""
        self.prizeFilterSlider.numberFormatter.positiveSuffix = ""
        self.prizeFilterSlider.hideLabels = true
        
        if isSearch == true{
           self.searchTextField.becomeFirstResponder()
            getAllBasedOnSearch()
            //self.isID = false
        }else{
            if catID.ser_ID! != ""{
                self.isID = true
                getDataBasedOnId()
            }
        }

        self.lblShowPrice.text! = "Price AED\(prizeFilterSlider.selectedMinValue) - AED\(prizeFilterSlider.selectedMaxValue)"
        
        ratingView.delegate = self
        ratingView.contentMode = UIViewContentMode.scaleAspectFit
        ratingView.type = .wholeRatings
        ratingView.editable = true
        ratingView.layer.borderWidth = 1
        ratingView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
        self.lblSalonAlert.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        Utility.chnageBtnTitle(btn: btnServices)
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
    
    @IBAction func btnLocationAction(_ sender: UIButton) {

        guard  self.cityLbl.text != "All" else {
            Utility.errorAlert(vc: self, strMessage: "Please select city first.", errortitle: "")
            
            return
        }
        
        
        var getLocation :[String] = []
        
        for i in location{
            
            if getLocation.count == 0 {
                getLocation.append("All")
            }
            
            if cityId != ""{
                if cityId == i.city_ID!{
                    getLocation.append(i.locName!)
                }
            }
            
        }
        guard getLocation.count != 0 else{
            return
        }
        self.resultLbl.text = getLocation[0]
        let alert = UIAlertController(style: .actionSheet, title: "", message: "Select Location")
        let pickerViewValues: [String] = getLocation
        // let frameSizes: [CGFloat] = (150...400).map { CGFloat($0) }
        let index = getLocation.first
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: getLocation.index(of: index!) ?? 0)
        self.locationfilter = self.resultLbl.text!
        self.callFilter()
        alert.addPickerView(values: [pickerViewValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            self.resultLbl.text = getLocation[index.row]
            //"\(self.location[0].locName!) - \(self.arrayDetails.count)"
            self.locationfilter = getLocation[index.row]
            self.callFilter()
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
    }
    
    @IBAction func btnCityAction(_ sender: UIButton) {
        
        var getCities :[String] = []
        for i in arrCity{
            getCities.append(i.cityName)
        }
        guard arrCity.count != 0 else{
            return
        }
        self.cityLbl.text = getCities[0]
        let alert = UIAlertController(style: .actionSheet, title: "", message: "Select Cities")
        let pickerViewValues: [String] = getCities
        // let frameSizes: [CGFloat] = (150...400).map { CGFloat($0) }
        let index = getCities.first
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: getCities.index(of: index!) ?? 0)
        
        alert.addPickerView(values: [pickerViewValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            self.cityLbl.text = getCities[index.row]
            self.cityfilter = getCities[index.row]
            self.cityId = self.arrCity[index.row].city_id!
            self.resultLbl.text! = "All"
            
            self.callFilter()
        }
        
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
    }
    
    @IBAction func btnContryAction(_ sender: UIButton) {
        var contry:[String] = []
        for i in arrCountry{
            contry.append(i.contry_Name!)
        }
        
        guard contry.count != 0 else{
            return
        }
        
        self.contryLbl.text = contry[0]
        let alert = UIAlertController(style: .actionSheet, title: "", message: "Select Contry.")
        let pickerViewValues: [String] = contry
        // let frameSizes: [CGFloat] = (150...400).map { CGFloat($0) }
        let index = contry.first
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: contry.index(of: index!) ?? 0)

        alert.addPickerView(values: [pickerViewValues], initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            self.contryLbl.text = contry[index.row]
            self.contryfilter = self.contryLbl.text!
            self.callFilter()
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
    }
    
    @IBAction func searchSalonAction(_ sender: UITextField) {
        
        if isFilterOn == true{
            isFilterOn = false
        }
        
        let searchtext = searchTextField.text
        if isSearch == true{
            
            searchArray = arrayDetails.filter { $0.business_name!.lowercased().contains((searchtext?.lowercased())!)}
            //print(searchArray[0].business_name!)

            searchResultCollectionView.reloadData()
        }else{
            searchArray = arrayDetails.filter { $0.business_name!.lowercased().contains((searchtext?.lowercased())!)}
            //self.isID = true

             searchResultCollectionView.reloadData()
        }
        isSearchByName = true
        searchResultCollectionView.reloadData()
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if textField == searchTextField
        {
            if searchTextField.text == ""
            {
                isSearchByName = false
                isFilterOn = false
                searchResultCollectionView.reloadData()
                
            }else{
                
                searchResultCollectionView.reloadData()
                
            }
        }
    }
    
    func getDataBasedOnId(){
        KRProgressHUD.show()
        let params = ["cat_id":"\(catID.ser_ID!)"]
        
        UserManager.shared.ListIsBasedOnCatID(param: params) { (success, getData, message) in
            
            if success == true{

                self.filterDataBasedOnId = getData
            
                self.arrayDetails = self.filterDataBasedOnId.mainObjectForSalon
                self.arrCountry = self.filterDataBasedOnId.contry


                self.serviceArray.append(ServiceDetails(dict: ["ser_cat_name":"All"]))
                
                for i in self.filterDataBasedOnId.categorySerViceDetails{
                    self.serviceArray.append(i)
                }
                
                self.arrCity.append(GetCities(dict: ["city_name":"All"]))
                
                for i in self.filterDataBasedOnId.cities{
                    self.arrCity.append(i)
                }
                
                self.location.append(GetLocation(dict: ["loc_name":"All"]))
                
                for i in self.filterDataBasedOnId.location{
                    self.location.append(i)
                }

                let minPrice = NumberFormatter().number(from: self.arrayDetails[0].salon_min_price!)
                let maxPrice =  NumberFormatter().number(from: self.arrayDetails[0].salon_max_price!)
                self.prizeFilterSlider.minValue = CGFloat(truncating: minPrice!)
                self.prizeFilterSlider.maxValue = CGFloat(truncating: maxPrice!)
                self.prizeFilterSlider.selectedMinValue = CGFloat(truncating: minPrice!)
                self.prizeFilterSlider.selectedMaxValue = CGFloat(truncating: maxPrice!)
                
                self.minFilter = self.arrayDetails[0].salon_min_price!
                self.maxFilter = self.arrayDetails[0].salon_max_price!
                
                self.contryLbl.text = self.arrCountry[0].contry_Name!
                self.cityLbl.text = self.arrCity[0].cityName!
                self.resultLbl.text = "\(self.location[0].locName!)"
                self.searchResultCollectionView.reloadData()
                self.categoryColllectionView.reloadData()
                KRProgressHUD.dismiss()

            }else{
                KRProgressHUD.dismiss({
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
            }
        }
    }
    
    
    func getAllBasedOnSearch(){
        
        KRProgressHUD.show()
        UserManager.shared.searchData(param: [:]) { (success, response, message) in
            
            if success == true{
                self.filterDataBasedOnId = response
                
                self.arrayDetails = self.filterDataBasedOnId.mainObjectForSalon
                self.arrCountry = self.filterDataBasedOnId.contry
                
                
                self.serviceArray.append(ServiceDetails(dict: ["ser_cat_name":"All"]))
                
                for i in self.filterDataBasedOnId.categorySerViceDetails{
                    self.serviceArray.append(i)
                }
                
                self.arrCity.append(GetCities(dict: ["city_name":"All"]))
                
                for i in self.filterDataBasedOnId.cities{
                    self.arrCity.append(i)
                }
                
                self.location.append(GetLocation(dict: ["loc_name":"All"]))
                
                for i in self.filterDataBasedOnId.location{
                    self.location.append(i)
                }
                
                let minPrice = NumberFormatter().number(from: self.arrayDetails[0].salon_min_price!)
                let maxPrice =  NumberFormatter().number(from: self.arrayDetails[0].salon_max_price!)
                self.prizeFilterSlider.minValue = CGFloat(truncating: minPrice!)
                self.prizeFilterSlider.maxValue = CGFloat(truncating: maxPrice!)
                self.prizeFilterSlider.selectedMinValue = CGFloat(truncating: minPrice!)
                self.prizeFilterSlider.selectedMaxValue = CGFloat(truncating: maxPrice!)
                self.minFilter = self.arrayDetails[0].salon_min_price!
                self.maxFilter = self.arrayDetails[0].salon_max_price!
                
                self.contryLbl.text = self.arrCountry[0].contry_Name!
                self.cityLbl.text = self.arrCity[0].cityName!
                self.resultLbl.text = "\(self.location[0].locName!)"
                self.searchResultCollectionView.reloadData()
                self.categoryColllectionView.reloadData()
                
                KRProgressHUD.dismiss()
            }else{
                KRProgressHUD.dismiss({ 
                    Utility.errorAlert(vc: self, strMessage: "\(message!)", errortitle: "")
                })
            }
            
        }
        
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        
        self.lblShowPrice.text! = "Price AED\(Int(minValue)) - AED\(Int(maxValue))"
        
        self.minFilter = "\(Int(minValue))"
        self.maxFilter = "\(Int(maxValue))"
        self.callFilter()
    }
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        self.ratingfilter = Int(rating)
        self.callFilter()
    }
    
    @IBAction func btnSellYourService(_ sender: UIButton) {
        
        if let getLogin = userDefaults.value(forKey: "pro_id") as? String{
            
            gotoServiceProvider()
            
        }else{
            createPopUp()
        }
    }
    
    @objc func createPopUp(){
        Utility.generateInfoPopUp(parentController: self, isPopView: true, parentVc: "FilterResultViewController", isLogin: false, isService: true )        
    }
    
    @objc func gotoServiceProvider(){
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //Filter
    
    func callFilter(){
        isFilterOn = true
        self.filterArray.removeAll()
        
        var rate = ""
        
        if ratingfilter == 0{
            rate = ""
        }else if ratingfilter == nil{
            rate = ""
        }else{
            rate = "\(ratingfilter!)"
        }
        

        
        let minPrice = self.arrayDetails[0].salon_min_price!
        let maxPrice = self.arrayDetails[0].salon_max_price!
        
        if minPrice == minFilter && maxPrice == maxFilter{
            minFilter = ""
            maxFilter = ""
        }
        
        if locationfilter == "All"{
            locationfilter = ""
        }
        
        if cityfilter == "All"{
            cityfilter = ""
        }

        print("Rating :\(rate)")
        print("minPrice :\(minFilter)")
        print("maxPrice :\(maxFilter)")
        print("city :\(cityfilter)")
        print("location :\(locationfilter)")
        print("ID:\(catServiceId)")

        if isSearchByName == true{
            isSearchByName = false
        }
        
        
        //filterObject = Filter
        filter(contry: contryfilter, city: cityfilter, location: locationfilter, rating: rate, min: minFilter, max: maxFilter)
    }
    
    func filter(contry:String?,city:String?,location:String?,rating:String?,min:String?,max:String?){
        //ServiceDetails

        for i in arrayDetails{
 
            if city != "" && location != "" && rating != "" && min != "" && max != "" && catServiceId != "" {
                
                let getRate = Int(rating!)
                
                if city == i.city! && location == i.user_location! && getRate == Int(i.rat_out_of_5!) && Int(min!)! <= Int(i.salon_min_price!)! && Int(max!)! >= Int(i.salon_max_price!)! {
                    
                    for j in i.salonSubCatServices{
                        
                        if catServiceId == j.ser_cs_ID!{
                            
                            self.filterArray.append(i)
                            
                        }
                        
                    }
                }
                
            }else if city == "" && location == "" && rating == "" && min == "" && max == "" && catServiceId == "" {
                self.isFilterOn = false
                
            }else if min != "" && max != "" && catServiceId != "" && rating != "" {
                let getRate = Int(rating!)
                
                    
                if Int(min!)! <= Int(i.salon_min_price!)! && Int(max!)! >= Int(i.salon_max_price!)! && getRate == Int(i.rat_out_of_5!) && location == i.user_location! {
                    
                    for j in i.salonSubCatServices{
                        
                        if j.ser_cs_ID! == catServiceId{
                            self.filterArray.append(i)
                        }
                    }
                    
                }
            }else if location != "" && rating  != "" && catServiceId != "" && min != "" && max != ""{
               let getRate = Int(rating!)
                
                if location == i.user_location! && getRate == Int(i.rat_out_of_5!) && Int(min!)! <= Int(i.salon_min_price!)! && Int(max!)! >= Int(i.salon_max_price!)!{
                    
                    for j in i.salonSubCatServices{
                        
                        if j.ser_cs_ID! == catServiceId{
                            self.filterArray.append(i)
                        }
                    }
                    
                }
            }else if rating  != "" && catServiceId != "" && min != "" && max != "" && city != ""{
                
                let getRate = Int(rating!)
                
                if getRate == Int(i.rat_out_of_5!) && Int(min!)! <= Int(i.salon_min_price!)! && Int(max!)! >= Int(i.salon_max_price!)! && city == i.city!{
                    
                    for j in i.salonSubCatServices{
                        
                        if j.ser_cs_ID! == catServiceId{
                            self.filterArray.append(i)
                        }
                    }
                }
  
            }else if catServiceId != "" && min != "" && max != "" && city != "" && location != ""{
                
                if Int(min!)! <= Int(i.salon_min_price!)! && Int(max!)! >= Int(i.salon_max_price!)! && city == i.city! && location == i.user_location!{
                    
                    for j in i.salonSubCatServices{
                        
                        if j.ser_cs_ID! == catServiceId{
                            self.filterArray.append(i)
                        }
                    }
                }
                
            }else if min != "" && max != "" && city != "" && location != ""{
                
                if Int(min!)! <= Int(i.salon_min_price!)! && Int(max!)! >= Int(i.salon_max_price!)! && city == i.city! && location == i.user_location! {
                    self.filterArray.append(i)
                    
                }
            }else if location != "" && rating != "" && catServiceId != ""{
                
                let getRate = Int(rating!)
                if getRate == Int(i.rat_out_of_5!) && location == i.user_location! {
                    for j in i.salonSubCatServices{
                        
                        if j.ser_cs_ID! == catServiceId{
                            self.filterArray.append(i)
                        }
                    }
                    
                }
                
            }else if catServiceId != "" && min != "" && max != "" && city != ""{
                
                if Int(min!)! <= Int(i.salon_min_price!)! && Int(max!)! >= Int(i.salon_max_price!)! && city == i.city! {
                    
                    for j in i.salonSubCatServices{
                        
                        if j.ser_cs_ID! == catServiceId{
                            self.filterArray.append(i)
                        }
                    }
                    
                }
                
            }else if min != "" && max != "" &&  city != "" && location != "" && rating  != ""{
                
                if Int(min!)! <= Int(i.salon_min_price!)! && Int(max!)! >= Int(i.salon_max_price!)! && city == i.city! && location == i.user_location!{
                    
                    let getRate = Int(rating!)
                    if getRate == Int(i.rat_out_of_5!) {
                        
                        self.filterArray.append(i)
                        
                    }
                    
                }
                
            }else if city != "" && location != "" && rating  != "" && catServiceId != ""{
                let getRate = Int(rating!)
                
                if city == i.city! && location == i.user_location! && getRate == Int(i.rat_out_of_5!){
                    for j in i.salonSubCatServices{
                        
                        if j.ser_cs_ID! == catServiceId{
                            self.filterArray.append(i)
                        }
                    }
                }
                
            }else if city != "" && location != "" && rating != ""{
                let getRate = Int(rating!)
                if city == i.city! && location == i.user_location! && getRate == Int(i.rat_out_of_5!) {
                    
                    self.filterArray.append(i)
                    
                }
                
            }else if city != "" && location != "" {
                if city == i.city! && location == i.user_location! {
                    
                    self.filterArray.append(i)
                    
                }
            }
            else if min != "" && max != "" && rating != ""{
                
                if Int(min!)! <= Int(i.salon_min_price!)! && Int(max!)! >= Int(i.salon_max_price!)!{
                    self.filterArray.append(i)
                }
                
            }else if min != "" && max != "" && city != ""{
                
                if Int(min!)! <= Int(i.salon_min_price!)! && Int(max!)! >= Int(i.salon_max_price!)!{
                    if city == i.city! {
                        
                        self.filterArray.append(i)
                        
                    }
                }
            }else if min != "" && max != "" && location != ""{
                if Int(min!)! <= Int(i.salon_min_price!)! && Int(max!)! >= Int(i.salon_max_price!)!{
                    if location == i.user_location! {
                        
                        self.filterArray.append(i)
                        
                    }
                }
            }else if rating != "" && city != ""{
                let getRate = Int(rating!)
                if getRate == Int(i.rat_out_of_5!) && city == i.city!  {
                    
                    self.filterArray.append(i)
                    
                }
            }else if rating != "" && location != ""{
                let getRate = Int(rating!)
                if getRate == Int(i.rat_out_of_5!) && location == i.user_location! {
                    
                    self.filterArray.append(i)
                    
                }
            }else if rating != "" && catServiceId != ""{
                let getRate = Int(rating!)
                if getRate == Int(i.rat_out_of_5!) {
                    
                    for j in i.salonSubCatServices{
                        
                        if j.ser_cs_ID! == catServiceId{
                            self.filterArray.append(i)
                        }
                    }
                }
            }else if city != "" && catServiceId != ""{
                if city == i.city! {
                    for j in i.salonSubCatServices{
                        
                        if j.ser_cs_ID! == catServiceId{
                            self.filterArray.append(i)
                        }
                    }
                }
            }
            else if min != "" && max != "" && catServiceId != ""{
                if Int(min!)! <= Int(i.salon_min_price!)! && Int(max!)! >= Int(i.salon_max_price!)!{
                    for j in i.salonSubCatServices{
                        
                        if j.ser_cs_ID! == catServiceId{
                            self.filterArray.append(i)
                        }
                    }
                }
            }
            else if city != ""{
                if city == i.city! {
                    
                    self.filterArray.append(i)
                    
                }
            }else if location != ""{
                if location == i.user_location! {
                    
                    self.filterArray.append(i)
                    
                }
            }else if rating != ""{
                let getRate = Int(rating!)
                if getRate == Int(i.rat_out_of_5!) {
                    
                    self.filterArray.append(i)
                    
                }
                
            }else if min != "" && max != ""{
                if Int(min!)! <= Int(i.salon_min_price!)! && Int(max!)! >= Int(i.salon_max_price!)!{
                    self.filterArray.append(i)
                }
            }else if catServiceId != ""{
                
                for j in i.salonSubCatServices{
                    
                    if j.ser_cs_ID! == catServiceId{
                        self.filterArray.append(i)
                    }
                }
                
            }
            
        }
    
        if self.filterArray.count == 0{
            self.lblSalonAlert.isHidden = false
        }else{
            self.lblSalonAlert.isHidden = true
        }
        
        print(self.filterArray.count)
        self.searchResultCollectionView.reloadData()

    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "detailResultSegue"{
            let obj = segue.destination as! ServiceViewController
            self.tabBarController?.tabBar.isHidden = false
            obj.salonID = getSelectedObj.id!
        }
        
    }
 

}

extension FilterResultViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == categoryColllectionView{
            return serviceArray.count
        }else {
            
            if isSearch == true {
                if isFilterOn == true{
                    return filterArray.count
                }
                else if isSearchByName == true{
                    return searchArray.count
                }else{
                    return arrayDetails.count
                }
                
            }else if isID == true{
                
                if isFilterOn == true{
                    return filterArray.count
                }else if isSearchByName == true{
                    return searchArray.count
                }else{
                    return arrayDetails.count
                }
                
            }
            
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        if collectionView == categoryColllectionView{
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCategoryCell", for: indexPath) as! SearchSectionCollectionViewCell
            
            cell.lblSearch.text! = serviceArray[indexPath.item].ser_cat_Name!
            
            if indexPath.item == 0{
                cell.backImage.image = #imageLiteral(resourceName: "btnSignin")
            }
            
            if serviceIndex != nil{
                
                if indexPath.item == serviceIndex {
                    cell.backImage.image = #imageLiteral(resourceName: "btnSignin")
                }else{
                    cell.backImage.image = nil
                }
                
            }
            
            //cell.lblSearch.sizeToFit()
            print(cell.lblSearch.intrinsicContentSize.width)
            //arraayOFWidth.append(cell.lblSearch.intrinsicContentSize.width)
            
             return cell
        }
            else {
            let secondCell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchResult", for: indexPath) as! SearchResultCollectionViewCell
            secondCell.ratingView.delegate = self
            //secondCell.ratingView.editable = true
            secondCell.ratingView.type = .floatRatings
            
            
            secondCell.backView.layer.cornerRadius = 5
            //secondCell.backView.layer.borderWidth = 1
            secondCell.backView.layer.borderColor = UIColor.lightGray.cgColor

            secondCell.layer.cornerRadius = 5
            secondCell.layer.shadowOpacity = 0.18
            secondCell.layer.shadowOffset = CGSize(width: 0, height: 2)
            secondCell.layer.shadowRadius = 2
            secondCell.layer.shadowColor = UIColor.black.cgColor
            secondCell.layer.masksToBounds = false
            secondCell.layer.cornerRadius = 8
            
            
            if isSearch == true{
                if isFilterOn == true {
                    let obj = filterArray[indexPath.item]
                    
                    secondCell.lblLocation.text! = "\(obj.user_location!)"
                    secondCell.lblReview.text! = "\(obj.total_review!) reviews"
                    secondCell.lblSaloonName.text! = "\(obj.business_name!)"
                    secondCell.lblPercentageHappyCustomer.text! = "\(obj.happy_performance!)% Happy Customers."
                    let ratingValue = Int(Double(obj.rat_out_of_5!)!)
                    secondCell.ratingView.rating = Double(ratingValue)
                    secondCell.strImage.sd_setImage(with: URL(string: obj.banner_name!), completed: nil)
                    
                }else if isSearchByName == true{
                    
                    let obj = searchArray[indexPath.item]
                    
                    secondCell.lblLocation.text! = "\(obj.user_location!)"
                    secondCell.lblReview.text! = "\(obj.total_review!) reviews"
                    secondCell.lblSaloonName.text! = "\(obj.business_name!)"
                    secondCell.lblPercentageHappyCustomer.text! = "\(obj.happy_performance!)% Happy Customers."
                    let ratingValue = Int(Double(obj.rat_out_of_5!)!)
                    secondCell.ratingView.rating = Double(ratingValue)
                    secondCell.strImage.sd_setImage(with: URL(string: obj.banner_name!), completed: nil)
                    //self.isSearchByName = false
                }else{
                    
                    let obj = arrayDetails[indexPath.item]
                    
                    secondCell.lblLocation.text! = "\(obj.user_location!)"
                    secondCell.lblReview.text! = "\(obj.total_review!) reviews"
                    secondCell.lblSaloonName.text! = "\(obj.business_name!)"
                    secondCell.lblPercentageHappyCustomer.text! = "\(obj.happy_performance!)% Happy Customers."
                    let ratingValue = Int(Double(obj.rat_out_of_5!)!)
                    secondCell.ratingView.rating = Double(ratingValue)
                    secondCell.strImage.sd_setImage(with: URL(string: obj.banner_name!), completed: nil)
                    //isFilterOn = false
                }
            }else if isID == true{
  
                    if isFilterOn == true{
                        
                        let obj = filterArray[indexPath.item]
                        
                        secondCell.lblLocation.text! = "\(obj.user_location!)"
                        secondCell.lblReview.text! = "\(obj.total_review!) reviews"
                        secondCell.lblSaloonName.text! = "\(obj.business_name!)"
                        secondCell.lblPercentageHappyCustomer.text! = "\(obj.happy_performance!)% Happy Customers."
                        let ratingValue = Int(Double(obj.rat_out_of_5!)!)
                        secondCell.ratingView.rating = Double(ratingValue)
                        secondCell.strImage.sd_setImage(with: URL(string: obj.banner_name!), completed: nil)
                    }else if isSearchByName == true{
                        let obj = searchArray[indexPath.item]
                        
                        secondCell.lblLocation.text! = "\(obj.user_location!)"
                        secondCell.lblReview.text! = "\(obj.total_review!) reviews"
                        secondCell.lblSaloonName.text! = "\(obj.business_name!)"
                        secondCell.lblPercentageHappyCustomer.text! = "\(obj.happy_performance!)% Happy Customers."
                        let ratingValue = Int(Double(obj.rat_out_of_5!)!)
                        secondCell.ratingView.rating = Double(ratingValue)
                        secondCell.strImage.sd_setImage(with: URL(string: obj.banner_name!), completed: nil)
                        //self.isSearchByName = false

                    }else{
                        let obj = arrayDetails[indexPath.item]
                        
                        secondCell.lblLocation.text! = "\(obj.user_location!)"
                        secondCell.lblReview.text! = "\(obj.total_review!) reviews"
                        secondCell.lblSaloonName.text! = "\(obj.business_name!)"
                        secondCell.lblPercentageHappyCustomer.text! = "\(obj.happy_performance!)% Happy Customers."
                        let ratingValue = Int(Double(obj.rat_out_of_5!)!)
                        secondCell.ratingView.rating = Double(ratingValue)
                        secondCell.strImage.sd_setImage(with: URL(string: obj.banner_name!), completed: nil)
                    }
                
            }
            
            
            return secondCell
        }
  
       return UICollectionViewCell()
    }
  
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView != categoryColllectionView{
            let obj = arrayDetails[indexPath.row]
            getSelectedObj = obj

            self.performSegue(withIdentifier: "detailResultSegue", sender: nil)
        }else{
            
            let selectedCarService = serviceArray[indexPath.item]
            serviceIndex = indexPath.item
            //self.catServiceId = ""
            
            if selectedCarService.ser_cat_ID! != ""{
                self.catServiceId = selectedCarService.ser_cat_ID!
            }else{
                self.catServiceId = ""
            }
            
            self.categoryColllectionView.reloadData()
            callFilter()
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     
        
        if collectionView == categoryColllectionView{
            
            let getValue = arraayOFWidth.last
            
            let Width = serviceArray[indexPath.item].ser_cat_Name!.daywidthlable(constraintedWidth: 0, font: UIFont(name: "Titillium-Regular", size: 17.0)!)
            let count = serviceArray.count

            return CGSize(width: Width + 25, height: collectionView.frame.size.height)
            
        }
            else {
            return CGSize(width: collectionView.frame.size.width, height: 156)
        }
        return CGSize()
    }
}


