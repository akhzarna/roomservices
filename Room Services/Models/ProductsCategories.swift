//
//  ProductCategories.swift
//  Room Services
//
//  Created by Muhammad Amir on 8/8/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit

class ProductsCategories: NSObject {
        
        var id : Int = 0
        var name  : String = ""
        var slug  : String = ""
    

    
    
        override init() {
            super.init()
        }
        
        init(Data dictionary:[String: Any]){
            super.init()
            
            if let aId = dictionary["id"] as? Int {
                id = aId
            }
            if let aname = dictionary["name"] as? String {
                name = aname
            }
            if let aSlug = dictionary["slug"] as? String {
                slug = aSlug
            }
           
        }
        
        class func Populate(dictionary:[String: Any]) -> ProductsCategories {
            let obj = ProductsCategories(Data: dictionary)
            return obj
        }
        
        class func PopulateArray(array:[[String: Any]]) -> [ProductsCategories] {
            var result :[ProductsCategories] = []
            for item in array {
                let obj = ProductsCategories(Data: item)
                result.append(obj)
            }
            return result
        }
}
