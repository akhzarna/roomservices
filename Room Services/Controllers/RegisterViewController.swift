//
//  RegisterViewController.swift
//  Room Services
//
//  Created by Muhammad Amir on 7/27/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit
import Alamofire
import KRProgressHUD

class RegisterViewController: BaseViewController {

    @IBOutlet weak var lblRegister: UILabel!
    @IBOutlet weak var txtFieldFullName: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPhone: UITextField!
    @IBOutlet weak var txtFieldDateBirth: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldConfirmPassword: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnAlreadyUser: UIButton!
    var userArray = [User]()
    
    @IBAction func btnRegister(_ sender: Any) {
        
            if Connectivity.isConnectedToInternet {
                if (txtFieldEmail.text == "" || txtFieldPassword.text == "" || txtFieldFullName.text == "" || txtFieldPhone.text == "" || txtFieldDateBirth.text == "" || txtFieldConfirmPassword.text == ""){
                        self.alertShow(aTitle: "Alert!", aMessage: "Please fill all the fields")
                                }else {
                
                                    KRProgressHUD.show(withMessage: "Please wait...")
        
        var pageNo : String = ""
        pageNo = Constants.ServerConfig.BASE_URLPHP
        let dict : NSDictionary = [
            "username": self.txtFieldFullName.text!,
            "email": self.txtFieldEmail.text!,
            "pass": self.txtFieldPassword.text!,
            "action": "register"
        ]
        
        ApiManager.sharedManager.requestForPost(urlQuery: pageNo, dictParam: dict) { (response, error) in
            
            if error == nil, let dictResponse = response as? NSDictionary {
                print(dictResponse["error"] as? String)
                
             //   if (dictResponse as? NSObject) != nil {
                    let error = dictResponse["error"] as? String
                if error == "0" {
                        KRProgressHUD.dismiss()
                        let message = dictResponse["message"] as? String
                        self.alertShow(aTitle: "Alert!", aMessage: message!)
                    }else{
                    KRProgressHUD.dismiss()
                    let message = dictResponse["message"] as? String
                    self.alertShow(aTitle: "Alert!", aMessage: message!)
                    }
            //    }
                
            }else {
                KRProgressHUD.dismiss()
                print(error?.localizedDescription as Any)
            }
        }

        
       }
    
    }else{
            self.alertShow(aTitle: "Alert!", aMessage: "You are not connected to internet")
             }
}
    
    @IBAction func btnAlreadyUser(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtFieldFullName.attributedPlaceholder = NSAttributedString(string:" Full Name",
        attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        txtFieldFullName.clipsToBounds = true
        txtFieldFullName.layer.cornerRadius = 12.0
        
        txtFieldEmail.attributedPlaceholder = NSAttributedString(string:" Email",
        attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        txtFieldEmail.clipsToBounds = true
        txtFieldEmail.layer.cornerRadius = 12.0
        
        txtFieldPhone.attributedPlaceholder = NSAttributedString(string:" Phone",
        attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        txtFieldPhone.clipsToBounds = true
        txtFieldPhone.layer.cornerRadius = 12.0
        
        txtFieldDateBirth.attributedPlaceholder = NSAttributedString(string:" Date of Birth",
        attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        txtFieldDateBirth.clipsToBounds = true
        txtFieldDateBirth.layer.cornerRadius = 12.0
        
        txtFieldPassword.attributedPlaceholder = NSAttributedString(string:" Password",
        attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        txtFieldPassword.clipsToBounds = true
        txtFieldPassword.layer.cornerRadius = 12.0
        
        txtFieldConfirmPassword.attributedPlaceholder = NSAttributedString(string:" Confirm Password",
        attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        txtFieldConfirmPassword.clipsToBounds = true
        txtFieldConfirmPassword.layer.cornerRadius = 12.0
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
