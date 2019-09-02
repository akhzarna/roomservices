//
//  RelatedProductsCollectionViewCell.swift
//  Room Services
//
//  Created by Muhammad Amir on 8/21/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit

class RelatedProductsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImageBorder: UIView!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
       
       
        
    }
    
}
