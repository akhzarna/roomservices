//
//  Property.swift
//  Yakut
//
//  Created by Tahir Hameed on 3/7/18.
//  Copyright © 2018 AtTech. All rights reserved.
//

import UIKit

//{
//    "id": 171,
//    "name": "Baby Calm n Care",
//    "slug": "baby-calm-n-care",
//    "parent": 0,
//    "description": "",
//    "display": "default",
//     "image": {
//        "id": 3615,
//        "date_created": "2019-08-15T07:41:54",
//        "date_created_gmt": "2019-08-15T07:41:54",
//        "date_modified": "2019-08-15T07:41:54",
//        "date_modified_gmt": "2019-08-15T07:41:54",
//        "src": "https://roomserviceq8.com/wp-content/uploads/2019/08/baby-boy.png",
//        "name": "baby-boy",
//        "alt": ""
//        },
//    "menu_order": 0,
//    "count": 10,
//    "_links": {
//        "self": [
//        {
//        "href": "https:\/\/roomserviceq8.com\/wp-json\/wc\/v3\/products\/categories\/171"
//        }
//        ],
//        "collection": [
//        {
//        "href": "https:\/\/roomserviceq8.com\/wp-json\/wc\/v3\/products\/categories"
//        }
//        ]
//    }
//},


class ProductCategories: NSObject {
    

    var id: Int =  0
    var name: String =  ""
    var slug: String = ""
    var parent: Int = 0
    var Description: String = ""
    var display: String = ""
    var image: String = ""
    var menu_order: Int = 0
    var count: Int = 0
    var href: String = ""

    
    override init() {
        super.init()
    }
    
    init(Data dictionary:[String: Any]){
        super.init()
        
        
        if let aVideoId = dictionary["id"] as? Int{
            id = aVideoId
        }
        if let aVideoId = dictionary["name"] as? String {
            name = aVideoId
        }
        if let aVideoId = dictionary["slug"] as? String {
            slug = aVideoId
        }
        if let aVideoId = dictionary["parent"] as? Int{
            parent = aVideoId
        }
        if let aVideoId = dictionary["Description"] as? String {
            Description = aVideoId
        }
        if let aVideoId = dictionary["display"] as? String {
            display = aVideoId
        }
        if  let scr = dictionary["image"] as? NSDictionary{
          if  let aVideoId = scr["src"] as? String {
            image = aVideoId
         }
        }
        if let aVideoId = dictionary["menu_order"] as? Int{
            menu_order = aVideoId
        }
        if let aVideoId = dictionary["count"] as? Int{
            count = aVideoId
        }
        
        
        if let aCompetition = dictionary["_links"] as? NSDictionary {
            if let aLocation = aCompetition["self"] as? NSDictionary{
                if let aHref = aLocation["href"] as? String{
                    href = aHref
                }
            }
        }
       
        

    }
    
    class func Populate(dictionary:[String: Any]) -> ProductCategories {
        let obj = ProductCategories(Data: dictionary)
        return obj
    }
    
    class func PopulateArray(array:[[String: Any]]) -> [ProductCategories] {
        var result :[ProductCategories] = []
        for item in array {
            let obj = ProductCategories(Data: item)
            result.append(obj)
        }
        return result
    }

}
