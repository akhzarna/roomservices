//
//  ViewController.swift
//  Room Services
//
//  Created by Muhammad Amir on 7/8/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit
import Alamofire
import SQLite3

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}
class ViewController: UIViewController {

    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnContinueGuest: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBAction func btnLogin(_ sender: Any) {
        let loginController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewControllerID") as! LoginViewController
        self.navigationController?.pushViewController(loginController, animated: true)
    }
    @IBAction func btnRegister(_ sender: Any) {
        let loginController = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewControllerID") as! RegisterViewController
        self.navigationController?.pushViewController(loginController, animated: true)
    }
    @IBAction func btnContinueGuest(_ sender: Any) {
        let loginController = self.storyboard?.instantiateViewController(withIdentifier: "CartViewControllerID") as! CartViewController
        self.navigationController?.pushViewController(loginController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

