//
//  LoginViewController.swift
//  Room Services
//
//  Created by Muhammad Amir on 7/24/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit
import KRProgressHUD

class LoginViewController: BaseViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnGoogle: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    
    @IBAction func btnLogin(_ sender: Any) {
        
        if Connectivity.isConnectedToInternet {
            if (txtFieldEmail.text == "" || txtFieldPassword.text == ""){
                self.alertShow(aTitle: "Alert!", aMessage: "Please fill all the fields")
            }else {

                KRProgressHUD.show(withMessage: "Please wait...")

                var pageNo : String = ""
                pageNo = Constants.ServerConfig.BASE_URLPHP
                let dict : NSDictionary = [
                    "username": self.txtFieldEmail.text!,
                    "pass": self.txtFieldPassword.text!,
                    "action": "login"
                ]

                ApiManager.sharedManager.requestForPost(urlQuery: pageNo, dictParam: dict) { (response, error) in

                    if error == nil, let dictResponse = response as? NSDictionary {
                        print(dictResponse["error"] as? String)

                        //   if (dictResponse as? NSObject) != nil {
                        let error = dictResponse["error"] as? String
                        if error == "0" {
                            KRProgressHUD.dismiss()
                        if let userData = dictResponse["data"] as? NSDictionary{
                            if let receiveData = userData["data"] as? NSDictionary{
                                
                                let id = receiveData["ID"] as? String
                                let user_login = receiveData["user_login"] as? String
                                let user_nicename = receiveData["user_nicename"] as? String
                                let user_email = receiveData["user_email"] as? String
                                let user_activation_key = receiveData["user_activation_key"] as? String
                                let display_name = receiveData["display_name"] as? String
                                let user_status = receiveData["user_status"] as? String
                                
                                let userDict:[String:String] = ["id":id!, "user_login":user_login!, "user_nicename":user_nicename!, "user_email":user_email!, "user_activation_key":user_activation_key!, "display_name": display_name!, "user_status": user_status! ]
                                UserDefaults.standard.set(userDict, forKey: "userInfoDict")
                                let result = UserDefaults.standard.value(forKey: "userInfoDict")
                                print(result!)
                            }
                            }
                            //let message = dictResponse["message"] as? String
                            //self.alertShow(aTitle: "Alert!", aMessage: message!)
                            let verficationController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewControllerID") as! HomeViewController
                        self.navigationController?.pushViewController(verficationController, animated: true)
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

        
        
//        let verficationController = self.storyboard?.instantiateViewController(withIdentifier: "EmailVerificationViewControllerID") as! EmailVerificationViewController
//        self.navigationController?.pushViewController(verficationController, animated: true)
    }
    
    
    
    @IBAction func btnForgotPassword(_ sender: Any) {
        let loginController = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewControllerID") as! ForgotPasswordViewController
        self.navigationController?.pushViewController(loginController, animated: true)
    }
    
    @IBAction func btnFacebook(_ sender: Any) {
        let loginController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewControllerID") as! HomeViewController
        self.navigationController?.pushViewController(loginController, animated: true)
    }
    @IBAction func btnGoogle(_ sender: Any) {
        let loginController = self.storyboard?.instantiateViewController(withIdentifier: "SpecialOffersViewControllerID") as! SpecialOffersViewController
        self.navigationController?.pushViewController(loginController, animated: true)
    }
    @IBAction func btnEmail(_ sender: Any) {
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtFieldEmail.attributedPlaceholder = NSAttributedString(string:" Email",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        txtFieldEmail.clipsToBounds = true
        txtFieldEmail.layer.cornerRadius = 12.0
        
        txtFieldPassword.attributedPlaceholder = NSAttributedString(string:" Password",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        txtFieldPassword.clipsToBounds = true
        txtFieldPassword.layer.cornerRadius = 12.0
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
