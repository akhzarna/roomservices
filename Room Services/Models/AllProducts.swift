//
//  Property.swift
//  Yakut
//
//  Created by Tahir Hameed on 3/7/18.
//  Copyright © 2018 AtTech. All rights reserved.
//

import UIKit

        //"id": 3607,
        //"name": "Smokers Gel (Blue) 75 ML",
        //"slug": "smokers-gel-blue-75-ml",
        //"permalink": "https:\/\/roomserviceq8.com\/product\/smokers-gel-blue-75-ml\/",
        //"date_created": "2019-08-06T12:20:21",
        //"date_created_gmt": "2019-08-06T12:20:21",
        //"date_modified": "2019-08-06T12:22:16",
        //"date_modified_gmt": "2019-08-06T12:22:16",
        //"type": "simple",
        //"status": "publish",
        //"featured": false,
        //"catalog_visibility": "visible",
        //"description": "<p>A unique gel-based toothpaste with advanced micro-polishers that remove stains and plaque.<\/p>\n",
        //"short_description": "",
        //"sku": "",
        //"price": "0.760",
        //"regular_price": "0.760",
        //"sale_price": "",
        //"date_on_sale_from": null,
        //"date_on_sale_from_gmt": null,
        //"date_on_sale_to": null,
        //"date_on_sale_to_gmt": null,
        //"price_html": "<span class=\"woocommerce-Price-amount amount\"><span class=\"woocommerce-Price-currencySymbol\">KWD<\/span>0.760<\/span>",
        //"on_sale": false,
        //"purchasable": true,
        //"total_sales": 0,
        //"virtual": false,
        //"downloadable": false,
        //"downloads": [],
        //"download_limit": -1,
        //"download_expiry": -1,
        //"external_url": "",
        //"button_text": "",
        //"tax_status": "taxable",
        //"tax_class": "",
        //"manage_stock": false,
        //"stock_quantity": null,
        //"stock_status": "instock",
        //"backorders": "no",
        //"backorders_allowed": false,
        //"backordered": false,
        //"sold_individually": false,
        //"weight": "",
        //"dimensions": {
        //    "length": "",
        //    "width": "",
        //    "height": ""
        //},
        //"shipping_required": true,
        //"shipping_taxable": true,
        //"shipping_class": "",
        //"shipping_class_id": 0,
        //"reviews_allowed": true,
        //"average_rating": "0.00",
        //"rating_count": 0,
        //"related_ids": [
        //3603,
        //2530,
        //2676,
        //2679,
        //2702
        //],
        //"upsell_ids": [],
        //"cross_sell_ids": [],
        //"parent_id": 0,
        //"purchase_note": "",
        //"categories": [
        //{
        //"id": 176,
        //"name": "Special Offers",
        //"slug": "special-offers"
        //}
        //],
        //"tags": [],
        //"images": [
        //{
        //"id": 3608,
        //"date_created": "2019-08-06T12:19:46",
        //"date_created_gmt": "2019-08-06T12:19:46",
        //"date_modified": "2019-08-06T12:19:46",
        //"date_modified_gmt": "2019-08-06T12:19:46",
        //"src": "https:\/\/roomserviceq8.com\/wp-content\/uploads\/2019\/08\/PD-Smokers-Gel.png",
        //"name": "PD Smokers Gel",
        //"alt": ""
        //}
        //],
        //"attributes": [],
        //"default_attributes": [],
        //"variations": [],
        //"grouped_products": [],
        //"menu_order": 0,
        //"meta_data": [
        //{
        //"id": 47318,
        //"key": "_wpml_word_count",
        //"value": "{\"total\":24,\"to_translate\":{\"ar\":24}}"
        //},
        //{
        //"id": 47329,
        //"key": "_wpml_media_has_media",
        //"value": "1"
        //},
        //{
        //"id": 47330,
        //"key": "_wpml_media_featured",
        //"value": "1"
        //},
        //{
        //"id": 47331,
        //"key": "_wpml_media_duplicate",
        //"value": "1"
        //},
        //{
        //"id": 47332,
        //"key": "_alp_processed",
        //"value": "1565094136"
        //},
        //{
        //"id": 47333,
        //"key": "_wpml_location_migration_done",
        //"value": "1"
        //},
        //{
        //"id": 47365,
        //"key": "hot_sign_check",
        //"value": "7"
        //},
        //{
        //"id": 47366,
        //"key": "_hot_sign_check",
        //"value": "field_5c5ae77ccd83a"
        //},
        //{
        //"id": 47367,
        //"key": "product_code",
        //"value": ""
        //},
        //{
        //"id": 47368,
        //"key": "_product_code",
        //"value": "field_5c813bf334125"
        //}
        //],
        //"translations": [],
        //"lang": "en",
        //"_links": {
        //    "self": [
        //    {
        //    "href": "https:\/\/roomserviceq8.com\/wp-json\/wc\/v3\/products\/3607"
        //    }
        //    ],
        //    "collection": [
        //    {
        //    "href": "https:\/\/roomserviceq8.com\/wp-json\/wc\/v3\/products"
        //    }
        //    ]
        //}
        //},

