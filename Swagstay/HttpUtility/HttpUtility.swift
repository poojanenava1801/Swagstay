

import Foundation
import Alamofire
import SwiftyJSON
import Toaster
// makes http calls

struct HttpUtility {
    private init() {}
    static let shared: HttpUtility = HttpUtility()
    func getApiData(requestUrl: String,param:[String:Any],showLoading:Bool = true, completionHandler:@escaping(_ result: JSON)-> Void)
    {
        if NetworkManager.shared.isNetworkConnected == true
        {
            let headers = getDefaultHeaders()
            print(headers)
            print(requestUrl)
            print(param)
            if showLoading
            {
                showHud()
            }
            let param = param
            AF.request(requestUrl,method: .get, parameters: param,headers: headers).validate(statusCode: 200..<300).responseData{ (response) in
                hideHud()
                switch response.result {
                case .success:
                    guard let result = response.value else {
                        print(response.error.debugDescription)
                        return
                        
                    }
                    let json = JSON(result)
                    completionHandler(json)
                case .failure(let error):
                    print(error)
                   //Toast(text: error.localizedDescription).show()
                    
//                    let json = JSON(response.response?.statusCode ?? 0)
//                    completionHandler(json)
                    
                }
            }
        }else{
            Toast(text:"Network unavailable").show()
           
        }
    }
    func post(requestUrl: String,param:[String:Any],showLoading:Bool = true,completionHandler:@escaping(_ result: JSON)-> Void)
    {
        
        if NetworkManager.shared.isNetworkConnected == true{
            //let headers = getDefaultHeaders()
            //print(headers)
            print(requestUrl)
            print(param)
            if showLoading
            {
                showHud()
            }
            let param = param
            AF.request(requestUrl,method: .post, parameters: param).responseData{ (response) in
                hideHud()
                switch response.result {
                case .success:
                    guard let result = response.value else {
                        print(response.error.debugDescription)
                        return
                    }
                    if (200...300).contains(response.response?.statusCode ?? 0) {
//                        do{
//                            let js = try JSONSerialization.jsonObject(with: result)
                            let json = JSON(result)
                            completionHandler(json)
//                        }catch{
//                           print("post getting error on response")
//                        }
                       
                    }else{
                        let json = JSON(result)
                        showBanner(message: json["message"].stringValue,duration:4)
                    }
                case .failure(let error):
                    print(error)
                    
                    if let error = response.error{
                        
                        if case .responseValidationFailed(.unacceptableStatusCode(let code)) = error {
                            print(code)
                        }
                        Toast(text: error.localizedDescription).show()
                        
                        //                   if case .responseValidationFailed(.customValidationFailed(error: error)) = error {
                        //                       print(code)
                        //                   }
                    }
                }
            }
        }else{
            Toast(text: "Network unavailable").show()
           
        }
    }
    
    
    func postPrivacy(requestUrl: String,param:[String:Any],showLoading:Bool = true,completionHandler:@escaping(_ result: String)-> Void)
    {
        
        if NetworkManager.shared.isNetworkConnected == true{
            //let headers = getDefaultHeaders()
            //print(headers)
            print(requestUrl)
            print(param)
            if showLoading
            {
                showHud()
            }
            let param = param
            AF.request(requestUrl,method: .post, parameters: param).responseData{ (response) in
                hideHud()
                switch response.result {
                case .success:
                    guard let result = response.value else {
                        print(response.error.debugDescription)
                        return
                    }
                    if (200...300).contains(response.response?.statusCode ?? 0) {
//                        do{
//                            let js = try JSONSerialization.jsonObject(with: result)
                            let json = JSON(result)
                        let str = String(data: result, encoding: String.Encoding.utf8) as String?

                        
                        
                        completionHandler(str ?? "")
//                        }catch{
//                           print("post getting error on response")
//                        }
                       
                    }else{
                        let json = JSON(result)
                        showBanner(message: json["message"].stringValue,duration:4)
                    }
                case .failure(let error):
                    print(error)
                    
                    if let error = response.error{
                        
                        if case .responseValidationFailed(.unacceptableStatusCode(let code)) = error {
                            print(code)
                        }
                        Toast(text: error.localizedDescription).show()
                        
                        //                   if case .responseValidationFailed(.customValidationFailed(error: error)) = error {
                        //                       print(code)
                        //                   }
                    }
                }
            }
        }else{
            Toast(text: "Network unavailable").show()
           
        }
    }
    
    func postLoginStatus(requestUrl: String,param:[String:Any],showLoading:Bool = true,completionHandler:@escaping(_ result: JSON,_ status:Int)-> Void)
    {
        
        if NetworkManager.shared.isNetworkConnected == true{
            let headers = getDefaultHeaders()
            print(headers)
            print(requestUrl)
            print(param)
            if showLoading
            {
                showHud()
            }
            let param = param
            AF.request(requestUrl,method: .post, parameters: param,headers:headers).responseData{ (response) in
                hideHud()
                switch response.result {
                case .success:
                    guard let result = response.value else {
                        print(response.error.debugDescription)
                        return
                    }
                    if (200...300).contains(response.response?.statusCode ?? 0) {
                        let json = JSON(result)
                        //print(json)
                        completionHandler(json, response.response?.statusCode ?? 0)
                    }else{
                        let json = JSON(result)
                        completionHandler(json, response.response?.statusCode ?? 0)
                        showBanner(message: json["message"].stringValue,duration:4)
                    }
                case .failure(let error):
                    print(error)
                    
                    if let error = response.error{
                        
                        if case .responseValidationFailed(.unacceptableStatusCode(let code)) = error {
                            print(code)
                        }
                        Toast(text: error.localizedDescription).show()
                        
                        //                   if case .responseValidationFailed(.customValidationFailed(error: error)) = error {
                        //                       print(code)
                        //                   }
                    }
                }
            }
        }else{
            Toast(text: "Network unavailable").show()
           
        }
    }
    
