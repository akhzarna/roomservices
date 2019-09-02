//
//  CartViewController.swift
//  Room Services
//
//  Created by Muhammad Amir on 8/21/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit

class CartViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblCart: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var btnCheckout: UIButton!
    @IBOutlet weak var btnContinueShopping: UIButton!
    var subTotal = 0
    var cartItemsList:NSArray = []
    var allProducts = [AllProducts]()
    
    @IBOutlet weak var lblNavigationTitle: UILabel!
    
    
    @IBAction func btnBack(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnContinueShopping(_ sender: Any) {
    }
    
    @IBAction func btnCheckout(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        cartItemsList =  DatabaseHelper.getInstance().getCartList() as! NSArray
        self.allProducts = AllProducts.PopulateArray(array: self.cartItemsList as! [[String : Any]])
        
        
       // print(cartItemsList)
       // print(allProducts[0].id)
        tblCart.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // let Nurows = self.myApiArray.count
        return self.allProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let identifier="CartTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CartTableViewCell
        
        cell.cellMainView.layer.cornerRadius = 21
        cell.cellMainView.layer.borderWidth = 0.2
        
        cell.imageParentView.layer.cornerRadius = 21
        cell.imageParentView.layer.borderWidth = 0.1
        
        cell.lblQuantity.layer.cornerRadius = 4
        cell.lblQuantity.layer.borderWidth = 1
        
        
        let objet = self.allProducts[indexPath.row]
        print("objet", objet.quantity)
        
        cell.lblTitle.text = objet.name
        //        cell.lblQuantity.text = "2"
        cell.lblPrice.text = "KWD " + objet.price
        cell.lblQuantity.text = objet.quantity as! String
        cell.productImage.sd_setImage(with: URL(string: objet.image), placeholderImage: UIImage(named: "placeholder.png"))
        // var value =
        cell.btnPlus.tag = indexPath.row
        cell.btnPlus.addTarget(self, action: #selector(updateQuantity), for: .touchUpInside)
        
        cell.btnSubtract.tag = indexPath.row
        cell.btnSubtract.addTarget(self, action: #selector(sbtractQuantity), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //        let objet = self.myApiArray[indexPath.row]
        //
        //        let now = objet.videoURL
        
        
        
    }
    
    @objc func updateQuantity(_ sender: AnyObject) {
        //        let List = self.myApiArray[sender.tag]
                let obj = self.allProducts[sender.tag]
        
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        let cell = self.tblCart.cellForRow(at: indexPath as IndexPath) as! CartTableViewCell?
        //if cell?.btnPlus.tag
        var newQuantity = Int((cell?.lblQuantity.text)!)
        
        cell!.lblQuantity.text = String(newQuantity!+1)
        newQuantity = Int((cell?.lblQuantity.text)!)
        DatabaseHelper.getInstance().updateQuantityIdForAddtoCart(productId: obj.id, quantity: newQuantity!)
        
    }
    @objc func sbtractQuantity(_ sender: AnyObject) {
        //        let List = self.myApiArray[sender.tag]
                let obj = allProducts[sender.tag]
        
        
        let indexPath = NSIndexPath(row: sender.tag, section: 0)
        let cell = self.tblCart.cellForRow(at: indexPath as IndexPath) as! CartTableViewCell?
        var newQuantity = Int((cell?.lblQuantity.text)!)
        if newQuantity! > 0{
            cell!.lblQuantity.text = String(newQuantity!-1)
            newQuantity = Int((cell?.lblQuantity.text)!)
            DatabaseHelper.getInstance().updateQuantityIdForAddtoCart(productId: obj.id, quantity: newQuantity!)
        }
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
