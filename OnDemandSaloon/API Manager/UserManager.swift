//
//  UserManager.swift
//  OnDemandSaloon
//
//  Created by Pratik Zankat on 31/05/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

final class UserManager {
    
    static let shared: UserManager = {
        let instance = UserManager()
        return instance
    }()
    
    func login(parametrs: [String: Any],
               completion:@escaping (Bool,String,[String:Any])->()) {
        let login = "login.php"
        APIManager.callApi(strApiName: login, param: parametrs, completionHandler: { (success, errorMessage, response) in
            
            switch(response.result) {
            case .success:
                let jsonObject = JSON(response.result.value!)
                let jsonData = (response.result.value) as? [String:Any]
                print(jsonObject)
                if let dict = jsonData
                {
                    if let status =  dict["status"] as? Int
                    {
                        print(status)
                        if status == 1
                        {
                            
                            
                            if let data = dict["user_details"] as? [String:Any]{
                                userDefaults.set(data["user_email"] as! String, forKey: "user_email")
                                
                                userDefaults.set(data["user_phone"] as! String, forKey: "user_phone")
                                userDefaults.set(data["role"] as! String, forKey: "role")
                                
                                userDefaults.set(data["latitude"] as! String, forKey: "latitude")
                                
                                userDefaults.set(data["id"] as! String, forKey: "user_id")
                                
                                
                                userDefaults.set(data["user_fname"] as! String, forKey: "userFirstName")
                                userDefaults.set(data["user_lname"], forKey: "userLastName")
                                userDefaults.set(data["longitude"] as! String, forKey: "longitude")
                                userDefaults.synchronize()
                                completion(true,"\(jsonData!["msg"] as! String)",data)

                            }
                            else if let data = dict["provider_details"] as? [String:Any] {
                                
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(data["user_email"] as! String, forKey: "pro_email")
                                
                                userDefaults.set(data["user_phone"] as! String, forKey: "pro_phone")
                                userDefaults.set(data["role"] as! String, forKey: "pro_role")
                                
                                
                                
                                userDefaults.set(data["id"] as! String, forKey: "pro_id")
                                
                                userDefaults.set(data["business_name"] as! String, forKey: "pro_buissnes_name")
                                
                                userDefaults.set(data["city"] as! String, forKey: "pro_city")
                                //business_full_address
                                userDefaults.set(data["business_full_address"] as! String, forKey: "business_full_address")
                                userDefaults.set(data["country"] as! String, forKey: "pro_country")
                                userDefaults.set(data["user_avatar"] as! String, forKey: "pro_avatar")
                                userDefaults.set(data["user_location"] as! String, forKey: "pro_location")
                                userDefaults.set(data["business_full_address"] as! String, forKey: "business_full_address")
                                userDefaults.set(data["service_pro_reg_status"] as! String, forKey: "service_pro_reg_status")
                                userDefaults.set(data["reg_service_type"] as! String, forKey: "reg_service_type")
                                userDefaults.synchronize()
                                completion(true,"\(jsonData!["msg"] as! String)",data)

                            }

                        }
                        else
                        {
                            completion(false,"\(jsonData!["msg"] as! String)",[:])
                        }
                       
                    }
                    else
                    {
                        completion(false,"\(jsonData!["msg"] as! String)",[:])
                    }
                    
                }
                else
                {
                    completion(false,"\(jsonData!["msg"] as! String)",[:])
                }

            case .failure(let error as Error?):
                print(error?.localizedDescription)
                //ProjectUtilities.errorAlert(strMsg: error.localizedDescription)
                completion(false,"\(error?.localizedDescription)",[:])
            }
        })
    }
    func register(parametrs: [String:   Any],
                  completion:@escaping (Bool,String?)->()) {
        
        let registration = "registration.php"
        APIManager.callApi(strApiName: registration, param: parametrs, completionHandler: { (success, errorMessage, response) in
            
            switch(response.result) {
            case .success:
                let jsonObject = JSON(response.result.value!)
                let jsonData = (response.result.value) as? [String:Any]
                print(jsonObject)
                if let dict = jsonData
                {
                    if let status = dict["status"] as? Int
                    {
                        if status == 1
                        {
                            
                            if let data = dict["user_details"] as? [String:Any] {
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(data["user_email"] as! String, forKey: "user_email")
                                
                                userDefaults.set(data["user_phone"] as! String, forKey: "user_phone")
                                userDefaults.set(data["role"] as! String, forKey: "role")
                                userDefaults.set(data["user_password"] as! String, forKey: "user_password")
                                
                                
                                userDefaults.set(data["id"] as! String, forKey: "user_id")
                                //                            userDefaults.set(data!["user_avatar"] as! String, forKey: "user_avatar")
                                //                            userDefaults.set(data!["category_service"] as! String, forKey: "category_service")
                                userDefaults.set(data["user_fname"] as! String, forKey: "userFirstName")
                                userDefaults.set(data["user_lname"] as! String, forKey: "userLastName")
                                userDefaults.synchronize()
                                
                            }
                            
                            else  if let data = dict["service_provide_details"] as? [String:Any] {
                                let userDefaults = UserDefaults.standard
                                userDefaults.set(data["user_email"] as! String, forKey: "pro_email")
                                
                                userDefaults.set(data["user_phone"] as! String, forKey: "pro_phone")
                                userDefaults.set(data["role"] as! String, forKey: "pro_role")
                                userDefaults.set(data["user_password"] as! String, forKey: "pro_password")
                                
                                
                                userDefaults.set(data["id"] as! String, forKey: "pro_id")
                                
                                userDefaults.set(data["business_name"] as! String, forKey: "pro_buissnes_name")
                                
                                userDefaults.set(data["city"] as! String, forKey: "pro_city")
                                //business_full_address
                                userDefaults.set(data["business_full_address"] as! String, forKey: "business_full_address")
                                userDefaults.set(data["country"] as! String, forKey: "pro_country")
                                userDefaults.set(data["user_avatar"] as! String, forKey: "pro_avatar")
                                userDefaults.set(data["user_location"] as! String, forKey: "pro_location")
                                userDefaults.set(data["reg_service_type"] as! String, forKey: "serviceType")
                                userDefaults.synchronize()
                            }

                            completion(true,"\(jsonData!["msg"] as! String)")
                            
                        }
                        else
                        {
                            completion(false,"\(jsonData!["msg"] as! String)")
                        }
                    }
                    else{
                        completion(false,"\(jsonData!["msg"] as! String)")
                    }
                }
                else
                {
                    completion(false,"\(jsonData!["msg"] as! String)")
                }

            case .failure(let error as Error):
                
                completion(false,"\(error.localizedDescription)")
            }
        })
    }
    
