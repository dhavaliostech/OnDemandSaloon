//
//  ProviderManager.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 14/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

final class ProviderManager {
    
    static let shared: ProviderManager = {
        let instance = ProviderManager()
        return instance
    }()

    //Client
    func clientListApi(parmas:[String:Any],completion:@escaping (Bool,[ClientLisiting],String?)->()){
    
        APIManager.callApi(strApiName: clientList, param: parmas) { (success, error, response) in
            
            //print(response.result.value!)
     
            switch response.result{
  
            case .success:
                
                var getdata = response.result.value as! [String:Any]
                let getStatus = getdata["status"] as? Int
                if getStatus == 1{
                    
                    if let getList = getdata["client_detail"] as? [[String:Any]] {
                        
                        var arrayListOfClient : [ClientLisiting] = []
                        
                        for item in getList{
                            arrayListOfClient.append(ClientLisiting(dict: item))
                        }
                        completion(true,arrayListOfClient,"\(getdata["msg"] ?? "")")
                    }else{
                        completion(false,[],"\(getdata["msg"] ?? "")")
                    }
                }else{
                    completion(false,[],"\(getdata["msg"] ?? "")")
                }
                
               
                
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,[],"\(error?.localizedDescription)")
            }
            
        }
    }
    
    func addOREditClient(parmas:[String:Any],image:UIImage?,api:String?,completion:@escaping (Bool,String?)->()){
        
        let getURl = "\(mainURL)\(api!)"
        print(getURl)
        var urlRequest = URLRequest(url: URL(string:getURl)!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = [
            "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
            "cache-control": "no-cache",
            "postman-token": "0efe488c-cde6-1de1-418a-5f8799e35186"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if image != nil{
                if let imageData = UIImageJPEGRepresentation(image!, 0.5)  {
                    multipartFormData.append(imageData, withName: "client_image", fileName: "img\(Date().timeIntervalSince1970).png", mimeType: "image/png")
                }
            }
            
            
            if parmas.isEmpty != true{
                for (key, value) in parmas {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
            
            
        }, with: urlRequest) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                
                
                upload.responseJSON { response in
                    
                    print(response.response?.statusCode ?? 0)
                    
                    let getData = response.result.value as! [String:Any]
                    
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 200 {
                            completion(true, "\(getData["msg"] ?? "")")
                        }
                        else {
                            completion(false,"\(getData["msg"] ?? "")")
                        }
                    }
                    else {
                        completion(false,"\(getData["msg"] ?? "")")
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                completion(false,"\(encodingError.localizedDescription)")
            }
            
        }
        
    }
    

    
    //Appointment
    func listOfAppointment(parmas:[String:Any],completion:@escaping (Bool,[ProviderAppointmentList])->()){
        
        APIManager.callApi(strApiName: listOfProviderAppointment, param: parmas) { (success, error, response) in
            
            print(response.result.value)
            
            switch response.result{
                
            case .success:
                
                var getdata = response.result.value as! [String:Any]
                let getStatus = getdata["status"] as? Int
                if getStatus == 1{
                    
                    if let getList = getdata["appoinment_data"] as? [[String:Any]] {
                        
                        var listAppointmentArray  :[ProviderAppointmentList] = []

                        
                        for item in getList{
                            listAppointmentArray.append(ProviderAppointmentList(dict: item))
                        }
                        
                        completion(true,listAppointmentArray)
                    }else{
                        completion(false,[])
                    }
                }else{
                    completion(false,[])
                }
                
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,[])
            }
        }
        
    }
    
    func userAppointmentDetails(parmas:[String:Any],completion:@escaping (Bool,[ProviderAppointmentList],String?)->()){
        
        APIManager.callApi(strApiName: detailsOfAppointment, param: parmas) { (success, error, response) in
            
            //print(response.result.value)
            
            switch response.result{
                
            case .success:
                
                var getdata = response.result.value as! [String:Any]
                let getStatus = getdata["status"] as! String
                if getStatus == "1"{
                    
                    if let getList = getdata["appoinment_details_by_user"] as? [[String:Any]] {
                        
                        var getUsereDetails  :[ProviderAppointmentList] = []
                        
                        for i in getList{
                              getUsereDetails.append(ProviderAppointmentList(dict: i))
                        }

                        completion(true,getUsereDetails,"\(getdata["msg"] as! String)")
                    }else{
                        completion(false,[],"\(getdata["msg"] as! String)")
                    }
                }else{
                    completion(false,[],"\(getdata["msg"] as! String)")
                }
                
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,[],"\(error?.localizedDescription)")
            }
        }
        
    }
    
    //Employee API
    func employeeListAPI(parmas:[String:Any],completion:@escaping (Bool,[EmployeeList],String?)->()){
        
        APIManager.callApi(strApiName: employeeList, param: parmas) { (success, error, response) in
            
            print(response.result.value)
            
            switch response.result{
                
            case .success:
                
                var getdata = response.result.value as! [String:Any]
                let getStatus = getdata["status"] as! Int
                if getStatus == 1{
                    
                    if let getList = getdata["employees_list"] as? [[String:Any]] {
                        
                        var getUsereDetails  :[EmployeeList] = []
                        
                        for i in getList{
                            getUsereDetails.append(EmployeeList(dict: i))
                        }
                        
                        completion(true,getUsereDetails,"\(getdata["msg"] as! String)")
                    }else{
                        completion(false,[],"\(getdata["msg"] as! String)")
                    }
                }else{
                    completion(false,[],"\(getdata["msg"] as! String)")
                }
                
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,[],"\(error?.localizedDescription)")
            }
            
        }
        
    }
    
    func addOrEditEmployeeAPI(parmas:[String:Any],image:UIImage?,api:String?,completion:@escaping (Bool,String?)->()){
        
        let getURl = "\(mainURL)\(api!)"
        print(getURl)
        var urlRequest = URLRequest(url: URL(string:getURl)!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = [
            "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
            "cache-control": "no-cache",
            "postman-token": "0efe488c-cde6-1de1-418a-5f8799e35186"
        ]

        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if image != nil{
                if let imageData = UIImageJPEGRepresentation(image!, 0.5)  {
                    multipartFormData.append(imageData, withName: "em_img", fileName: "img\(Date().timeIntervalSince1970).png", mimeType: "image/png")
                }
            }
            
            
            if parmas.isEmpty != true{

                for (key, value) in parmas {
                    if let tagsArray = value as? [[String:Any]]{
                        print("\(tagsArray)")
                        
                        let data = try? JSONSerialization.data(withJSONObject: tagsArray, options: [])
                        let jsonstring = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        
                        let myText:String = "\""
                        print("the result " + (myText as String))
                        let str:String = (myText as String) + "\(jsonstring!)" + (myText as String)
                        multipartFormData.append(str.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
  
                    }else {
                        multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                    }

                }
            }
            
            
        }, with: urlRequest) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                
                
                upload.responseJSON { response in
                    
                    print(response.response?.statusCode ?? 0)
                    
                    let getData = response.result.value as! [String:Any]
                    
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 200 {
                            completion(true, "\(getData["msg"] ?? "")")
                        }
                        else {
                            completion(false,"\(getData["msg"] ?? "")")
                        }
                    }
                    else {
                        completion(false,"\(getData["msg"] ?? "")")
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                completion(false,"\(encodingError.localizedDescription)")
            }
            
        }
        
    }
    
    func addEmployee(parmas:[String:Any],completion:@escaping (Bool,EmployeeList,String?)->()){
        
        APIManager.callApi(strApiName: employeeList, param: parmas) { (success, error, response) in
            
            print(response.result.value)
            
            switch response.result{
                
            case .success:
                
                var getdata = response.result.value as! [String:Any]
                let getStatus = getdata["status"] as! Int
                if getStatus == 1{
                    
                    if let getList = getdata["Employee_details"] as? [String:Any] {
                        
                        var getEmployeeDetails  :EmployeeList!
                        
                        getEmployeeDetails = EmployeeList(dict: getList)
                        
                        completion(true,getEmployeeDetails,"\(getdata["msg"] as! String)")
                    }else{
                        completion(false,EmployeeList(dict: [:]),"\(getdata["msg"] as! String)")
                    }
                }else{
                    completion(false,EmployeeList(dict: [:]),"\(getdata["msg"] as! String)")
                }
                
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,EmployeeList(dict: [:]),"\(error?.localizedDescription)")
            }
            
        }
    }
    
    //editEmployee
    func editEmpoyeeAPI(params:[String:Any],completion:@escaping (Bool,EmployeeList,String?)->()){
        APIManager.callApi(strApiName: editEmployee, param: params) { (success, error, response) in
            
            print(response.result.value)
            
            
            switch response.result{
                
            case .success:
                
                var getdata = response.result.value as! [String:Any]
                let getStatus = getdata["status"] as! Int
                if getStatus == 1{
                    
                    if let getList = getdata["Employee_details"] as? [String:Any] {
                        
                        var getEmployeeDetails  :EmployeeList!
                        
                        getEmployeeDetails = EmployeeList(dict: getList)
                        
                        completion(true,getEmployeeDetails,"\(getdata["msg"] as! String)")
                    }else{
                        completion(false,EmployeeList(dict: [:]),"\(getdata["msg"] as! String)")
                    }
                }else{
                    completion(false,EmployeeList(dict: [:]),"\(getdata["msg"] as! String)")
                }
                
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,EmployeeList(dict: [:]),"\(error?.localizedDescription)")
            }
            
        }
    }
    
    func blockEmployeeAPI(params:[String:Any],completion:@escaping (Bool,String?)->()){
        
        APIManager.callApi(strApiName: blockEmployee, param: params) { (success, error, response) in
            
            print(response.result.value)
            
            switch response.result{
                
            case .success:
                
                let getdata = response.result.value as! [String:Any]
                let getstatus = "\(getdata["status"] ?? "")"
                
                if getstatus == "1"{
                    
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
    
    func getBannerImageBasedOnProId(params:[String:Any],completion:@escaping (Bool,[BannerImage],String?)->()){

        APIManager.callApi(strApiName: bannerImagesGET, param: params) { (success, message, reponse) in
            
            print(reponse.result.value)
            
            switch reponse.result{
                
            case .success:
                
                var images:[BannerImage] = []
                
                var getdata = reponse.result.value as? [String:Any]
                var status = ""
                if let getStatus = getdata!["status"] as? String{
                    status = getStatus
                }else{
                    status = "\(getdata!["status"] as? Int)"
                }
                if status == "1"{
                    
                    if let getList = getdata!["banner_images"] as? [[String:Any]] {
                        
                        for i in getList{
                            images.append(BannerImage(dict: i))
                        }
                        completion(true,images,"\(getdata!["msg"] as! String)")
                    }else{
                        completion(false,[],"\(getdata!["msg"] as! String)")
                    }
                }else{
                    completion(false,[],"\(getdata!["msg"] as! String)")
                }
                
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,[],"\(error?.localizedDescription)")
            }
            
        }
        
       
    }
    
    
    func deleteBannerAPI(params:[String:Any],completion:@escaping (Bool,String?)->()){
        
        APIManager.callApi(strApiName: deleteBannerImage, param: params) { (success, error, response) in
            var getData = response.result.value as! [String:Any]
            switch response.result{
 
            case .success:
                
                let status = getData["status"] as! Int
                
                if status == 1{
                     completion(true,"\(getData["msg"] ?? "")")
                }else{
                    completion(true,"\(getData["msg"] ?? "")")
                }
   
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(true,"\(getData["msg"] ?? "")")
            }
        }
    }
    
    func addBannerImaeAPI(parmas:[String:Any],image:UIImage?,api:String?,completion:@escaping (Bool,String?)->()){
        
        let getURl = "\(mainURL)\(addbannerImage)"
        print(getURl)
        var urlRequest = URLRequest(url: URL(string:getURl)!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = [
            "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
            "cache-control": "no-cache",
            "postman-token": "0efe488c-cde6-1de1-418a-5f8799e35186"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if image != nil{
                if let imageData = UIImageJPEGRepresentation(image!, 0.5)  {
                    multipartFormData.append(imageData, withName: "banner_images", fileName: "img\(Date().timeIntervalSince1970).png", mimeType: "image/png")
                }
            }
            
            
            if parmas.isEmpty != true{
                for (key, value) in parmas {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
            
            
        }, with: urlRequest) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                
                
                upload.responseJSON { response in
                    
                    print(response.response?.statusCode ?? 0)
                    
                    let getData = response.result.value as! [String:Any]
                    
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 200 {
                            completion(true, "\(getData["msg"] ?? "")")
                        }
                        else {
                            completion(false,"\(getData["msg"] ?? "")")
                        }
                    }
                    else {
                        completion(false,"\(getData["msg"] ?? "")")
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                completion(false,"\(encodingError.localizedDescription)")
            }
            
        }
        
    }

        

    
    func dashBoardAPIa(params:[String:Any],completion:@escaping (Bool,DashBoard,String?)->()){
        APIManager.callApi(strApiName: dashBoard, param: params) { (success, error, response) in
            
            print(response.result.value)
            
            
            switch response.result{
                
            case .success:
                
                var getdata = response.result.value as! [String:Any]
                let getStatus = getdata["status"] as! String
                if getStatus == "1"{
                    
                    if let getList = getdata["my_dashboard"] as? [String:Any] {
                        
                        var getEmployeeDetails  :DashBoard!
                        
                        getEmployeeDetails = DashBoard(dict: getList)
                        
                        completion(true,getEmployeeDetails,"\(getdata["msg"] as! String)")
                    }else{
                        completion(false,DashBoard(dict: [:]),"\(getdata["msg"] as! String)")
                    }
                }else{
                    completion(false,DashBoard(dict: [:]),"\(getdata["msg"] as! String)")
                }
                
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,DashBoard(dict: [:]),"\(error?.localizedDescription)")
            }
            
        }
    }
    
    
    func editProfileAPI(parmas:[String:Any],image:UIImage?,completion:@escaping (Bool,String?)->()){
        
        let getURl = "\(mainURL)\(editProfileProvide)"
        print(getURl)
        var urlRequest = URLRequest(url: URL(string:getURl)!)
        urlRequest.httpMethod = "POST"
        urlRequest.allHTTPHeaderFields = [
            "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
            "cache-control": "no-cache",
            "postman-token": "0efe488c-cde6-1de1-418a-5f8799e35186"
        ]

        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            if image != nil{
                if let imageData = UIImageJPEGRepresentation(image!, 0.5)  {
                    multipartFormData.append(imageData, withName: "user_avatar", fileName: "img\(Date().timeIntervalSince1970).png", mimeType: "image/png")
                }
            }
            
            
            if parmas.isEmpty != true{
                for (key, value) in parmas {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
            
            
        }, with: urlRequest) { (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                
                
                upload.responseJSON { response in
                    
                    print(response.response?.statusCode ?? 0)
                    
                    print(response.result.value)
                    let getData = response.result.value as! [String:Any]
                    
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 200 {
                            completion(true, "\(getData["msg"] ?? "")")
                        }
                        else {
                            completion(false,"\(getData["msg"] ?? "")")
                        }
                    }
                    else {
                        completion(false,"\(getData["msg"] ?? "")")
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                completion(false,"\(encodingError.localizedDescription)")
            }
            
        }
        
    }

    func providerRatingList(parmas:[String:Any],completion:@escaping (Bool,String?,[ProviderRateAndReviewList])->()){
        
        APIManager.callApi(strApiName: providerRateAndReview, param: parmas) { (success, error, response) in
            
            print(response.result.value)
            switch (response.result){
            case .success:
                
                var arraydata :[ProviderRateAndReviewList] = []
                
                let getData = response.result.value as! [String:Any]
                
                let status = "\(getData["status"] ?? "")"
                
                if status == "1"{
                    
                    if let data = getData["service_provider_review_list"] as? [[String:Any]]{
                        
                        for i in data{
                            arraydata.append(ProviderRateAndReviewList(dict: i))
                        }
                        completion(true,"\(getData["msg"] ?? "")",arraydata)
                        
                    }else{
                        completion(false,"\(getData["msg"] ?? "")",[])
                    }
                    
                }else{
                    completion(false,"\(getData["msg"] ?? "")",[])
                }
                
            case .failure (let error as Error):
                print(error.localizedDescription)
                completion(false,"\(error.localizedDescription)",[])
            }
            
        }
        
    }
    
    func viewsOffersAPIcall(params:[String:Any],completion:@escaping (Bool,[ViewOffersData],String?)->()){
        
        APIManager.callApi(strApiName: viewOffers, param: params) { (success, error, response) in
            
            
            switch response.result{
                
            case .success:
                
                let getdata = response.result.value as! [String:Any]
                let getstatus = getdata["status"] as! Int
                
                if getstatus == 1{
                    
                    if let getlist = getdata["offers_data"] as? [[String:Any]]{
                        
                        var arrViewoffer:[ViewOffersData] = []
                        print(arrViewoffer)
                        
                        for i in getlist{
                            
                            arrViewoffer.append(ViewOffersData(dict: i))
                            print(arrViewoffer)
                        }
                        completion(true,arrViewoffer,"")
                    }
                    else {
                        completion(false,[],"")
                    }
                }
                else {
                    completion(false,[],"")
                }
                
            case .failure(let error as Error?):
                print(error?.localizedDescription)
            }
        }
        
    }
    
    //Add Offers Api Call
    func addOffersAPIcall(params:[String:Any],completion:@escaping (Bool,String?)->()){
        
        APIManager.callApi(strApiName: addOffers, param: params) { (success, error, response) in
            
            switch response.result{
                
            case .success:
                
                let getdata = response.result.value as! [String:Any]
                let getstatus = getdata["status"] as! Int
                
                if getstatus == 1{
                    
                    if let getlist = getdata["category_details"] as? [[String:Any]]{
                        
                        var arrOffers:[AddOffersData] = []
                        print(arrOffers)
                        
                        for i in getlist{
                            
                            arrOffers.append(AddOffersData(dict: i))
                            print(arrOffers)
                        }
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
    
    //Edit Offers Api Call
    
    func editOffersAPIcall(params:[String:Any],completion:@escaping (Bool,String?)->()){
        
        APIManager.callApi(strApiName: editOffers, param: params) { (success, error, response) in
            
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
    
    func appointmentApiCall(params:[String:Any],completion:@escaping (Bool,[AppointmentlistData],String?)->()){
        
        APIManager.callApi(strApiName: appoinmentlistURl, param: params) { (success, error, response) in
            
            
            print(response.result.value)
            
            switch response.result{
                
            case .success:
                
                let getdata = response.result.value as! [String:Any]
                let getstatus = "\(getdata["status"] ?? "")"
                
                if getstatus == "1"{
                    
                    if let getlist = getdata["my_appoinment_list"] as? [[String:Any]]{
                        
                        var arrappoinment:[AppointmentlistData] = []
                        print(arrappoinment)
                        
                        for i in getlist{
                            
                            arrappoinment.append(AppointmentlistData(dict: i))
                            print(arrappoinment)
                        }
                        completion(true,arrappoinment,"\(getdata["msg"] ?? "")")
                        
                    }else {
                        completion(false,[],"\(getdata["msg"] ?? "")")
                    }
                }
                else {
                    completion(false,[],"\(getdata["msg"] ?? "")")
                }
                
            case .failure(let error as Error?):
                print(error?.localizedDescription)
                completion(false,[],"\(error?.localizedDescription)")
            }
        }
    }
    
    func acceptRejectApiOfAppointment(params:[String:Any],completion:@escaping (Bool,String?)->()){
        
        APIManager.callApi(strApiName: appoinmentlistURl, param: params) { (success, error, response) in
 
            print(response.result.value)
            
            switch response.result{
                
            case .success:
                
                let getdata = response.result.value as! [String:Any]
                let getstatus = "\(getdata["status"] ?? "")"
                
                if getstatus == "1"{
                
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
    
    func changeAccountType(params:[String:Any],completion:@escaping (Bool,String?)->()){
        
        APIManager.callApi(strApiName: changeAccountServiceTyper, param: params) { (success, error, response) in
            
            print(response.result.value)
            
            switch response.result{
                
            case .success:
                
                let getdata = response.result.value as! [String:Any]
                let getstatus = "\(getdata["status"] ?? "")"
                
                if getstatus == "1"{
                    
                    if let data = getdata["user_details"] as? [String:Any]{
                        
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
                    
                        userDefaults.set(data["reg_service_type"] as! String, forKey: "reg_service_type")
                    }
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
    
    
}
