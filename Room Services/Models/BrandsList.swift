//
//  Property.swift
//  Yakut
//
//  Created by Tahir Hameed on 3/7/18.
//  Copyright © 2018 AtTech. All rights reserved.
//

import UIKit

//{
//    "term_id": 59,
//    "name": "Acqua Eva",
//    "slug": "acqua-eva",
//    "term_group": 0,
//    "term_taxonomy_id": 59,
//    "taxonomy": "yith_product_brand",
//    "description": "",
//    "parent": 0,
//    "count": 9,
//    "filter": "raw",
//    "image": "https://roomserviceq8.com/wp-content/uploads/2019/01/eValogo_20180325-052913313.png"
//},


class BrandsList: NSObject {
    

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
        
        
        if let aVideoId = dictionary["term_id"] as? Int{
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
        if let aVideoId = dictionary["image"] as? String {
            image = aVideoId
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
    
    class func Populate(dictionary:[String: Any]) -> BrandsList {
        let obj = BrandsList(Data: dictionary)
        return obj
    }
    
    class func PopulateArray(array:[[String: Any]]) -> [BrandsList] {
        var result :[BrandsList] = []
        for item in array {
            let obj = BrandsList(Data: item)
            result.append(obj)
        }
        return result
    }

}