    func getApiDataStatus(requestUrl: String,param:[String:Any],showLoading:Bool = true, completionHandler:@escaping(_ result: JSON,_ status:Int)-> Void)
    {
        if NetworkManager.shared.isNetworkConnected == true
        {
            let headers = getDefaultHeaders()
            print(headers)
            print(requestUrl)
            print(param)
            if showLoading
            {
                showHud()
            }
            let param = param
            AF.request(requestUrl,method: .get, parameters: param,headers: headers).validate(statusCode: 200..<300).responseData{ (response) in
                hideHud()
                switch response.result {
                case .success:
                    guard let result = response.value else {
                        print(response.error.debugDescription)
                        return
                        
                    }
                    let json = JSON(result)
                    completionHandler(json, response.response?.statusCode ?? 0)
                case .failure(let error):
                    print(error)
                   //Toast(text: error.localizedDescription).show()
                    let json = JSON()
                    completionHandler(json, response.response?.statusCode ?? 0)
                }
            }
        }else{
            Toast(text:"Network unavailable").show()
           
        }
    }
    
    func postPlaceBet(requestUrl: String,param:[String:Any],showLoading:Bool = true,completionHandler:@escaping(_ result: JSON,_ status:Bool)-> Void)
    {
        if NetworkManager.shared.isNetworkConnected == true
        {
            let headers = getDefaultHeaders()
            print(headers)
            print(requestUrl)
            print(param)
            if showLoading
            {
                showHud()
            }
            let param = param
            AF.request(requestUrl,method: .post, parameters: param,encoding: JSONEncoding.default,headers:headers).responseData{ (response) in
                hideHud()
                switch response.result {
                case .success:
                    guard let result = response.value else {
                        print(response.error.debugDescription)
                        return
                    }
                    if (200...300).contains(response.response?.statusCode ?? 0) {
                        let json = JSON(result)
                        //print(json)
                        if json["status"].boolValue == true{
                           // showBanner(message: "Picks Placed")
                            completionHandler(json, true)
                        }else{
                           // showBanner(message:json["message"].stringValue,duration: 5.0)
                            completionHandler(json, false)
                        }
                        //json["status"].boolValue
                        
                    }else{
                        let json = JSON(result)
                        showBanner(message: json["message"].stringValue)
                    }
                case .failure(let error):
                    print(error)
                    
                    if let error = response.error{
                        
                        if case .responseValidationFailed(.unacceptableStatusCode(let code)) = error {
                            print(code)
                        }
                        Toast(text: error.localizedDescription).show()
                        
                        //                   if case .responseValidationFailed(.customValidationFailed(error: error)) = error {
                        //                       print(code)
                        //                   }
                    }
                }
            }
        }else{
            Toast(text: "Network unavailable").show()
           
        }
    }
    func putApiData(requestUrl: String,param:[String:Any],completionHandler:@escaping(_ result: JSON)-> Void)
    {
        if NetworkManager.shared.isNetworkConnected == true
        {
            let headers = getDefaultHeaders()
            print(headers)
            print(requestUrl)
            print(param)
            showHud()
            let param = param
            AF.request(requestUrl,method: .put, parameters: param,headers:headers).responseData{ (response) in
                hideHud()
                switch response.result {
                case .success:
                    guard let result = response.value else {
                        print(response.error.debugDescription)
                        return
                    }
                    let json = JSON(result)
                    // print(json)
                    completionHandler(json)
                case .failure(let error):
                    print(error)
                    Toast(text: error.localizedDescription).show()
                }
            }
            
        }else{
            Toast(text: "Network unavailable").show()
           
        }
    }
    func postApiWithImageData(requestUrl: String, param: [String:Any],images:[ImageData], completionHandler:@escaping(_ result: JSON)-> Void)
    {
        if NetworkManager.shared.isNetworkConnected == true
        {
            let headers = getDefaultHeaders()
            print(headers)
            showHud()
            AF.upload(multipartFormData: { multiPart in
                for p in param {
                    multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
                }
                for image in images
                {
                    multiPart.append(image.data, withName: image.name, fileName: "\(image.name).jpg", mimeType: "image/jpg")
                }
            }, to: requestUrl, method: .post,headers: headers) .uploadProgress(queue: .main, closure: { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            }).responseData(completionHandler: { data in
                print("upload finished: \(data)")
            }).responseData { (response) in
                hideHud()
                switch response.result {
                case .success(let resut):
                    print("upload success result: \(resut)")
                    guard let result = response.value else {
                        print(response.error.debugDescription)
                        //   showAlert(message: response.error.debugDescription)
                        return
                    }
                    //print(result)
                    let json = JSON(result)
                    print(json)
                    completionHandler(json)
                case .failure(let error):
                    print(error)
               }
            }
        }else{
            Toast(text: "Network unavailable").show()
           
        }
       
    }
    
    func getDefaultHeaders() -> HTTPHeaders{
        let headers: HTTPHeaders = [
//            "xsrf": "",
//            "Authorization":""
        ]
        return headers
    }
}

struct ImageData {
    var name:String
    var data:Data
}
