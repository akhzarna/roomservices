//
//  NSRestApiHelper.swift
//  LynkedWorld
//
//  Created by Macbook on 01/11/17.
//  Copyright © 2017 Arusys. All rights reserved.
//

import UIKit
import Alamofire

// MARK:- Type alias defines
typealias CompletionHandler = (_ obj: AnyObject?, _ error: Error?) -> Void

class NSRestApiHelper: NSObject {

    override init () {
        super.init()
    }
    //Base url
    var baseURL: String = ""
    
    var baseURLRegister: String = ""
    
    //service URL property
    var serviceURL: String = String() {
        didSet {
            self.serviceURL = self.baseURL + serviceURL
        }
    }
    
    var serviceURLRegister: String = String() {
        didSet {
            self.serviceURLRegister = self.baseURLRegister + serviceURLRegister
        }
    }
    
    func getrequest(urlQuery: String,Headers headers: NSDictionary,CompletionHandler completion:@escaping CompletionHandler){
        serviceURL = urlQuery
        var request: URLRequest = self.getRequestUrlForPath(headers: headers)
        request.httpMethod = HTTPMethod.get.rawValue
        self.sendRequest(request: request, CompletionHandler: completion)
    }

    //MARK:- Post Request
    func postRequest(urlQuery: String, Body body: Data, Headers headers: NSDictionary, CompletionHandler completion:@escaping CompletionHandler) {
        serviceURL = urlQuery
        var request: URLRequest = self.getRequestUrlForPath(headers: headers)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = body
        self.sendRequest(request: request, CompletionHandler: completion)
    }
    
    func postRequestForRegister(urlQuery: String, Body body: Data, Headers headers: NSDictionary, CompletionHandler completion:@escaping CompletionHandler) {
        serviceURLRegister = urlQuery
        var request: URLRequest = self.getRequestUrlForPath(headers: headers)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = body
        self.sendRequest(request: request, CompletionHandler: completion)
    }
    
    
    
    func requestWithImageUpload(urlQuery: String, parameters param: [String: String] , Headers headers: NSDictionary, media mediaParam: [String: Data], CompletionHandler completion:@escaping CompletionHandler) {
        
        serviceURL = urlQuery
        var request: URLRequest = self.getRequestUrlForPath(headers: headers)
        request.httpMethod = HTTPMethod.post.rawValue
        //request.httpBody = body
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in mediaParam {
                multipartFormData.append(value, withName: key ,fileName: "\(key).jpg", mimeType: "image/jpg")
            }
            
            for (key, value) in param {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, with: request) { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    //print(response.result.value)
                    switch response.result {
                    case .success(_):
                        if response.result.value != nil {
                            print(response.result.value as Any)
                            completion(response.result.value! as AnyObject, nil)
                        }
                        break
                    case .failure(_):
                        completion(nil, response.result.error!)
                        break
                    }
                }
                
            case .failure(let encodingError):
                print(encodingError)
                completion(nil, encodingError)
            }
        }
    }
    
    
  //  MARK:- Post Request With Multiple Image
//    func postRequestWithMultiImage(urlQuery: String,Body body: Data, PostParameter postParams:NSDictionary , Headers headers: NSDictionary, uploadImageArray multiImages: [String: Data], CompletionHandler completion:@escaping CompletionHandler) {
//        serviceURL = urlQuery
//        var request: URLRequest = self.getRequestUrlForPath(headers: headers)
//        request.httpMethod = HTTPMethod.post.rawValue
//        request.httpBody = body
//        let boundary = generateBoundaryString()
////        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//        request.setValue("application/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//        request.httpBody = createBodyWithMultiImageParameters(postParams, uploadImageArray: multiImages, boundary: boundary)
//        self.sendRequest(request: request, CompletionHandler: completion)
//    }
    
    //MARK:- Generate Boundary And MultiImage parameter for Image Upload
    private func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
//    private func createBodyWithMultiImageParameters(_ parameters: NSDictionary, uploadImageArray multiImages: [String: Data], boundary: String) -> Data {
//        let body = NSMutableData();
//        for (key, value) in parameters {
//            body.appendString("--\(boundary)\r\n")
//            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
//            body.appendString("\(value)\r\n")
//        }
//
//        for (key, value) in multiImages {
//            let filename = "\(key).jpg"
//            let mimetype = "image/jpg"
//            body.appendString("--\(boundary)\r\n")
//            body.appendString("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
//            body.appendString("Content-Type: \(mimetype)\r\n\r\n")
//            body.append(value)
//            body.appendString("\r\n")
//            body.appendString("--\(boundary)--\r\n")
//        }
//        return body as Data
//    }
    
    //MARK:- GetRequestMethods
    private func getRequestUrlForPath(headers: NSDictionary) -> URLRequest {
        let fullUrl = serviceURL
        let url = URL(string: fullUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        var request = URLRequest(url: url!)
        request.timeoutInterval = 360.0
        for (key, value) in headers {
            request.addValue((value as? String)!, forHTTPHeaderField: key as! String)
        }
        return request
    }
    
    //MARK: Header Parameters
    func getHeaderDictionary(token atoken:String) -> NSDictionary{
        let dicData = NSMutableDictionary()
        if atoken.count > 0 {
           // dicData[X_TOKEN] = atoken
        }

        return dicData
    }
    
    //MARK:- Send Request To Server
    private func sendRequest(request: URLRequest, CompletionHandler completionHandler:@escaping CompletionHandler) {
        var urlRequest = request
       
        Alamofire.request(urlRequest).responseJSON()  { response in
            switch response.result {
            case .success(_):
                if response.result.value != nil {
                    print(response.result.value as Any)
                    completionHandler(response.result.value! as AnyObject, nil)
                }
                break
            case .failure(_):
                
                //appDelegate.hideActivityControl()
                completionHandler(nil, response.result.error!)
                break
            }
        }
    }
}

extension NSDictionary {
    func convertDictionaryToStringNew() -> String {
        var paramString = ""
        for (key, value) in self {
            let strTemp = (paramString.count > 0) ? "&\(key)=\(value)" : "\(key)=\(value)"
            paramString = paramString.appendingFormat(strTemp)
        }
        return paramString
    }
}