    func forgotPass(parametrs :[String: String],
        completion:@escaping (Bool,String?)->()){
        
        
        APIManager.callApi(strApiName: "forget_password.php", param: parametrs) { (success, erroeResponse, response) in
            
            print(response.result.value)
            
            switch(response.result) {
            case .success:
        
                let jsonObject = JSON(response.result.value!)
                
                let jsonData = (response.result.value) as? [String:Any]
                print(jsonData)
                
                let getStatus = jsonObject["status"] as? Int
                
                if getStatus == 1{
                    completion(true,"\(jsonObject["msg"] ?? "")")
                }else{
                    
                    completion(false,"\(jsonObject["msg"] ?? "")")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                //ProjectUtilities.errorAlert(strMsg: error.localizedDescription)
                completion(false,"\(error.localizedDescription)")
            }
        }
  
    }
    func changePass(parametrs :[String: Any],
                    completion:@escaping (Bool,String?)->()){
        
        
        APIManager.callApi(strApiName: "change_password.php", param: parametrs) { (success, erroeResponse, response) in
            
            switch(response.result) {
            case .success:
                
                let jsonObject = JSON(response.result.value!)
                
                let jsonData = (response.result.value) as? [String:Any]
                print(jsonData)
                
                let getStatus = jsonData!["status"] as! Int
                
                if getStatus == 1{
                    completion(true,"\(jsonData!["msg"] as! String)")
                }else{
                    
                    completion(false,"\(jsonData!["msg"] as! String)")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                //ProjectUtilities.errorAlert(strMsg: error.localizedDescription)
                completion(false,"\(error.localizedDescription)")
            }
        }
        
    }

    func userRateReview(param:[String:Any],completion:@escaping (Bool) ->()){
        //add_rating_user.php
        APIManager.callApi(strApiName: "add_rating_user.php", param: param) { (success, error, resopnse) in
            print(resopnse.result.value!)
            switch (resopnse.result) {
            case .success:
                
                completion(true)

            case .failure(let error as Error!):
                print(error.localizedDescription)
                completion(false)
            }
            
        }
        
    }
    
    //NearBy
    func getListOfNearBySalons(param: [String: Any],
                               completion:@escaping (Bool,[NearBy],String?)->()){
    
        APIManager.callApi(strApiName: nearBy, param: param) { (success, error, response) in
            
            print(response.result.value!)
            
            switch(response.result) {
            case .success:
                
                var getData :[NearBy] = []
                let responseData = response.result.value as! [String:Any]
                let getStatus = responseData["status"] as! Int
                
                if getStatus == 1 {
                    
                    if let getServiceData = responseData["near_by_detail"] as? [[String:Any]]{
                        
                        for i in getServiceData{
                            getData.append(NearBy(dictionary: i))
                        }
                       completion(true,getData,"")
                    }else{
                        completion(false,[],"\(responseData["msg"] as! String)")
                    }
                    
                }else{
                    completion(false,[],"\(responseData["msg"] as! String)")
                }
    
                
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                //ProjectUtilities.errorAlert(strMsg: error.localizedDescription)
                completion(false,[],"\(error?.localizedDescription)")
            }
            
        }
        
    }
    
    //http://portfolio.maven-infotech.com/ondemandsaloon/forget_password.php
    func list_of_services(parametrs: [String: Any],
                          completion:@escaping ([ListOfMainCategories],Bool,String)->()) {
        let services = "list_of_categories.php"
        APIManager.getCallApi(strApiName: services, param: [:]) { (success, error, response) in
            
            switch(response.result) {
            case .success:
            
                var arrData:[ListOfMainCategories] = []
                let jsonObject = JSON(response.result.value!)
                
                let jsonData = (response.result.value) as? [String:Any]
                print(jsonData)
                
                let getStatus = jsonData!["status"] as! Int
                
                if getStatus == 1 {
                    
                    if let getServiceData = jsonData!["service_data"] as? [[String:Any]]{
                        
                        for i in getServiceData{
                            arrData.append(ListOfMainCategories(dict: i))
                        }
                        completion(arrData,true,"")
                    }else{
                        completion([],false,"\(jsonData!["msg"] as! String)")
                    }
                    
                }else{
                    completion([],false,"\(jsonData!["msg"] as! String)")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                //ProjectUtilities.errorAlert(strMsg: error.localizedDescription)
                completion([],false,"\(error.localizedDescription)")
            }
            
        }
    }
    
    func searchFilterAPI(param: [String: Any],
                      completion:@escaping (Bool,[SalonObj],String?)->()){
        
        APIManager.callApi(strApiName: searchFilter, param: param) { (success, error, response) in
            
            print(response.result.value)
            
            switch (response.result){

            case .success:
                
                let jsonData = (response.result.value) as? [String:Any]
                print(jsonData)
                
                var searchResultArray :[SalonObj] = []
                
                let getStatus = jsonData!["status"] as! Int
                
                if getStatus == 1 {
                    
                    if let getServiceData = jsonData!["search_data"] as? [[String:Any]]{
                        
                        for i in getServiceData{
                            searchResultArray.append(SalonObj(dict: i))
                        }
                        
                        completion(true,searchResultArray,"")

                    }else{
                        completion(false,[],"\(jsonData!["msg"] as! String)")
                    }
                    
                }else{
                    completion(false,[],"\(jsonData!["msg"] as! String)")
                    
                }
                
            case .failure(let error as Error!):
                print("This is the error: \(error.localizedDescription)")
                completion(false,[],"\(error.localizedDescription)")
            }
            
        }
        
    }
    
    func serviceProviderDetailByIdAPI(param: [String: Any],
                                      completion:@escaping (Bool,[String:Any],String?)->()){
        
        APIManager.callApi(strApiName: serviceProviderDetailById, param: param) { (success, error, response) in
            
            print(response.result.value)
            
            switch (response.result){
                
            case .success:
                
                
                completion(true,[:],"")
                
            case .failure(let error as Error!):
                completion(false,[:],"")

            }
        }
        
    }
    
    
    func reteAndReviewAPI(param: [String: Any],
                          completion:@escaping (Bool,[UserRateReviews],String?)->()){
        APIManager.getCallApi(strApiName: rateAndReviewOfAllUser, param: param) { (success, error, response) in
            
            print(response.result.value!)
            
            switch (response.result){
                
            case .success:
                var getData : [UserRateReviews] = []
                
                let responseData = (response.result.value!) as! [String:Any]
                let getStatus = responseData["status"] as! Int
                
                if getStatus == 1{
                    
                    if let getServiceData = responseData["review_list"] as? [[String:Any]]{
                        
                        for i in getServiceData{
                            getData.append(UserRateReviews(dict: i))
                        }
                        completion(true,getData,"")
                        
                    }else{
                        completion(false,[],"\(responseData["msg"] as! String)")
                    }
                    
                }else{
                    completion(false,[],"\(responseData["msg"] as! String)")
                    
                }
                
            case .failure(let error as Error?):
                
                print("\(error?.localizedDescription)")
                completion(false,[],"")
                
            }
        
        }
        
    }
    
    func ListIsBasedOnCatID(param: [String: Any],
                            completion:@escaping (Bool,FilterDetailsById,String?)->()){

        APIManager.callApi(strApiName: listOfCatDetails, param: param) { (success, error, response) in
            print(response.result.value!)
            switch (response.result){
                
            case .success:
                var getData : FilterDetailsById!
                
                let responseData = (response.result.value!) as! [String:Any]
                let getStatus = responseData["status"] as! Int
                
                if getStatus == 1{
                    
                    if responseData.isEmpty != true{
                        
                       getData = FilterDetailsById(dict: responseData)
                        completion(true,getData,"")
                        
                    }else{
                        completion(false,FilterDetailsById(dict: [:]),"\(responseData["msg"] as! String)")
                    }
                    
                }else{
                    completion(false,FilterDetailsById(dict: [:]),"\(responseData["msg"] as! String)")
                    
                }
                
            case .failure(let error as Error?):
                
                print("\(error?.localizedDescription)")
                completion(false,FilterDetailsById(dict: [:]),"\(error?.localizedDescription)")
                
            }
            
        }
        
    }
    
    func searchData(param: [String: Any],
                    completion:@escaping (Bool,FilterDetailsById,String?)->()){
        //allServiceDataBasedOnSearch
        
        APIManager.getCallApi(strApiName: allServiceDataBasedOnSearch, param: [:]) { (success, error, response) in
            
            print(response.result.value)
            
            switch (response.result){
                
            case .success:
                
                let getData = response.result.value as! [String:Any]
                
                let status = getData["status"] as! Int
                
                var getObj :FilterDetailsById!
                
                if status == 1{
                    
                    if getData.isEmpty != true{
                        
                        getObj = FilterDetailsById(dict: getData)
                        
                        completion(true,getObj,"")
                    }else{
                        completion(false,FilterDetailsById(dict: [:]),"\(getData["msg"] as! String)")
                    }
                    //                    completion(true,[:],"")
                }else{
                    completion(false,FilterDetailsById(dict: [:]),"\(getData["msg"] as! String)")
                }
                
            case.failure(let error as Error?):
                completion(false,FilterDetailsById(dict: [:]),"\(error?.localizedDescription)")
                
            }
            
        }
        
    }
    
    func getDataBasedOnSalonId(param: [String: Any],
                               completion:@escaping (Bool,SalonDetailsBasedOnId,String?)->()){
        
        APIManager.callApi(strApiName: serviceBasedOnShopID, param: param) { (success, error, response) in
            
            print(response.result.value)
            
            switch (response.result){
                
            case .success:
                
                let getData = response.result.value as! [String:Any]

                let status = getData["status"] as! Int
                
                var getObj :SalonDetailsBasedOnId!
                
                if status == 1{
                    
                    if getData.isEmpty != true{
                        
                        getObj = SalonDetailsBasedOnId(dict: getData)
                        
                        completion(true,getObj,"")
                    }else{
                        completion(false,SalonDetailsBasedOnId(dict: [:]),"\(getData["msg"] as! String)")
                    }
//                    completion(true,[:],"")
                }else{
                    completion(false,SalonDetailsBasedOnId(dict: [:]),"\(getData["msg"] as! String)")
                }
    
            case.failure(let error as Error?):
                completion(false,SalonDetailsBasedOnId(dict: [:]),"\(error?.localizedDescription)")
                
            }
            
        }
        
    }
    
    func todayOffersList(param: [String: Any],
                         completion:@escaping (Bool,[Today_Offer],String?)->()){
        
        APIManager.getCallApi(strApiName: todayOffer, param: [:]) { (success, error, response) in
            
            print(response.result.value)
            
            switch response.result {
            case .success:
   
                let getData = response.result.value as! [String:Any]
                
                let status = getData["status"] as! Int
                
                var todayOffer:[Today_Offer] = []

                if status == 1{
                    
                    if let offer = getData["offers_data"] as? [[String:Any]]{
                        
                        for i in offer {
                            
                            todayOffer.append(Today_Offer(dict: i))
                            
                        }
                        
                        completion(true,todayOffer,"")
                    }else{
                        completion(false,[],"\(getData["msg"] as! String)")
                    }
                }else{
                    completion(true,[],"\(getData["msg"] as! String)")
                }
  
            case .failure(let error as Error?):
                print("\(error?.localizedDescription)")
                completion(false,[],"\(error?.localizedDescription)")
            }
            
        }
        
    }
    
    func getSearchDataInSearchTab(param: [String: Any],
                                  completion:@escaping (Bool,GetSearchData,String?)->()){
        
        APIManager.getCallApi(strApiName: getSearchData, param: [:]) { (success, error, response) in
            
            print(response.result.value)
            
            switch (response.result){
                
            case .success:
                
                var mainDatForSearchSalon:GetSearchData!
                
                var jsonResponse = response.result.value as! [String:Any]
                
                 let status = jsonResponse["status"] as! Int
                
                if status == 1{
                    
                    if jsonResponse.isEmpty != true{
                        
                        mainDatForSearchSalon = GetSearchData(dict: jsonResponse)
                        
                        completion(true,mainDatForSearchSalon,"")
                    }else{
                        completion(false,GetSearchData(dict: [:]),"\(jsonResponse["msg"] as! String)")
                    }

                }else{
                    completion(false,GetSearchData(dict: [:]),"\(jsonResponse["msg"] as! String)")
                }
                
                //completion(true,[:],"")
                
            case .failure(let error as Error?):
                completion(false,GetSearchData(dict: [:]),"\(error?.localizedDescription)")
                
                
            }
            
        }
 
    }
    
    func viewPackages(param: [String: Any],
                      completion:@escaping (Bool,Packages,String?)->()){

        
        APIManager.getCallApi(strApiName: viewPackagesAPI, param: [:]) { (success, error, response) in
            
            print(response.result.value)
            
            switch (response.result){
                
            case .success:
                
                var packageArray:Packages!
                
                var jsonResponse = response.result.value as! [String:Any]
                
                let status = jsonResponse["status"] as! Int
                
                if status == 1{
                    
                    if let getdata = jsonResponse["Packages_data"] as? [String:Any]{
                        
                        packageArray = Packages(dict: getdata)
      
                        completion(true,packageArray,"")
                    }else{
                        completion(false,Packages(dict: [:]),"\(jsonResponse["msg"] as! String)")
                    }
                    
                }else{
                    completion(false,Packages(dict: [:]),"\(jsonResponse["msg"] as! String)")
                }
                
                //completion(true,[:],"")
                
            case .failure(let error as Error?):
                completion(false,Packages(dict: [:]),"")
     
            }
            
        }
    }
    
    
    func bookDatailsApiCall(parmas:[String:Any],completion:@escaping(Bool,String?,ListOFUpcommingAndPastAppointments) -> ()){
        
        APIManager.callApi(strApiName: listOfAppointmentByUser, param: parmas) { (success, error, response) in
            
            print(response.result.value)
            switch response.result{
            
            case .success:
                
                var arrupcoming:ListOFUpcommingAndPastAppointments!
                let getdata = response.result.value as! [String:Any]
                let getstatus = getdata["status"] as? Int
                
                if getstatus == 1{
                    
                    if getdata.isEmpty != true{
                        
                        arrupcoming = ListOFUpcommingAndPastAppointments(dict: getdata)
                        
                        completion(true,"",arrupcoming)
                    }
                    else {
                        completion(false,"",ListOFUpcommingAndPastAppointments(dict: [:]))
                    }
                }
                else {
                    completion(false,"",ListOFUpcommingAndPastAppointments(dict: [:]))
                }
                
            case .failure(let error as Error?):
                print(error?.localizedDescription)
            }
        }
        
    }
    
    func bookAppointMent(parmas:[String:Any],completion:@escaping(Bool,String?) -> ()){
        APIManager.callApi(strApiName: bookAppointment, param: parmas) { (success, error, response) in
            
            switch response.result{
                
            case .success:
                
                var arrupcoming:ListOFUpcommingAndPastAppointments!
                let getdata = response.result.value as! [String:Any]
                let getstatus = getdata["status"] as? Int
                
                if getstatus == 1{
                    
                    completion(true,"\(getdata["msg"] ?? "")")
                }
                else {
                    completion(false,"\(getdata["msg"] ?? "")")
                }
                
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,"\(error?.localizedDescription)")
            }
        }
    }
    
    func accountSettings(parmas:[String:Any],completion:@escaping(Bool,String?,[NotificationData],SelectedQuestionData) -> ()){
        
        APIManager.callApi(strApiName: getAccountSettings, param: parmas) { (success, error, response) in
            
            print(response.result.value)
            switch response.result{
                
            case .success:
                
                let getdata = response.result.value as! [String:Any]
                let getstatus = getdata["status"] as! Int
                
                if getstatus == 1{
                    
                    if let getlist = getdata["question_data"] as? [[String:Any]]{
                        
                        var arrAnswer:[NotificationData] = []
                        var selectedAnswers: SelectedQuestionData!
                        print(arrAnswer)
                        
                        for i in getlist{
                            arrAnswer.append(NotificationData(dict: i))
                            print(arrAnswer)
                        }
                        
                        if let geMyAnswers = getdata["my_selected_question_data"] as? [String:Any]{
                            selectedAnswers = SelectedQuestionData(dict: geMyAnswers)
                        }
                        
                        completion(true,"\(getdata["msg"] ?? "")",arrAnswer,selectedAnswers)
                    }
                    else {
                        completion(false,"\(getdata["msg"] ?? "")",[],SelectedQuestionData(dict: [:]))
                    }
                }
                else {
                    completion(false,"\(getdata["msg"] ?? "")",[],SelectedQuestionData(dict: [:]))
                }
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,"\(error?.localizedDescription)",[],SelectedQuestionData(dict: [:]))
            }
        }
        
        
    }
   
    func postAccountSettings(parmas:[String:Any],completion:@escaping(Bool,String?) -> ()){
        
        APIManager.callApi(strApiName: postAccountSetting, param: parmas) { (success, error, response) in
            
            switch response.result{
                
            case .success:
                
                let getdata = response.result.value as! [String:Any]
                let getstatus = getdata["status"] as! Int
                
                if getstatus == 1{
                    
                        completion(true,"\(getdata["msg"] ?? "")")
 
                }
                else {
                    completion(false,"\(getdata["msg"] ?? "")")
                }
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,"\(error?.localizedDescription)")
            }
        }
    }
    
