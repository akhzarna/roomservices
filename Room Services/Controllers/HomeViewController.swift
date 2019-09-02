//
//  HomeViewController.swift
//  Room Services
//
//  Created by Muhammad Amir on 8/1/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit
import SDWebImage
import KRProgressHUD
import Alamofire
import OAuthSwift
import Auk
import moa

class HomeViewController: BaseViewController, CategoryRowDelegate   {
  
    func imageSliderViewSingleTap(_ tap: UITapGestureRecognizer) {
        
    }

    var categories = ["Action", "Drama", "Science Fiction", "Kids", "Horror"]

    @IBOutlet weak var btnSearch: UIButton!
    
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var tblProduc: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    var allProduct = [AllProducts]()
    var productSpecialOffer = [AllProducts]()
    var brandsArray = [BrandsList]()
    var imageArray = [String]()
    var selectedIndex = 0
    var colors:[UIColor] = [.red, .blue, .green, .yellow]
    var frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    
    
    @IBAction func btnCart(_ sender: Any) {
    }
    @IBAction func btnSearch(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSlideMenuButton()
        var cartItemsList =  DatabaseHelper.getInstance().getCartList() as! NSArray
        if cartItemsList.count > 0 {
          lblCartCount.layer.cornerRadius = lblCartCount.frame.height / 2
        lblCartCount.text = String(cartItemsList.count)
        }else{
            lblCartCount.isHidden = true
        }
//        lblCartCount.layer.borderWidth = 0.5
//        lblCartCount.clipsToBounds = true
        scrollView.delegate = self
        scrollView.auk.settings.placeholderImage = UIImage(named: "Logo")

      showImageSlider()
      requestForProduct()
      requestSpecialOffers()
      requestBrands()
    }
   
    func showImageSlider() {
         imageArray = ["https://roomserviceq8.com/wp-content/uploads/2019/04/Vagisil.png","https://roomserviceq8.com/wp-content/uploads/2019/06/Souplese.jpg","https://roomserviceq8.com/wp-content/uploads/2019/04/Pearl-Drops.png", "https://roomserviceq8.com/wp-content/uploads/2019/04/Petcare-LOGO-SEPTONAAA.png"]
    // scrollView.auk.stopAutoScroll()
    scrollView.auk.startAutoScroll(delaySeconds: 3)
    for remoteImage in imageArray {
        print("image url", remoteImage)
    //let url =  NSURL(string: remoteImage)  // "\(remoteImage)\(remoteImage)"
    scrollView.auk.show(url: remoteImage)
    
  //  imageDescriptions.append(remoteImage.description)
    }
    }
    
