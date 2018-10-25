//
//  APIManager.swift
//  Gymnastics


import Foundation
import Reachability
import SystemConfiguration
import Alamofire
import SwiftyJSON
import KRProgressHUD

typealias APICompletionHandler = (_ success:Bool, _ error:String?, _ response:DataResponse<Any>) -> Void

class APIManager {
    
    static var instance: APIManager!
    
    // SHARED INSTANCE
    class func sharedAPIManager() -> APIManager {
        self.instance = (self.instance ?? APIManager())
        return self.instance
    }
    
    struct Constants {
        //https://portfolio.maven-infotech.com/ondemandsaloon/
        static let BASEURL = "https://portfolio.maven-infotech.com/ondemandsaloon/"
        static let IMAGEURL = ""
        static let IMAGEUPLOADURL = ""
    }
    
    func isNetworkCheck() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    class func callApi(strApiName:String, param: [String:Any]?,completionHandler:@escaping APICompletionHandler) {
        
        print(APIManager.Constants.BASEURL+strApiName,"->",param!)
        
        let reachability = Reachability()
        if reachability?.connection.description != "No Connection" {
            let strAPI = APIManager.Constants.BASEURL+strApiName
            print("API : \(strAPI)")
            
           // let header :HTTPHeaders = ["cache-control":"no-cache","content-type":"application/json","postman-token":"9c4aef14-5e6e-b504-0e6c-3d0a7080f3d2"]
            //Json Request
            Alamofire.request(strAPI, method: HTTPMethod.post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (responseData) in

                completionHandler(false, nil, responseData)
            }
            
            
            //Form Data Request
//            Alamofire.request(strAPI, method: .post , parameters: param).responseJSON { (response) in
//
//                completionHandler(false, nil, response)
//            }
        }else{
            KRProgressHUD.dismiss {
                Utility.errorAlert(vc: (appDelegate.window?.rootViewController)!, strMessage: "Please check your internet connection.", errortitle: "Internet Connection")
            }
        
        }
    }
    class func callApiFirbase(strApiName:String, param: [String:Any]?,completionHandler:@escaping APICompletionHandler) {
        
        print(APIManager.Constants.BASEURL+strApiName,"->",param!)
        
        let reachability = Reachability()
        if reachability?.connection.description != "No Connection" {
            let strAPI = strApiName
            print("API : \(strAPI)")
            
            Alamofire.request(strAPI, method: .post , parameters: param).responseJSON { (response) in
                
                completionHandler(false, nil, response)
            }
        }else{
            //ProjectUtilities.errorAlert(strMsg:InternetMSG)
            //ProjectUtilities.loadingHide()
        }
    }
    class func getCallApi(strApiName:String, param: [String:Any]?,completionHandler:@escaping APICompletionHandler) {
        
        print(APIManager.Constants.BASEURL+strApiName,"->",param!)
        
        let reachability = Reachability()
        if reachability?.connection.description != "No Connection" {
            let strAPI = APIManager.Constants.BASEURL+strApiName
            print("API : \(strAPI)")
            
//             let header :HTTPHeaders = ["cache-control":"no-cache","content-type":"application/json","postman-token":"9c4aef14-5e6e-b504-0e6c-3d0a7080f3d2"]
//            //Json Request
//            Alamofire.request(strAPI, method: HTTPMethod.get, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON { (responseData) in
//                print(responseData.result.value)
//                completionHandler(false, nil, responseData)
//            }
            
            Alamofire.request(strAPI, method: .get , parameters: param).responseJSON { (response) in
                print(response.result.value)
                completionHandler(false, nil, response)

            }
        }else{
//            ProjectUtilities.errorAlert(strMsg:InternetMSG)
//            ProjectUtilities.loadingHide()
        }
    }
    
//    class func callApiWithData(strApiName:String, param: [String:String]?, data: Data?, name: String?, uploadType: String?, completionHandler:@escaping APICompletionHandler) {
//
//        print(APIManager.Constants.BASEURL+strApiName,"->",param!)
//
//        let reachability = Reachability()
//        if reachability?.connection.description != "No Connection" {
//
//            Alamofire.upload(multipartFormData: { (multipartFormData) in
//                if uploadType == "image" {
//                    multipartFormData.append(data!, withName: name!, fileName: ObjectiveCMethods.findUniqueSavePathImage(), mimeType: "image/jpg")
//                }else{
//                    multipartFormData.append(data!, withName: name!, fileName: ObjectiveCMethods.findUniqueSavePathVideo(), mimeType: "video/quicktime")
//                }
//
//                for (key, value) in param! {
//                    multipartFormData.append(value.data(using: .utf8)!, withName: key)
//                }
//            }, to: APIManager.Constants.BASEURL+strApiName,
//               encodingCompletion: { (result) in
//
//                switch result {
//                case .success(let upload, _, _):
//                    upload.uploadProgress(closure: { (progress) in
//                        print("Upload Progress: \(progress.fractionCompleted)")
//                    })
//                    upload.responseJSON { (response) in
//
//                        completionHandler(false, nil, response)
//                    }
//                case .failure(let encodingError):
//                    ProjectUtilities.errorAlert(strMsg:encodingError.localizedDescription)
//                    ProjectUtilities.loadingHide()
//                }
//            })
//        }else{
//            ProjectUtilities.errorAlert(strMsg:InternetMSG)
//            ProjectUtilities.loadingHide()
//        }
//    }
    
    class func callApiDefaultWithData(strApiName:String, param: [String:String]?, data: Data?, name: String?, uploadType: String?, completionHandler:@escaping APICompletionHandler) {
        
        let headers = [
            "content-type": "multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW",
            "cache-control": "no-cache",
            "postman-token": "2e10dec4-df5f-ea80-0f18-12d8fa2c6b78"
        ]
        let parameters = [
            [
                "name": "user_id",
                "value": "15"
            ],
            [
                "name": "track_file",
                "fileName": "\(String(describing: param!["fileName"]))"
            ],
            [
                "name": "description",
                "value": "This is image post"
            ],
            [
                "name": "location",
                "value": "Ahmedabad, Gujarat, India"
            ],
            [
                "name": "tags",
                "value": "track1,gener1,art"
            ]
        ]
        
        let boundary = "----WebKitFormBoundary7MA4YWxkTrZu0gW"
        
        var body = ""
        let error: NSError? = nil
        for param in parameters {
            let paramName = param["name"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(String(describing: paramName))\""
            if let filename = param["fileName"] {
                let contentType = headers["content-type"]!
                var fileContent = ""
                do {
                    fileContent = try String(contentsOfFile: filename, encoding: String.Encoding.utf8)
                    if (error != nil) {
                        print(error ?? "")
                    }
                    body += "; filename=\"\(String(describing: filename))\"\r\n"
                }catch{
                    
                }
                
                body += "Content-Type: \(String(describing: contentType))\r\n\r\n"
                body += fileContent
            } else if let paramValue = param["value"] {
                body += "\r\n\r\n\(String(describing: paramValue))"
            }
        }
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://45.79.169.241/idtrack/tracks/create")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = body.data(using: .utf8)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "")
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse ?? "")
            }
        })
        
        dataTask.resume()
    }
}


