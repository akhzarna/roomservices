//
//  CategoryViewController.swift
//  Room Services
//
//  Created by Muhammad Amir on 7/28/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit
import KRProgressHUD

class CategoryViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var productCategories = [ProductCategories]()
    var responseArray = [ProductCategories]()
    @IBOutlet weak var collectionView: UICollectionView!
     let reuseIdentifier = "CategoryCollectionViewCell"
     var proId = 0
    var titleNavigation = ""
    @IBOutlet weak var lblNavigationTitle: UILabel!
    @IBOutlet weak var lblCartQuantity: UILabel!
    @IBAction func btnCart(_ sender: Any) {
    }
    @IBAction func btnSearch(_ sender: Any) {
    }
    @IBAction func btnBack(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getProductCategories()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func getProductCategories(){
        
        if Connectivity.isConnectedToInternet{
            KRProgressHUD.show(withMessage: "Please wait...")
            
            
            let consumerKey = Constants.ApiKeys.consumerKey
            let consumerSecret = Constants.ApiKeys.consumerSecret
            let baseURL = Constants.ServerConfig.Product_CategoriesApi
            
            let dictMute: [AnyHashable: Any] = [
                "page" : "1",
                "per_page" : "100",
                "order" :  "asc",
                "hide_empty" : "true",
                "orderby" : "name",
                "parent" : "0",
                // "last_name" : ""
            ]
            
            let client = AFOAuth1OneLeggedClient.init(baseURL: NSURL(string:baseURL)! as URL, key: consumerKey,secret: consumerSecret)
            
            
            client?.getPath("categories", parameters: dictMute, success: { (operation, responseObject  ) in
                let responseArray = responseObject as? NSArray
                //                SVProgressHUD.dismiss()
                let arr = responseObject as! [[String:Any]]
                print("here it is", arr)
                self.productCategories = ProductCategories.PopulateArray(array: arr)
                KRProgressHUD.dismiss()
               
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }, failure: { (operation, error) in
                KRProgressHUD.dismiss()
                self.alertShow(aTitle: "Alert!", aMessage:"Error Occured!")
                print("Error: " + (error?.localizedDescription)!)
                
                
            })
            
            
            
            
            
        }else{
            self.alertShow(aTitle: "Alert!", aMessage:"You are not connected to internet")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.productCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.collectionView.frame.size.width - 80 ) / 3;
        
        
        return CGSize(width: width , height: width+50)
        
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CategoryCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        
            let object = self.productCategories[indexPath.row]
            cell.lblName.text = object.name
        //            // cell.lblNameofTrainer.font = UIFontMetrics.default.scaledFont(for: customFontTitle!)
          cell.itemImage.sd_setImage(with: URL(string: object.image), placeholderImage: UIImage(named: "placeholder.png"))
        
        
        
        return cell
    }
    
    //     MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.proId = self.productCategories[indexPath.item].id
        self.titleNavigation = self.productCategories[indexPath.item].name
        getHeaderList()
        print("You selected cell #\(indexPath.item)!")
//        let productView = self.storyboard?.instantiateViewController(withIdentifier: "CategoryItemsViewControllerID") as! CategoryItemsViewController
////        productView.categoryArray = self.productCategories
//        productView.pId = self.productCategories[indexPath.item].id
//        self.navigationController?.pushViewController(productView, animated: true)
        
        
    }

    
    func getHeaderList(){
        
        if Connectivity.isConnectedToInternet{
            KRProgressHUD.show(withMessage: "Please wait...")
            
            
            let consumerKey = Constants.ApiKeys.consumerKey
            let consumerSecret = Constants.ApiKeys.consumerSecret
            let baseURL = Constants.ServerConfig.Product_CategoriesApi
            
            let dictMute: [AnyHashable: Any] = [
                "page" : "1",
                "per_page" : "100",
                "order" :  "asc",
                "hide_empty" : "true",
                "orderby" : "name",
                "parent" : proId,
                // "last_name" : ""
            ]
            
            let client = AFOAuth1OneLeggedClient.init(baseURL: NSURL(string:baseURL)! as URL, key: consumerKey,secret: consumerSecret)
            
            
            client?.getPath("categories", parameters: dictMute, success: { (operation, responseObject  ) in
                let responseArray = responseObject as? NSArray
                //                SVProgressHUD.dismiss()
                let arr = responseObject as! [[String:Any]]
                print("here it is", arr)
                self.responseArray = ProductCategories.PopulateArray(array: arr)
                KRProgressHUD.dismiss()
                if self.responseArray.count > 0{
                    let productView = self.storyboard?.instantiateViewController(withIdentifier: "CategoryItemsViewControllerID") as! CategoryItemsViewController
                            productView.headerArray = self.responseArray
                            productView.titleNavigation = self.titleNavigation
                            self.navigationController?.pushViewController(productView, animated: true)
                }else{
                    
                    let productView = self.storyboard?.instantiateViewController(withIdentifier: "SpecialOffersViewControllerID") as! SpecialOffersViewController
                    productView.catId = self.proId
                    productView.titleNavigation = self.titleNavigation
                    self.navigationController?.pushViewController(productView, animated: true)
                    
                }
                
//                DispatchQueue.main.async {
//                    self.pagingHeaderCollectionView.reloadData()
//                }
                
            }, failure: { (operation, error) in
                KRProgressHUD.dismiss()
                self.alertShow(aTitle: "Alert!", aMessage:"Error Occured!")
                print("Error: " + (error?.localizedDescription)!)
                
                
            })
            
            
            
            
            
        }else{
            self.alertShow(aTitle: "Alert!", aMessage:"You are not connected to internet")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
