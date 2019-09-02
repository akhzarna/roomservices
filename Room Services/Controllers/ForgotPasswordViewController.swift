//
//  ForgotPasswordViewController.swift
//  Room Services
//
//  Created by Muhammad Amir on 7/27/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit
import KRProgressHUD

class ForgotPasswordViewController: BaseViewController {

    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var btnPassword: UIButton!
    @IBOutlet weak var lblMessage: UILabel!
    
    @IBAction func btnSubmitt(_ sender: Any) {
        
        if Connectivity.isConnectedToInternet {
            if (txtFieldEmail.text == ""){
                self.alertShow(aTitle: "Alert!", aMessage: "Please enter your email first!")
            }else {
                
                KRProgressHUD.show(withMessage: "Please wait...")
                
                var pageNo : String = ""
                pageNo = Constants.ServerConfig.BASE_URLPHP
                let dict : NSDictionary = [
                    "user_login": self.txtFieldEmail.text!,
                    "action": "reset_password"
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtFieldEmail.attributedPlaceholder = NSAttributedString(string:" Email",
        attributes: [NSAttributedString.Key.foregroundColor:UIColor.white])
        txtFieldEmail.clipsToBounds = true
        txtFieldEmail.layer.cornerRadius = 12.0
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
