//
//  CategoryItemsCollectionViewCell.swift
//  Room Services
//
//  Created by Muhammad Amir on 8/30/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit

class CategoryItemsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnAdd: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        itemImage.layer.cornerRadius = 7.0
        itemImage.layer.borderWidth = 0.5
        itemImage.clipsToBounds = true
    }
    
}
