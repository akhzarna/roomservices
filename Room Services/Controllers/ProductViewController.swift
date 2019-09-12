//
//  ProductViewController.swift
//  Room Services
//
//  Created by Muhammad Amir on 8/20/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit
import KRProgressHUD
import SQLite3

class ProductViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var productBorderView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var relatedProductsCollectionView: UICollectionView!
     let reuseIdentifier = "RelatedProductsCollectionViewCell"
    
    var productArray = [AllProducts]()
    var brandsArray = [BrandsList]()
    var relatedProducts = [AllProducts]()
    var selectedIndex = 0
    @IBOutlet weak var lblNavigationTitle: UILabel!
    @IBOutlet weak var lblCartQuantity: UILabel!
    
    @IBAction func btnBack(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCart(_ sender: Any) {
    }
    
    @IBAction func brnAdd(_ sender: Any) {
        let product = self.productArray[selectedIndex]
        let quantityProduct = 0
        DatabaseHelper.getInstance().insertIntoCart(array: product, quantity: quantityProduct )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

                btnAdd.layer.cornerRadius = 12.0//itemImage.frame.height/1.5
                btnAdd.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        //print(self.productArray.count, self.brandsArray.count)
        
       
        initialProduct()
        requestForRelatedProduct()
    }
    
    
    func initialProduct(){
        
        //cartitem quantity
        var cartItemsList =  DatabaseHelper.getInstance().getCartList() as! NSArray
        if cartItemsList.count > 0 {
            lblCartQuantity.layer.cornerRadius = lblCartQuantity.frame.height / 2
            lblCartQuantity.text = String(cartItemsList.count)
        }else{
            lblCartQuantity.isHidden = true
        }
        
        
        
        // border of image view
        productBorderView.layer.cornerRadius = 7//productBorderView.frame.width/7
        productBorderView.layer.borderWidth = 0.7
        productBorderView.clipsToBounds = true
        
        
        if self.productArray.count > 0{
            productImage.sd_setImage(with: URL(string: self.productArray[selectedIndex].image), placeholderImage: UIImage(named: "placeholder.png"))
            lblMainTitle.text = self.productArray[selectedIndex].name
            lblDescription.text = self.productArray[selectedIndex].Description
            lblPrice.text = "KWD " + self.productArray[selectedIndex].price
            
            lblNavigationTitle.text = self.productArray[selectedIndex].name
        }
//        if self.brandsArray.count > 0{
//            productImage.sd_setImage(with: URL(string: self.brandsArray[selectedIndex].image), placeholderImage: UIImage(named: "placeholder.png"))
//            lblMainTitle.text = self.brandsArray[selectedIndex].name
//            lblDescription.text = self.brandsArray[selectedIndex].Description
//            lblPrice.text = "KWD " + self.brandsArray[selectedIndex].display
//
//            lblNavigationTitle.text = self.brandsArray[selectedIndex].name
//        }
        
    }
    
    
    
    
    
    func requestForRelatedProduct(){
        
        if Connectivity.isConnectedToInternet{
            KRProgressHUD.show(withMessage: "Please wait...")
            
            
            let consumerKey = Constants.ApiKeys.consumerKey
            let consumerSecret = Constants.ApiKeys.consumerSecret
            let baseURL =  Constants.ServerConfig.BASE_URLPHP
            var dictMute = [AnyHashable: Any]()
            
            
                var idsString = self.productArray[selectedIndex].related_ids.description.replacingOccurrences(of: "[", with: "", options: NSString.CompareOptions.literal, range: nil)
                idsString = idsString.replacingOccurrences(of: "]", with: "", options: NSString.CompareOptions.literal, range: nil)

             dictMute = [
                "products" : idsString,
                "action" : "related_products",
                
            ]
            
            
            let client = AFOAuth1OneLeggedClient.init(baseURL: NSURL(string:baseURL)! as URL, key: consumerKey,secret: consumerSecret)
            
            client?.getPath("products", parameters: dictMute, success: { (operation, responseObject  ) in
                //  let responseArray = responseObject as? NSArray
                let arr = responseObject as! [[String:Any]]
                self.relatedProducts = AllProducts.PopulateArray(array: arr)
                print(self.relatedProducts.count, arr.count)
                KRProgressHUD.dismiss()
                
                DispatchQueue.main.async {
                    self.relatedProductsCollectionView.reloadData()
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
        
        return self.relatedProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (self.relatedProductsCollectionView.frame.size.width - 40 ) / 4;
        var height:CGFloat = 0
        if (Constants.DeviceType.IS_IPHONE_5){
            height = CGFloat(width + 54)
        }
        if (Constants.DeviceType.IS_IPHONE_6P){
            height = CGFloat(width + 62)
        }
        if (Constants.DeviceType.IS_IPHONE_X){
            height = CGFloat(width + 67)
        }
        
        return CGSize(width: width, height: height)

    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! RelatedProductsCollectionViewCell
        cell.productImageBorder.layer.cornerRadius = cell.productImageBorder.frame.width/7
        cell.productImageBorder.layer.borderWidth = 0.2
        cell.productImageBorder.clipsToBounds = true
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        
        let object = self.relatedProducts[indexPath.row]
        cell.lblTitle.text = object.name
        cell.lblPrice.text = "KWD " + object.price
        cell.productImage.sd_setImage(with: URL(string: object.image), placeholderImage: UIImage(named: "placeholder.png"))
        
        
        
        return cell
    }
    
    //     MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        // let Vc = self.storyboard?.instantiateViewController(withIdentifier: "TrainerDetailViewControllerID") as! TrainerDetailViewController
        print("You selected cell #\(indexPath.item)!")
        self.productArray = self.relatedProducts
        self.selectedIndex = indexPath.item
        initialProduct()
        requestForRelatedProduct()
        
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
