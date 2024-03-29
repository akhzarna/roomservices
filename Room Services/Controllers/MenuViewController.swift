//
//  MenuViewController.swift
//  Qari Ibrahim
//
//  Created by Muhammad Amir on 4/9/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    /**
     *  Array to display menu options
     */
    @IBOutlet var tblMenuOptions : UITableView!
    /**
     *  Transparent button to hide menu
     */
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    /**
     *  Array containing menu options
     */
    var arrayMenuOptions = [Dictionary<String,String>]()
    /**
     *  Menu button which was tapped to display the menu
     */
    var btnMenu : UIButton!
    /**
     *  Delegate of the MenuVC
     */
    
    var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuOptions.tableFooterView = UIView()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
    }
    
    func updateArrayMenuOptions(){
        arrayMenuOptions.append(["title":"Home"])
        arrayMenuOptions.append(["title":"Brands"])
        //arrayMenuOptions.append(["title":"Latest", "icon":"ic_latest"])
        //arrayMenuOptions.append(["title":"My Downloads", "icon":"ic_downloads"])
        arrayMenuOptions.append(["title":"Categories"])
        arrayMenuOptions.append(["title":"Hot Deals"])
        arrayMenuOptions.append(["title":"Special Offers"])
        arrayMenuOptions.append(["title":"Cart"])
        arrayMenuOptions.append(["title":"My Acount"])
        arrayMenuOptions.append(["title":"Settings"])
        arrayMenuOptions.append(["title":"Contact Us"])
        //arrayMenuOptions.append(["title":"Cart", "icon":"cart"])

        tblMenuOptions.reloadData()
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0
        print("delegate", self.delegate)
         if (self.delegate != nil) {
            var index = Int32(button.tag)
            print("index selected==", index)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
         }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        
        let myColor : UIColor = UIColor( red: 248.0/255.0, green: 246.0/255.0, blue:247/255.0, alpha: 1.0 )
//        if indexPath.row % 2 == 0  {
//            cell.backgroundColor = myColor
//        }else{
//            cell.backgroundColor = UIColor.white
//        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        //cell.backgroundColor = UIColor.white
        
        
        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
       // let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
        
        
        //for customFontFamily
       
        
       // imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
        //lblTitle.font = UIFontMetrics.default.scaledFont(for: customFontSubtitle!)
        lblTitle.adjustsFontForContentSizeCategory = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
   
}
