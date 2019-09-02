//
//  SpecialOffersViewController.swift
//  Room Services
//
//  Created by Muhammad Amir on 8/22/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit
import KRProgressHUD

class SpecialOffersViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var specialOffersCollectionView: UICollectionView!
    var offersArray = [AllProducts]()
    var categoryArray = [ProductCategories]()
    var selectedIndex = 0
    var resueIdentifier = "SpecialOffersCollectionViewCell"
    var catId = 0
    var titleNavigation = ""
    
    @IBOutlet weak var lblNavigationTitle: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var lblCartQuantity: UILabel!
    
    
    @IBAction func btnCart(_ sender: Any) {
    }
    
    @IBAction func btnBack(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSearch(_ sender: Any) {
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.lblNavigationTitle.text = self.titleNavigation
            requestforSpecialOffers()
       
    }
    

    func requestforSpecialOffers(){
        
        if Connectivity.isConnectedToInternet{
            KRProgressHUD.show(withMessage: "Please wait...")
            
            
            let consumerKey = Constants.ApiKeys.consumerKey
            let consumerSecret = Constants.ApiKeys.consumerSecret
            let baseURL = Constants.ServerConfig.BASE_URLV3
            
            
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
                self.offersArray = AllProducts.PopulateArray(array: arr)
                print(self.offersArray.count, arr.count)
                KRProgressHUD.dismiss()
                
                DispatchQueue.main.async {
                    self.specialOffersCollectionView.reloadData()
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
        
        return offersArray.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let width = (self.specialOffersCollectionView.frame.size.width - 40 ) / 4;
//        var height:CGFloat = 0
//        if (Constants.DeviceType.IS_IPHONE_5){
//            height = CGFloat(width + 56)
//        }
//        if (Constants.DeviceType.IS_IPHONE_6P){
//            height = CGFloat(width + 60)
//        }
//        if (Constants.DeviceType.IS_IPHONE_X){
//            height = CGFloat(width + 68)
//        }
//        
//        return CGSize(width: width, height: height)
//        
//    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resueIdentifier, for: indexPath as IndexPath) as! SpecialOffersCollectionViewCell
        var object = self.offersArray[indexPath.row]
        
      //  layoutIfNeeded()
//        cell.imageRoundView.layer.cornerRadius = cell.imageRoundView.frame.width/2
//        cell.imageRoundView.layer.borderWidth = 1.5
//        cell.imageRoundView.clipsToBounds = true
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        
        cell.lblProductName.text = object.name
        cell.itemImage.sd_setImage(with: URL(string: object.image), placeholderImage: UIImage(named: "placeholder.png"))
        
        
        
        return cell
    }
    
    //     MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        // let Vc = self.storyboard?.instantiateViewController(withIdentifier: "TrainerDetailViewControllerID") as! TrainerDetailViewController
        print("You selected cell #\(indexPath.item)!")
        
        let productView = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewControllerID") as! ProductViewController
        productView.productArray = self.offersArray
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