    func getAllNotificationAPI(parmas:[String:Any],completion:@escaping(Bool,String?,[GetAllNotifications]) -> ()){
        //getUserAllNotifications
        
        APIManager.callApi(strApiName: getUserAllNotifications, param: parmas) { (success, error, response) in
            
            print(response.result.value)
            
            switch response.result{
                
            case .success:
                
                let getdata = response.result.value as! [String:Any]
                let getstatus = getdata["status"] as! Int
                var arrayNotifications :[GetAllNotifications] = []
                if getstatus == 1{
                    
                    if let details = getdata["notification_detail"] as? [[String:Any]]{
                        
                        for i in details{
                            arrayNotifications.append(GetAllNotifications(dict: i))
                        }
                        completion(true,"\(getdata["msg"] ?? "")",arrayNotifications)
                    }else {
                        completion(false,"\(getdata["msg"] ?? "")",[])
                    }  
                }
                else {
                    completion(false,"\(getdata["msg"] ?? "")",[])
                }
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,"\(error?.localizedDescription)",[])
            }
            
            
        }
    }
    
    func paymentAPI(parmas:[String:Any],completion:@escaping(Bool,String?) -> ()){
 
        APIManager.callApi(strApiName: paymentPAY, param: parmas) { (success, error, response) in
            
            print(response.result.value)
            
            switch response.result{
                
            case .success:
                
                let getdata = response.result.value as! [String:Any]
                let getstatus = getdata["status"] as! Int
                
                if getstatus == 1{
                    
                    if let transctionOBJ = getdata["result"] as? [String:Any]{
                        
                        if let getSuccess = transctionOBJ["success"] as? Bool{
                            
                            if getSuccess == true{
                                 completion(true,"\(getdata["msg"] ?? "")")
                            }else{
                                
                            }
                            
                        }else{
                            completion(false,"\(getdata["msg"] ?? "")")
                        }
                        
                    }else{
                        completion(false,"\(getdata["msg"] ?? "")")
                    }
                }
                else {
                    completion(false,"\(getdata["msg"] ?? "")")
                }
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,"\(error?.localizedDescription)")
            }
            
        }
        
    }
    
    
}




