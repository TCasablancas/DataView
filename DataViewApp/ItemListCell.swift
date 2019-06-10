//
//  ItemListCell.swift
//  DataViewApp
//
//  Created by Thyago on 10/06/19.
//  Copyright © 2019 tcasablancas. All rights reserved.
//

import UIKit

class ItemListCell: UITableViewCell {
    
    @IBOutlet weak var lblNameRepo: UILabel!
    @IBOutlet weak var lblOwnerRepo: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var containerImage: UIImageView!
    @IBOutlet weak var viewImage: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        viewImage.layer.cornerRadius = 25
        
        viewImage.addSubview(containerImage)
    }

}
