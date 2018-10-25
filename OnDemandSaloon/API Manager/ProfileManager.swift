//
//  ProfileManager.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 17/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import Foundation
import Alamofire

final class ProfileManager{
    
    static let shared: ProfileManager = {
        let instance = ProfileManager()
        return instance
    }()
    
    
    ///////USER PROFILE////////
    
    //getProfile
    func profileApicall(parmas:[String:Any],completion:@escaping(Bool,String?,ProfileAdd) -> ()){
        
        print(parmas)
        APIManager.callApi(strApiName: addprofile, param: parmas) { (success, error,response) in
            
            
            switch response.result{
                
            case .success:
                var getdata = response.result.value as! [String:Any]
                let getStatus = getdata["status"] as! Int
                
                if getStatus == 1{
                    
                    if let getprofile = getdata["user_details"] as? [String:Any]{
                        
                        var profileOBJ:ProfileAdd!
                        
                        profileOBJ = ProfileAdd(dict: getprofile)
                        completion(true,"",profileOBJ)
                    }
                    else {
                        completion(false,"",ProfileAdd(dict: [:]))
                    }
                }
                else {
                    completion(false, "",ProfileAdd(dict: [:]))
                }
                
            case .failure( let error as Error?):
                
                completion(false,"\(error?.localizedDescription)",ProfileAdd(dict: [:]))
            }
            
        }
        
    }
    
    //editPrfile
    
    func editProfile(parmas:[String:Any],image:UIImage?,completion:@escaping(Bool) -> ()) {
        

        let getURl = "\(mainURL)\(updateProfile)"
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
                    
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 200 {
                            completion(true)
                        }
                        else {
                            completion(false)
                        }
                    }
                    else {
                        completion(false)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                completion(false)
            }
            
        }
        
    }
    
     ///////PROVIDER PROFILE////////
    
    func providerProfileApicall(parmas:[String:Any],completion:@escaping(Bool,String?,ProviderProfile) -> ()){
        
        print(parmas)
        APIManager.callApi(strApiName: addprofile, param: parmas) { (success, error,response) in
            
            print(response.result.value)
            switch response.result{
                
            case .success:
                var getdata = response.result.value as! [String:Any]
                let getStatus = getdata["status"] as! Int
                
                if getStatus == 1{
                    
                    if let getprofile = getdata["service_provider_details"] as? [String:Any]{
                        
                        var profileOBJ:ProviderProfile!
                        
                        profileOBJ = ProviderProfile(dict: getprofile)
                        completion(true,"",profileOBJ)
                    }
                    else {
                        completion(false,"",ProviderProfile(dict: [:]))
                    }
                }
                else {
                    completion(false, "",ProviderProfile(dict: [:]))
                }
                
            case .failure( let error as Error?):
                
                completion(false,"\(error?.localizedDescription)",ProviderProfile(dict: [:]))
            }
            
        }
        
    }
    
    
}
