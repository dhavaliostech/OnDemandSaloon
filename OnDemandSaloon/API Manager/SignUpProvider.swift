//
//  SignUpProvider.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 17/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import Foundation

class SignUpProvider {
    
    static let shared: SignUpProvider = {
        let instance = SignUpProvider()
        return instance
    }()
    
    func workingHoursPost(parmas:[String:Any],completion:@escaping(Bool,String?) -> ()){
        
        APIManager.callApi(strApiName: workingHourPost, param: parmas) { (success, error, response) in
            
            print(response.result.value)
            
            switch response.result{
                
            case .success:
                
                let getdata =  response.result.value  as! [String:Any]
                let getstatus = getdata["status"]  as! Int
                
                if getstatus == 1{
                    
                    if let getlist = getdata["opening_hour_list"] as? [[String:Any]]{
                        
                        
                        completion(true,"\(getdata["msg"] ?? "")")
                    }
                    else {
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
        
        //workingHourPost
    }
    
    func getProviderCat(parmas:[String:Any],completion:@escaping(Bool,String?,[ProviderCat],[SelectedCat]) -> ()){
        
        APIManager.getCallApi(strApiName: listCatOFProvider, param: parmas) { (success, error, response) in
            
            print(response.result.value)
            switch response.result{
                
            case .success:
                
                let getdata =  response.result.value  as! [String:Any]
                let getstatus = getdata["status"]  as! Int
                
                if getstatus == 1{
                    
                    if let getlist = getdata["category_list"] as? [[String:Any]]{
                        
                        var  getCat:[ProviderCat] = []
                        var selectedCatArray :[SelectedCat] = []
                        print(getCat)
                        
                        for item in getlist{
                            
                            getCat.append(ProviderCat(dict: item))
                            print(getCat)
                        }
                        
                        if let selectedCat = getdata["my_selected_category"] as? [[String:Any]]{
                            
                            for i in selectedCat{
                                selectedCatArray.append(SelectedCat(dict: i))
                            }
                            
                        }
                        
                        completion(true,"",getCat,selectedCatArray)
                    }
                    else {
                        completion(false,"\(getdata["msg"] ?? "")",[],[])
                    }
                    
                }
                else {
                    completion(false,"\(getdata["msg"] ?? "")",[],[])
                }
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,"\(error?.localizedDescription)",[],[])
            }
            
        }
        
    }
    
    func postCategories(parmas:[String:Any],completion:@escaping(Bool,String?) -> ()){
        
        APIManager.callApi(strApiName: postCategory, param: parmas) { (success, error, response) in
            
           print(response.result.value)
            
            switch response.result{
                
            case .success:
                
                let getdata =  response.result.value  as! [String:Any]
                let getstatus = getdata["status"]  as! Int
                
                if getstatus == 1{
                    
                    if let getlist = getdata["category_list"] as? [[String:Any]]{
                        
                     
                        completion(true,"\(getdata["msg"] ?? "")")
                    }
                    else {
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
    
    func getServicesOfcat(parmas:[String:Any],completion:@escaping(Bool,String?,[ServiceListBasedOnMainCat]) -> ()){
        
        APIManager.callApi(strApiName: listOfServicesOfCat, param: parmas) { (success, error, response) in
            
            switch response.result{
                
            case .success:
                
                let getdata =  response.result.value  as! [String:Any]
                let getstatus = getdata["status"]  as! Int
                
                if getstatus == 1{
                    
                    if let getlist = getdata["catogory_services_list"] as? [[String:Any]]{
                        
                        var  arrOfservices:[ServiceListBasedOnMainCat] = []
                        print(arrOfservices)
                        
                        for item in getlist{
                            
                            arrOfservices.append(ServiceListBasedOnMainCat(dict: item))
                            print(arrOfservices)
                        }
                        completion(true,"\(getdata["msg"] ?? "")",arrOfservices)
                    }
                    else {
                        completion(false,"\(getdata["msg"] ?? "")",[])
                    }
                    
                }
                else {
                    completion(false,"\(getdata["msg"] ?? "")",[])
                }
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                
            }
            
        }
        
    }
    
    func postCatServiceAPI(parmas:[String:Any],completion:@escaping(Bool,String?) -> ()){
        
       
        APIManager.callApi(strApiName: postCatServices, param: parmas) { (success, message, response) in
            
            print(response.result.value)
            
            switch response.result{
                
            case .success:
                
                let getdata =  response.result.value  as! [String:Any]
                let getstatus = getdata["status"]  as! Int
                
                if getstatus == 1{
                    
                    if let getlist = getdata["category_service_list"] as? [[String:Any]]{
                        
                        
                        completion(true,"\(getdata["msg"] ?? "")")
                    }
                    else {
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
    
    func subscriptionPlanApicall(parmas:[String:Any],completion:@escaping(Bool,String?,[ListofSubscriptionPlan],[MySubScriptionPlan]) -> ()){
        
        APIManager.getCallApi(strApiName: listsubscriptionplan, param: parmas) { (success, error, response) in
            
            
            print(response.result.value)
            
            switch response.result{
                
            case .success:
                
                let getdata =  response.result.value  as! [String:Any]
                let getstatus = getdata["status"]  as! Int
                
                if getstatus == 1{
                    
                    if let getlist = getdata["subscription_plan_list"] as? [[String:Any]]{
                        
                        var  arrsubplan:[ListofSubscriptionPlan] = []
                        var getSP :[MySubScriptionPlan] = []
                        print(arrsubplan)
                        
                        for item in getlist{
                            
                            arrsubplan.append(ListofSubscriptionPlan(dict: item))
                            print(arrsubplan)
                        }
                        
                        if let getMySp = getdata["my_subscription_plan"] as? [[String:Any]]{
                            
                            for i in getMySp{
                                getSP.append(MySubScriptionPlan(dict: i))
                            }
                            
                        }
                        
                        completion(true,"\(getdata["msg"] ?? "")",arrsubplan,getSP)
                    }
                    else {
                        completion(false,"\(getdata["msg"] ?? "")",[],[])
                    }
                    
                }
                else {
                    completion(false,"\(getdata["msg"] ?? "")",[],[])
                }
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,"\(error?.localizedDescription)",[],[])
            }
            
        }
        
    }
    
    func subscriptionPlanPost(parmas:[String:Any],completion:@escaping(Bool,String?) -> ()){
        
        APIManager.callApi(strApiName: selectsubscriptionplan, param: parmas) { (success, error, response) in
            
            print(response.result.value)
            
            switch response.result{
                
            case .success:
                
                let getdata =  response.result.value  as! [String:Any]
                let getstatus = getdata["status"]  as! Int
                
                if getstatus == 1{
                    
                    if let getlist = getdata["subscription_plan"] as? [[String:Any]]{
                        
                        
                        completion(true,"\(getdata["msg"] ?? "")")
                    }
                    else {
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
    
    func addCategoryAPI(parmas:[String:Any],completion:@escaping(Bool,String?,AddCategory) -> ()){
        
        APIManager.callApi(strApiName: addCategory, param: parmas) { (success, error, response) in
            
            print(response.result.value)
            let obj :AddCategory!

            switch response.result{
                
            case .success:
                
                let getdata =  response.result.value  as! [String:Any]
                let getstatus = getdata["status"]  as! Int
                
                if getstatus == 1{
                    if let getlist = getdata["category_details"] as? [String:Any]{
                        
                        
                        obj = AddCategory(dict: getlist)
                        
                        completion(true,"\(getdata["msg"] ?? "")",obj)
                    }
                    else {
                        completion(false,"\(getdata["msg"] ?? "")",AddCategory(dict: [:]))
                    }
                    
                }
                else {
                    completion(false,"\(getdata["msg"] ?? "")",AddCategory(dict: [:]))
                }
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,"\(error?.localizedDescription)",AddCategory(dict: [:]))
            }
            
        }
        
    }
    
    func getListOfMainCatAPI(parmas:[String:Any],completion:@escaping(Bool,String?,[ListOfMainCategories]) -> ()){
            
            APIManager.callApi(strApiName: "list_of_categories_based_on_provider_id.php", param: parmas) { (success, error, response) in
                
                print(response.result.value)
                var obj :[ListOfMainCategories] = []
                
                switch response.result{
                    
                case .success:
                    
                    let getdata =  response.result.value  as! [String:Any]
                    let getstatus = getdata["status"]  as! Int
                    
                    if getstatus == 1{
                        if let getlist = getdata["service_data"] as? [[String:Any]]{
                            
                            for i in getlist{
                                obj.append(ListOfMainCategories(dict:  i))
                            }
 
                            completion(true,"\(getdata["msg"] ?? "")",obj)
                        }
                        else {
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
    
    func accountsSettings(parmas:[String:Any],completion:@escaping(Bool,String?,[AccountSettings]) -> ()){
        
        APIManager.getCallApi(strApiName: accountSetting, param: parmas) { (success, error, response) in
            
            print(response.result.value)
            var obj :[AccountSettings] = []
            
            switch response.result{
                
            case .success:
                
                let getdata =  response.result.value  as! [String:Any]
                let getstatus = getdata["status"]  as! Int
                
                if getstatus == 1{
                    
                    if let getlist = getdata["question_data"] as? [[String:Any]]{
                        
                        for i in getlist{
                            obj.append(AccountSettings(dict:  i))
                        }
                        
                        completion(true,"\(getdata["msg"] ?? "")",obj)
                    }
                    else {
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
    
    func accountsSettingsPostApi(parmas:[String:Any],completion:@escaping(Bool,String?) -> ()){
        
        APIManager.callApi(strApiName: accountsetingPost, param: parmas) { (suceess, error, response) in
            
            switch response.result{
                
            case .success:
                
                let getdata = response.result.value as! [String:Any]
                let getstatus = getdata["status"] as! Int
                
                if getstatus == 1{
                    
                    completion(true,"\(getdata["msg"] ?? "")")
                    
                }else {
                    completion(false,"")
                }
                
                
            case .failure(let error as Error?):
                print(error?.localizedDescription)
            }
        }
        
    }

    func addServiceOfCat(parmas:[String:Any],completion:@escaping(Bool,String?) -> ()){
        
        APIManager.callApi(strApiName: "add_category_services.php", param: parmas) { (success, errorResponse, response) in
            
            
            print(response.result.value)
            var obj :[ListOfMainCategories] = []
            
            switch response.result{
                
            case .success:
                
                let getdata =  response.result.value  as! [String:Any]
                let getstatus = getdata["status"]  as! Int
                
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
    
    func deletCatServices(parmas:[String:Any],completion:@escaping(Bool,String?) -> ()){
        
        APIManager.callApi(strApiName: deleteCatOfService, param: parmas) { (success, errorResponse, response) in
            
            switch response.result{
                
            case .success:
                
                let getdata =  response.result.value  as! [String:Any]
                let getstatus = getdata["status"]  as! Int
                
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
    //MyOpeningHours
    
    func myOpeningHours(parmas:[String:Any],completion:@escaping(Bool,String?,[MyOpeningHours]) -> ()){
        APIManager.callApi(strApiName: getMyHours, param: parmas) { (success, errorResponse, response) in
            
            switch response.result{
                
            case .success:
                
                let getdata =  response.result.value  as! [String:Any]
                let getstatus = getdata["status"]  as! Int
                
                var myHours :[MyOpeningHours] = []
                
                if getstatus == 1{
                    
                    if let obj = getdata["my_opening_hour_list"] as? [[String:Any]]{
                        
                        
                        for i in obj{
                            myHours.append(MyOpeningHours(dict: i))
                        }
                        completion(true,"\(getdata["msg"] ?? "")",myHours)
                    }
                    else {
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
    
    
}

