//
//  SpecialOffersCollectionViewCell.swift
//  Room Services
//
//  Created by Muhammad Amir on 8/22/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit

class SpecialOffersCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var imageRoundView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        imageRoundView.layer.cornerRadius = imageRoundView.frame.width/2
        imageRoundView.layer.borderWidth = 0.5
       // imageRoundView.clipsToBounds = true
    }
}