    func requestBrands(){
        
        if Connectivity.isConnectedToInternet {
            
            KRProgressHUD.show(withMessage: "Please wait...")
            
            var pageNo : String = ""
            pageNo = "https://roomserviceq8.com/wp-api.php?action=brands"
            
            
            Alamofire.request(pageNo)
                
                .responseJSON { response in
                    // check for errors
                    if let arrAccess = response.result.value as? [AnyObject] {
                        
                        if arrAccess.count == 0{
                            KRProgressHUD.dismiss()
                            let alertController = UIAlertController(title: "Alert!", message:
                                "No Data Found!", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                            
                            self.present(alertController, animated: true, completion: nil)
                        }
                        KRProgressHUD.dismiss()
                        print("response", arrAccess)
                        self.brandsArray = BrandsList.PopulateArray(array: arrAccess as! [[String : Any]])
                    
                        
                    }else {
                        let alertController = UIAlertController(title: "Alert!", message:
                            "No Data Found!", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
                        
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
            }
            
            
            
            
        }else{
            self.alertShow(aTitle: "Alert!", aMessage: "You are not connected to internet")
        }
        
    }
    
    func requestForProduct(){
        
        if Connectivity.isConnectedToInternet{
            KRProgressHUD.show(withMessage: "Please wait...")
   
           
            let consumerKey = Constants.ApiKeys.consumerKey
            let consumerSecret = Constants.ApiKeys.consumerSecret
            let baseURL = Constants.ServerConfig.BASE_URLV3
            
                let dictMute: [AnyHashable: Any] = [
                    "page" : "1",
                    "per_page" : "5",
                    "order" :  "desc",
                    "orderby" : "id",
                   // "last_name" : ""
                ]
            
            let client = AFOAuth1OneLeggedClient.init(baseURL: NSURL(string:baseURL)! as URL, key: consumerKey,secret: consumerSecret)
            
            client?.getPath("products", parameters: dictMute, success: { (operation, responseObject  ) in
              //  let responseArray = responseObject as? NSArray
                let arr = responseObject as! [[String:Any]]
                self.allProduct = AllProducts.PopulateArray(array: arr)
                print(self.allProduct.count, arr.count)
                KRProgressHUD.dismiss()
                
                DispatchQueue.main.async {
                self.tblProduc.reloadData()
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
    
    
    
    
    func requestSpecialOffers(){
        
        if Connectivity.isConnectedToInternet{
            KRProgressHUD.show(withMessage: "Please wait...")
            
            
            let consumerKey = Constants.ApiKeys.consumerKey
            let consumerSecret = Constants.ApiKeys.consumerSecret
            let baseURL = "https://roomserviceq8.com/wp-json/wc/v3/"
            
            let dictMute: [AnyHashable: Any] = [
                "page" : "1",
                "per_page" : "20",
                "order" :  "desc",
                "orderby" : "id",
                "featured" : "1"
            ]
            
            let client = AFOAuth1OneLeggedClient.init(baseURL: NSURL(string:baseURL)! as URL, key: consumerKey,secret: consumerSecret)
            
            client?.getPath("products", parameters: dictMute, success: { (operation, responseObject  ) in
                //  let responseArray = responseObject as? NSArray
                let arr = responseObject as! [[String:Any]]
                self.productSpecialOffer = AllProducts.PopulateArray(array: arr)
                print(self.productSpecialOffer.count, arr.count)
                KRProgressHUD.dismiss()
                
                DispatchQueue.main.async {
                    self.tblProduc.reloadData()
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
    
    
    
    
    
//    open func imageSliderViewImageSwitch(_ index: Int, count: Int, imageUrl: String?) {
//        self.selectedIndex = index
//        // print("indexx",self.indexSelected)
//        GlobalManager.sharedInstance.index = index
//        GlobalManager.sharedInstance.count = count
//        GlobalManager.sharedInstance.imageUrl = imageUrl!
//
//
//    }
    
    func cellTapped(index: Int, section: Int){
        //code for navigation
        print("index,section", index, section)
        if section == 1{
            
            let productView = self.storyboard?.instantiateViewController(withIdentifier: "BrandProductsViewControllerID") as! BrandProductsViewController
            productView.brandsArray = self.brandsArray
            productView.selectedIndex = index
            self.navigationController?.pushViewController(productView, animated: true)
            
        }
        if section == 2{
            
            let productView = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewControllerID") as! ProductViewController
            productView.productArray = self.productSpecialOffer
            productView.selectedIndex = index
            self.navigationController?.pushViewController(productView, animated: true)
        }
        if section == 3{
            
            let productView = self.storyboard?.instantiateViewController(withIdentifier: "ProductViewControllerID") as! ProductViewController
            productView.productArray = self.allProduct
            productView.selectedIndex = index
            self.navigationController?.pushViewController(productView, animated: true)
        }
        
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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


extension HomeViewController : UITableViewDelegate { }

extension HomeViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       // let object = self.productSpecialOffer[section]
        return "hello"//object.name
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        //(view as! UITableViewHeaderFooterView).backgroundView?.backgroundColor = UIColor.gray    //black.withAlphaComponent(0.4)
       // (view as! UITableViewHeaderFooterView).backgroundView?.layer.cornerRadius = 25.0
        view.isHidden = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductHomeTableViewCell") as! ProductHomeTableViewCell
        
        cell.delegate = self
       // let object = self.productSpecialOffer[indexPath.section]
        if indexPath.section == 0 {
            cell.lblSectionTitle.text = "Brands"
            cell.brandsArray = 1
            cell.brandList = self.brandsArray
            cell.homeCollectionView.reloadData()
           
        }
        if indexPath.section == 1 {
            cell.lblSectionTitle.text = "Top Deals"
            cell.brandsArray = 2
             cell.productCat = self.productSpecialOffer
            cell.homeCollectionView.reloadData()

        }
        if indexPath.section == 2 {
            cell.lblSectionTitle.text = "Special Offers"
            cell.brandsArray = 3
            cell.productCat = self.allProduct
            cell.homeCollectionView.reloadData()
        }
        

        return cell
    }
   
    
}
