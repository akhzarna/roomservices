//
//  BrandProductsCollectionViewCell.swift
//  Room Services
//
//  Created by Muhammad Amir on 8/25/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit

class BrandProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageBorderView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var lblProductTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        imageBorderView.layer.cornerRadius = imageBorderView.frame.width / 2
//        imageBorderView.layer.borderWidth = 0.5
        imageBorderView.clipsToBounds = true
    }
    
}
