//
//  MainTableViewCell.swift
//  GBShop
//
//  Created by Антон Васильченко on 16.03.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var goodPicture: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
