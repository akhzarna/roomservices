//
//  CategoryItemsViewController.swift
//  Room Services
//
//  Created by Muhammad Amir on 8/30/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit
import KRProgressHUD

class CategoryItemsViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var pagingHeaderCollectionView: UICollectionView!
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    var selectedHeader = 0
    var pId = 0
    var selectedIndex = 0
    var headerArray = [ProductCategories]()
    var productArray = [AllProducts]()
    var titleNavigation = ""
    @IBOutlet weak var lblNavigationTitle: UILabel!
    @IBOutlet weak var lblCartQuantity: UILabel!
    
    
    @IBAction func btnBack(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCart(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblNavigationTitle.text = self.titleNavigation
        getHeaderList()
    }
    
    func getHeaderList(){
        
        if Connectivity.isConnectedToInternet{
            KRProgressHUD.show(withMessage: "Please wait...")
            
            
            let consumerKey = Constants.ApiKeys.consumerKey
            let consumerSecret = Constants.ApiKeys.consumerSecret
            let baseURL = Constants.ServerConfig.BASE_URLV3
            var catId = 0
           // if categoryArray.count > 0 {
                catId = self.headerArray[self.selectedIndex].id
                //}else{
                // catId = self.categoryArray[selectedIndex].id
            //}
            
            let dictMute: [AnyHashable: Any] = [
                "page" : "1",
                "per_page" : "20",
                "order" :  "desc",
                "orderby" : "id",
                "category" : catId
            ]
            
            let client = AFOAuth1OneLeggedClient.init(baseURL: NSURL(string:baseURL)! as URL, key: consumerKey,secret: consumerSecret)
            
            client?.getPath("products", parameters: dictMute, success: { (operation, responseObject  ) in
                //  let responseArray = responseObject as? NSArray
                let arr = responseObject as! [[String:Any]]
                self.productArray = AllProducts.PopulateArray(array: arr)
                print(self.productArray.count, arr.count)
                KRProgressHUD.dismiss()
                
                DispatchQueue.main.async {
                    self.itemsCollectionView.reloadData()
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
        var count = 0
        if collectionView == self.pagingHeaderCollectionView {
            count = self.headerArray.count
        }else{
            count = self.productArray.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height:CGFloat = 0
        var width:CGFloat = 0
        if collectionView == self.pagingHeaderCollectionView {
            
            width = (self.itemsCollectionView.frame.size.width - 30 ) / 3;
            
            if (Constants.DeviceType.IS_IPHONE_5){
                height = CGFloat(width + 60)
            }
            if (Constants.DeviceType.IS_IPHONE_6P){
                height = CGFloat(width + 62)
            }
            if (Constants.DeviceType.IS_IPHONE_X){
                height = CGFloat(width + 67)
        }
        }else{
         width = (self.itemsCollectionView.frame.size.width - 40 ) / 2;
        
        if (Constants.DeviceType.IS_IPHONE_5){
            height = CGFloat(width )
        }
        if (Constants.DeviceType.IS_IPHONE_6P){
            height = CGFloat(width )
        }
        if (Constants.DeviceType.IS_IPHONE_X){
            height = CGFloat(width )
        }
        }
        return CGSize(width: width, height: height)
        
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        
         if collectionView == self.pagingHeaderCollectionView {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagingHeaderCollectionViewCell", for: indexPath as IndexPath) as! PagingHeaderCollectionViewCell
            var object = self.headerArray[indexPath.row]
            if indexPath.row == self.selectedHeader {
                cell.lblLiner.isHidden = false
            }else{
                cell.lblLiner.isHidden = true
            }
            
            cell.lblTitle.text = object.name
            return cell
        }
        
        if collectionView == self.itemsCollectionView {
          
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryItemsCollectionViewCell", for: indexPath as IndexPath) as! CategoryItemsCollectionViewCell
          
            var object = self.productArray[indexPath.row]
            cell.lblName.text = object.name
            cell.lblDescription.text = "KWD " + object.price
            
            cell.itemImage.sd_setImage(with: URL(string: object.image), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
        }
       
        
        
        return UICollectionViewCell()
    }
    
    //     MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
       if collectionView == self.pagingHeaderCollectionView {
        print("You selected header cell #\(indexPath.item)!")
        let cell = collectionView.cellForItem(at: indexPath) as? PagingHeaderCollectionViewCell
        cell?.lblLiner.isHidden = false
        self.selectedHeader = indexPath.row
        self.selectedIndex = indexPath.row
        self.pagingHeaderCollectionView.reloadData()
        getHeaderList()

        }
        
        if collectionView == self.itemsCollectionView {
            print("You selected item cell #\(indexPath.item)!")
        }
        
        
//        let productView = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewControllerID") as! ProductViewController
//        productView.productArray = self.brandProducts
//        productView.selectedIndex = indexPath.item
//        self.navigationController?.pushViewController(productView, animated: true)
        
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
