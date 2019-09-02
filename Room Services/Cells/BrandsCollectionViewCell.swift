//
//  BrandsCollectionViewCell.swift
//  Room Services
//
//  Created by Muhammad Amir on 7/28/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imageBorderView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
//        imageBorderView.layer.cornerRadius = imageBorderView.frame.width/2
//       // imageBorderView.clipsToBounds = true
//        imageBorderView.layer.borderWidth = 1.5
        
    }
    
}
