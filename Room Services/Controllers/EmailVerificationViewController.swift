//
//  EmailVerificationViewController.swift
//  Room Services
//
//  Created by Muhammad Amir on 7/28/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit

class EmailVerificationViewController: UIViewController {

    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var txtFieldFirst: UITextField!
    @IBOutlet weak var txtFieldSecond: UITextField!
    @IBOutlet weak var txtFieldThird: UITextField!
    @IBOutlet weak var txtFieldFourth: UITextField!
    @IBOutlet weak var btnSubmitt: UIButton!
    
    
    @IBAction func btnSubmitt(_ sender: Any) {
        let verficationController = self.storyboard?.instantiateViewController(withIdentifier: "VerificationViewControllerID") as! VerificationViewController
        self.navigationController?.pushViewController(verficationController, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        txtFieldFirst.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtFieldSecond.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtFieldThird.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)
        txtFieldFourth.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: .editingChanged)

    }
    
    @objc func textFieldDidChange(textField: UITextField)
    {
        let text = textField.text
        if text?.utf16.count == 1 {
            switch textField {
            case txtFieldFirst:
                txtFieldSecond.becomeFirstResponder()
            case txtFieldSecond:
                txtFieldThird.becomeFirstResponder()
            case txtFieldThird:
                txtFieldFourth.becomeFirstResponder()
            case txtFieldFourth:
                txtFieldFourth.resignFirstResponder()
            default:
                break
            }
        } else {
            switch textField {
            case txtFieldFourth:
                txtFieldThird.becomeFirstResponder()
            case txtFieldThird:
                txtFieldSecond.becomeFirstResponder()
            case txtFieldSecond:
                txtFieldFirst.becomeFirstResponder()
            case txtFieldFirst:
                txtFieldFirst.resignFirstResponder()
            default:
                break
            }
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

}
