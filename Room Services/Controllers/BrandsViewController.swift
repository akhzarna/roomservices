//
//  BrandsViewController.swift
//  Room Services
//
//  Created by Muhammad Amir on 7/28/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit
import KRProgressHUD
import Alamofire

class BrandsViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var NavigationbarView: UIView!
    @IBOutlet weak var lblNavigationTitle: UILabel!
    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var lblNumberofItems: UILabel!
    @IBAction func btnBack(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCart(_ sender: Any) {
    }
    @IBAction func btnSearch(_ sender: Any) {
    }
    
    var brandsArray = [BrandsList]()
    @IBOutlet weak var collectionView: UICollectionView!
    let reuseIdentifier = "BrandsCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       getBrandList()
    }
    
    func getBrandList(){
        
                if Connectivity.isConnectedToInternet {
                   
                        KRProgressHUD.show(withMessage: "Please wait...")
        
                        var pageNo : String = ""
                        pageNo = Constants.ServerConfig.Brands_Api
                    
                    
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
                                self.collectionView.reloadData()
                             
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       print(self.brandsArray.count)
        return self.brandsArray.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let width = (self.collectionView.frame.size.width - 40 ) / 4;
//
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
//        return CGSize(width: width , height: height)
//
//    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! BrandsCollectionViewCell
//        cell.imageBorderView.layer.cornerRadius = cell.imageBorderView.frame.width/2
//        // imageBorderView.clipsToBounds = true
//        cell.imageBorderView.layer.borderWidth = 0.5
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        
            let object = self.brandsArray[indexPath.row]
            cell.lblName.text = object.name
//            // cell.lblNameofTrainer.font = UIFontMetrics.default.scaledFont(for: customFontTitle!)
            cell.image.sd_setImage(with: URL(string: object.image), placeholderImage: UIImage(named: "placeholder.png"))
        
        
        
        return cell
    }
    
    //     MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let Vc = self.storyboard?.instantiateViewController(withIdentifier: "BrandProductsViewControllerID") as! BrandProductsViewController
        Vc.brandsArray = self.brandsArray
        Vc.selectedIndex = indexPath.item
        self.navigationController?.pushViewController(Vc, animated: true)
        print("You selected cell #\(indexPath.item)!")
       
        
        
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
