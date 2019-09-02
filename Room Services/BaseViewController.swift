//
//  BaseViewController.swift
//  Qari Ibrahim
//
//  Created by Muhammad Amir on 4/9/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit
import Alamofire
//import KRActivityIndicatorView
import KRProgressHUD
var db: OpaquePointer?
var statement: OpaquePointer? = nil

let activityIndicator = UIActivityIndicatorView(style: .gray)

class BaseViewController: UIViewController, SlideMenuDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

       //  navigationController?.setNavigationBarHidden(true, animated: true)
       // self.view.addSubview(activityIndicator)
        // Do any additional setup after loading the view.
        //KRActivityIndicatorView(colors: [.blue])

    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //to hide statusBar
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    func slideMenuItemSelectedAtIndex(_ index: Int32) {
        let topViewController : UIViewController = self.navigationController!.topViewController!
        print("View Controller is : \(topViewController) \n", terminator: "")
        switch(index){
        case 0:
            print("CategoryHomeViewController\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("HomeViewControllerID")
            break
        case 1:
            print("MashqAfaalSalasiViewController\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("BrandsViewControllerID")
            break
//        case 2:
//            //print("ImtihanFaylViewController\n", terminator: "")
//            self.openViewControllerBasedOnIdentifier("MyDownloadsViewControllerID")
//
//            break
        case 2:
            print("ImtihanatKaRecordViewController\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("CategoryViewControllerID")
            break
        case 3:
            print("QuranKiMisalainViewController\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("LiveStreamViewControllerID")
            break
        case 4:
            print("RabtaViewController\n", terminator: "")
            // Akhzar Nazir For Now to avoid crash i am placing some other controller
        self.openViewControllerBasedOnIdentifier("SpecialOffersViewControllerID")
            break
        case 5:
            print("IsAppKayBarayMainViewController\n", terminator: "")
            self.openViewControllerBasedOnIdentifier("CartViewControllerID")
            break
        case 6:
            print("IsAppKayBarayMainViewController\n", terminator: "8")
            self.openViewControllerBasedOnIdentifier("MyAcountViewControllerID")
            break
        case 7:
            print("IsAppKayBarayMainViewController\n", terminator: "8")
            self.openViewControllerBasedOnIdentifier("ContactUsViewControllerID")
            break
        case 8:
            print("IsAppKayBarayMainViewController\n", terminator: "8")
            self.openViewControllerBasedOnIdentifier("SettingViewControllerID")
            break
        case 9:
            print("IsAppKayBarayMainViewController\n", terminator: "8")
            self.openViewControllerBasedOnIdentifier("CartViewControllerID")
            break
        default:
            print("default\n", terminator: "")
        }
    }
    
    func openViewControllerBasedOnIdentifier(_ strIdentifier:String){
        let destViewController : UIViewController = self.storyboard!.instantiateViewController(withIdentifier: strIdentifier)
        let topViewController : UIViewController = self.navigationController!.topViewController!
        if (topViewController.restorationIdentifier! == destViewController.restorationIdentifier!){
            print("Same VC")
        } else {
            self.navigationController!.pushViewController(destViewController, animated: true)
        }
    }
    
    func addSlideMenuButton(){
        let img = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        
        let btnShowMenu = UIButton(type: UIButton.ButtonType.custom)
        btnShowMenu.setImage(img, for: UIControl.State())
     //   let btnShowMenu = UIButton(type: UIButton.ButtonType.system)
      //  btnShowMenu.setImage(self.defaultMenuImage(), for: UIControl.State())
        
        if (Constants.DeviceType.IS_IPHONE_5){
             btnShowMenu.frame = CGRect(x: 18, y: 42, width: 29, height: 17)
        }
        if (Constants.DeviceType.IS_IPHONE_6P){
             btnShowMenu.frame = CGRect(x: 20, y: 44, width: 29, height: 17)
        }
        if (Constants.DeviceType.IS_IPHONE_X){
             btnShowMenu.frame = CGRect(x: 20, y: 68, width: 29, height: 17)
        }
       
        btnShowMenu.addTarget(self, action: #selector(BaseViewController.onSlideMenuButtonPressed(_:)), for: UIControl.Event.touchUpInside)
        btnShowMenu.layer.cornerRadius = 50
        
       // let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        self.view.addSubview(btnShowMenu)
//        self.navigationItem.leftBarButtonItem = customBarItem;
    }
    
//    func defaultMenuImage() -> UIImage {
//        var defaultMenuImage = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
//        //var image:UIImage =
//        UIGraphicsBeginImageContextWithOptions(CGSize(width: 24, height: 22), false, 0.0)
//        UIColor.black.setFill()
//        UIBezierPath(rect: CGRect(x: 0, y: 3, width: 30, height: 1)).fill()
//        UIBezierPath(rect: CGRect(x: 0, y: 10, width: 30, height: 1)).fill()
//        UIBezierPath(rect: CGRect(x: 0, y: 17, width: 30, height: 1)).fill()
//        UIColor.white.setFill()
//        UIBezierPath(rect: CGRect(x: 0, y: 4, width: 30, height: 1)).fill()
//        UIBezierPath(rect: CGRect(x: 0, y: 11,  width: 30, height: 1)).fill()
//        UIBezierPath(rect: CGRect(x: 0, y: 18, width: 30, height: 1)).fill()
//        defaultMenuImage = UIGraphicsGetImageFromCurrentImageContext()!
//        UIGraphicsEndImageContext()
//
//
//        return defaultMenuImage!;
//    }
    
    @objc func onSlideMenuButtonPressed(_ sender : UIButton){
        if (sender.tag == 100){
            // To Hide Menu If it already there
            self.slideMenuItemSelectedAtIndex(-1);
            sender.tag = 0;
            let viewMenuBack : UIView = view.subviews.last!
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })
            return
        }
//        self.navigationController?.setNavigationBarHidden(false, animated: false)
        sender.isEnabled = false
        sender.tag = 100
        let menuVC : MenuViewController = self.storyboard!.instantiateViewController(withIdentifier:"MenuViewController") as! MenuViewController
        menuVC.btnMenu = sender
        menuVC.delegate = self as? SlideMenuDelegate
        self.view.addSubview(menuVC.view)
        self.addChild(menuVC)
        menuVC.view.layoutIfNeeded()
        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
    }
    
    
    
  //  func dateFormatReturn(format:String,dateStringUtc:String) -> (String,String) {
        
//        let now = dateStringUtc
//        let dateStr = now.toDate(dateFormat: format)
//        let dateformatter = DateFormatter()
//
//        dateformatter.dateStyle = .medium
//        let dateString = dateformatter.string(from: dateStr!)
//        let chunks = String(dateString).components(separatedBy: ",")
//        //month date year
//        let myMonth = chunks[0].prefix(3) // Hello
//        let myDate = String(chunks[0].suffix(2)) // Hello
//        print(myMonth)
//        print(myDate)
//        return (myDate,String(myMonth))
        
  //  }
    
    
    
    func alertShow(aTitle:String,aMessage:String){
        
        
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: aTitle, message:
                aMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
     
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    
    
}
