//
//  CartTableViewCell.swift
//  Room Services
//
//  Created by Muhammad Amir on 8/22/19.
//  Copyright © 2019 Muhammad Amir. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var cellMainView: UIView!
    @IBOutlet weak var imageParentView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnSubtract: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