class AllProducts: NSObject {
    

    var id: String =  ""
    var ID: Int = 0
    var name: String =  ""
    var slug: String = ""
    var parent_id: Int = 0
    var Description: String = ""
    var display: String = "" //
    var image: String = ""  //
    var menu_order: Int = 0
    var rating_count: Int = 0
    var href: String = ""
    var permalink: String = ""
    var short_description: String = ""
    var price : String = ""
    var related_ids = [Any]()
    var quantity : Any = 0
    var categroyList = [ProductsCategories]()
    
    override init() {
        super.init()
    }
    
    init(Data dictionary:[String: Any]){
        super.init()
        print(dictionary)
        if let aRelatedids = dictionary["related_ids"] as? NSArray{
            
            for obj in aRelatedids{
              //  var objrString = String(obj)
                related_ids.append(obj)
            }
        }
        if let aVideoId = dictionary["id"] as? Int{
            ID = aVideoId
            id = String(aVideoId)
        }
        if let aVideoIdString = dictionary["id"] as? String {
            id = String(aVideoIdString)
        }
        if let aVideoId = dictionary["name"] as? String {
            name = aVideoId.replaceDictionary(Constants.StRINGREPLACE.dictionary)
        }
        if let aVideoId = dictionary["slug"] as? String {
            slug = aVideoId.replaceDictionary(Constants.StRINGREPLACE.dictionary)
        }
        if let aPrice = dictionary["price"] as? String{
            price = aPrice
        }
        if let aVideoId = dictionary["parent_id"] as? Int{
            parent_id = aVideoId
        }
        if let aVideoId = dictionary["description"] as? String {
            Description = aVideoId.replaceDictionary(Constants.StRINGREPLACE.dictionary)
        }
        if let aVideoId = dictionary["display"] as? String {
            display = aVideoId.replaceDictionary(Constants.StRINGREPLACE.dictionary)
        }
        if let aVideoId = dictionary["quantity"] as? Any {
            quantity = aVideoId
        }
//        if let aVideoId = dictionary["image"] as? String {
//            image = aVideoId
//        }
        if  let scr = dictionary["images"] as? NSArray{
            if let aVideoId = scr.object(at: 0) as? NSDictionary{
                if let imageURL = aVideoId["src"] as? String{
                    image = imageURL
                }
            }
            
    }
        if let aVideoId = dictionary["short_description"] as? String {
            short_description = aVideoId.replaceDictionary(Constants.StRINGREPLACE.dictionary)
        }
        if let aVideoId = dictionary["permalink"] as? String {
            permalink = aVideoId
        }
        if let aVideoId = dictionary["menu_order"] as? Int{
            menu_order = aVideoId
        }
        if let aVideoId = dictionary["rating_count"] as? Int{
            rating_count = aVideoId
        }
        
        
        if let aCategories = dictionary["categories"] as? [[String: Any]] {
            self.categroyList = ProductsCategories.PopulateArray(array: aCategories)
        }
       
        

    }
    
    class func Populate(dictionary:[String: Any]) -> AllProducts {
        let obj = AllProducts(Data: dictionary)
        return obj
    }
    
    class func PopulateArray(array:[[String: Any]]) -> [AllProducts] {
        var result :[AllProducts] = []
        for item in array {
            let obj = AllProducts(Data: item)
            result.append(obj)
        }
        return result
    }

}

extension String{
    func replaceDictionary(_ dictionary: [String: String]) -> String{
        var result = String()
        var i = -1
        for (of , with): (String, String)in dictionary{
            i += 1
            if i<1{
                result = self.replacingOccurrences(of: of, with: with)
            }else{
                result = result.replacingOccurrences(of: of, with: with)
            }
        }
        return result
    }
}
