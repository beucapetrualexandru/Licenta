//
//  CartTableViewCell.swift
//  Licenta
//
//  Created by Beuca Alexandru on 14.04.2021.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var foodInCartName: UILabel!
    @IBOutlet weak var foodInCartImage: UIImageView!
    @IBOutlet weak var foodInCartPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
    
}
