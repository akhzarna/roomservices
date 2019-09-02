//
//  HomeCollectionViewCell.swift
//  Room Services
//
//  Created by Muhammad Amir on 8/1/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit

protocol CategoryRowDelegate:class {
    func cellTapped(index: Int, section: Int)
}

class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var imageRoundView: UIView!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
//        itemImage.layer.cornerRadius = 22.0//itemImage.frame.height/1.5
//        itemImage.layer.borderWidth = 2.0
//        itemImage.clipsToBounds = true
        
    }
    
    
}
