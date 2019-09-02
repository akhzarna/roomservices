//
//  BrandProductsViewController.swift
//  Room Services
//
//  Created by Muhammad Amir on 8/25/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit
import KRProgressHUD

class BrandProductsViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var brandProductsCollectionView: UICollectionView!
    var resueIdentifier = "BrandProductsCollectionViewCell"
    var brandProducts = [AllProducts]()
    var brandsArray = [BrandsList]()
    var selectedIndex = 0
    
    @IBOutlet weak var lblNavigationTitle: UILabel!
    @IBOutlet weak var lblCartQuantity: UILabel!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    
    @IBAction func btnSearch(_ sender: Any) {
    }
    @IBAction func btnCart(_ sender: Any) {
    }
    @IBAction func btnBack(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        lblNavigationTitle.text = self.brandsArray[selectedIndex].name
        
        brandsProductsList()
    }
    
    func brandsProductsList(){
        
        if Connectivity.isConnectedToInternet{
            KRProgressHUD.show(withMessage: "Please wait...")
            
            
            let consumerKey = Constants.ApiKeys.consumerKey
            let consumerSecret = Constants.ApiKeys.consumerSecret
            let baseURL = Constants.ServerConfig.BASE_URLPHP
            
            let dictMute: [AnyHashable: Any] = [
                "page" : "1",
                "action" : "brand_products",
                "brand" : self.brandsArray[selectedIndex].id
            ]
            
            let client = AFOAuth1OneLeggedClient.init(baseURL: NSURL(string:baseURL)! as URL, key: consumerKey,secret: consumerSecret)
            
            client?.getPath("products", parameters: dictMute, success: { (operation, responseObject  ) in
                //  let responseArray = responseObject as? NSArray
                let arr = responseObject as! [[String:Any]]
                self.brandProducts = AllProducts.PopulateArray(array: arr)
                print(self.brandProducts.count, arr.count)
                KRProgressHUD.dismiss()
                
                DispatchQueue.main.async {
                    self.brandProductsCollectionView.reloadData()
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
        
        return brandProducts.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width = (self.brandProductsCollectionView.frame.size.width - 40 ) / 4;
//        var height:CGFloat = 0
//        if (Constants.DeviceType.IS_IPHONE_5){
//            height = CGFloat(width + 54)
//        }
//        if (Constants.DeviceType.IS_IPHONE_6P){
//            height = CGFloat(width + 62)
//        }
//        if (Constants.DeviceType.IS_IPHONE_X){
//            height = CGFloat(width + 67)
//        }
//
//        return CGSize(width: width, height: height)
//
//    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resueIdentifier, for: indexPath as IndexPath) as! BrandProductsCollectionViewCell
        var object = self.brandProducts[indexPath.row]
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        
        cell.lblProductTitle.text = object.name
        cell.productImage.sd_setImage(with: URL(string: object.image), placeholderImage: UIImage(named: "placeholder.png"))
        
        
        
        return cell
    }
    
    //     MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        // let Vc = self.storyboard?.instantiateViewController(withIdentifier: "TrainerDetailViewControllerID") as! TrainerDetailViewController
        print("You selected cell #\(indexPath.item)!")
        
        let productView = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewControllerID") as! ProductViewController
        productView.productArray = self.brandProducts
        productView.selectedIndex = indexPath.item
        self.navigationController?.pushViewController(productView, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
