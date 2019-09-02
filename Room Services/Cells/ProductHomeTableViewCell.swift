//
//  ProductHomeTableViewCell.swift
//  Room Services
//
//  Created by Muhammad Amir on 8/1/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit

class ProductHomeTableViewCell: UITableViewCell {
    @IBOutlet weak var homeCollectionView: UICollectionView!
    var productCat = [AllProducts]()
    var brandList = [BrandsList]()
    var brandsArray = 0 //if brandsArray then it will be 1
    weak var delegate:CategoryRowDelegate?
    var sectionNumber = Int()
    var indax = Int()
    @IBOutlet weak var sectionView: UIView!
    
    @IBOutlet weak var lblSectionTitle: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
//        sectionView.layer.cornerRadius = 12.0 //trainerImage.frame.height/2
//        sectionView.clipsToBounds = true
//        sectionView.layer.shadowColor = UIColor.gray.cgColor
//        sectionView.layer.masksToBounds = false
//        sectionView.layer.shadowOffset = CGSize(width: 0.0 , height: 5.0)
//        sectionView.layer.shadowOpacity = 1.0
//        sectionView.layer.shadowRadius = 1.0
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
//    override func layoutSubviews() {
//        homeCollectionView.dataSource = self
//        //NOTE dogeCollectionView is the name I gave to the collectionView when making the outlet
//    }
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        //You would get something like "model.count" here. It would depend on your data source
//        return 10
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        let reuseIdentifier = "HomeCollectionViewCell"
////        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! HomeCollectionViewCell
//
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
//
//
//        /*
//         It's called doge.jpeg since I added an image of Shiba Inu in the project assets folder. You would import some information from a REST API or similar
//         */
//        cell.itemImage.image = UIImage(named: "categoryImage")
//
//        return cell
//    }
    
    //
    //    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    //
    //    }
 
    
    

}

extension ProductHomeTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if brandsArray == 1{
            return self.brandList.count
        }else{
        return self.productCat.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        if brandsArray == 3{
        let obj = self.productCat[indexPath.row]
        cell.lblProductName.text = obj.name
        cell.itemImage.sd_setImage(with: URL(string: obj.image), placeholderImage: UIImage(named: "placeholder.png"))
            cell.lblPrice.text = "KWD " + obj.price
        //print(obj.name)
            
            layoutIfNeeded()
            
            cell.imageRoundView.layer.cornerRadius = cell.imageRoundView.frame.width/7
            cell.imageRoundView.layer.borderWidth = 0.7
            cell.imageRoundView.clipsToBounds = true
            
            
        }
        if brandsArray == 2{
            let obj = self.productCat[indexPath.row]
            cell.lblProductName.text = obj.name
            cell.itemImage.sd_setImage(with: URL(string: obj.image), placeholderImage: UIImage(named: "placeholder.png"))
             cell.lblPrice.text = "KWD " + obj.price
            layoutIfNeeded()
            
            cell.imageRoundView.layer.cornerRadius = cell.imageRoundView.frame.width/7
            cell.imageRoundView.layer.borderWidth = 0.7
           // cell.itemImage.layer.borderColor = [UIColor.gray].CGColor
          //  cell.imageRoundView.clipsToBounds = true
            
        }
        if brandsArray == 1{
            let obj = self.brandList[indexPath.row]
            cell.lblProductName.text = obj.name
            cell.itemImage.sd_setImage(with: URL(string: obj.image), placeholderImage: UIImage(named: "placeholder.png"))
            cell.lblPrice.isHidden = true
            layoutIfNeeded()
            
            cell.imageRoundView.layer.cornerRadius = cell.imageRoundView.frame.width/2
            cell.imageRoundView.layer.borderWidth = 1.5
            // cell.itemImage.layer.borderColor = [UIColor.gray].CGColor
            //  cell.imageRoundView.clipsToBounds = true
            
        }
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //print("You selected cell #\(indexPath.item)!")
           indax = indexPath.item
        if delegate != nil {
            
            if brandsArray == 2{
                 sectionNumber = 2
                delegate?.cellTapped(index: indax, section: sectionNumber)
            }
            if brandsArray == 1{
                 sectionNumber = 1
                delegate?.cellTapped(index: indax, section: sectionNumber)
            }
            if brandsArray == 3{
                 sectionNumber = 3
                delegate?.cellTapped(index: indax, section: sectionNumber)
            }
            
            
            print("You selected cell #\(indexPath.item)!")
        }
//       
//        QaidaSubView.optionSelected = 1
//        QaidaSubView.qaidaSelected = indexPath.item+1
//        QaidaSubView.mainSelection = 2
//        QaidaSubView.subTitle = self.myApiArray[indexPath.row].name
        
    }
    
}

extension ProductHomeTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      //  let itemsPerRow:CGFloat = 4
      //  let hardCodedPadding:CGFloat = 5
        
        let width = (self.homeCollectionView.frame.size.width - 40 ) / 4;
        var height:CGFloat = 0
        if (Constants.DeviceType.IS_IPHONE_5){
            height = CGFloat(width + 56)
        }
        if (Constants.DeviceType.IS_IPHONE_6P){
            height = CGFloat(width + 60)
        }
        if (Constants.DeviceType.IS_IPHONE_X){
            height = CGFloat(width + 68)
        }
        
        return CGSize(width: width, height: height)

//        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
//        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
//        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
