//
//  ApiManager.swift
//  LynkedWorld
//
//  Created by Macbook on 01/11/17.
//  Copyright © 2017 Arusys. All rights reserved.
//

import UIKit

class ApiManager: NSRestApiHelper {
    class var sharedManager: ApiManager {
        struct Singleton {
            static let instance = ApiManager()
        }
        return Singleton.instance
    }
    
    let returnValue = UserDefaults.standard.string(forKey: "idToken")
    let userID = UserDefaults.standard.string(forKey: "userId")
    
    func requestForGet(urlQuery:String,CompletionHandler completion: @escaping CompletionHandler){
        let headers = [
            "": ""
        ]
        self.getrequest(urlQuery: urlQuery, Headers: headers as NSDictionary) { (response, error) in
            if error == nil {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    
    
    func requestForGetwithBarear(urlQuery:String,CompletionHandler completion: @escaping CompletionHandler){
        let headers = [
            "oauth_consumer_key": "ck_ac2f5e9b3e70a5b774612f646eb4759570a66657",
            "oauth_signature_method":"HMAC-SHA1",
            "oauth_timestamp":"1565094785",
            "oauth_nonce":"h4TTMFqGofk",
            "oauth_version":"1.0",
            "oauth_signature":"LnYsRb65BK4RPGHQ/gJceSuESYU="
        ]
     print("header", headers)
        self.getrequest(urlQuery: urlQuery, Headers: headers as NSDictionary) { (response, error) in
            if error == nil {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }

  
    
    func requestForPost(urlQuery: String, dictParam: NSDictionary, CompletionHandler completion: @escaping CompletionHandler) {
        let post = dictParam.convertDictionaryToStringNew()
        let postData:Data = post.data(using: String.Encoding.ascii)!
        let dictHeader = NSDictionary()
        self.postRequest(urlQuery: urlQuery, Body: postData, Headers: dictHeader) { (response, error) in
            if error == nil {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    

    
    func requestForPostWithMultipleMedia(urlQuery: String, dictParam: [String: String], uploadImageArray multiImages: [String: Data], CompletionHandler completion: @escaping CompletionHandler) {
//        let post = dictParam.convertDictionaryToStringNew()
//        let postData:Data = post.data(using: String.Encoding.ascii)!
        let dictHeader =  ["Authorization": "Bearer "+String(returnValue!)]
        self.requestWithImageUpload(urlQuery: urlQuery, parameters: dictParam, Headers: dictHeader as NSDictionary, media: multiImages) { (response, error) in
            if error == nil {
                completion(response, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
