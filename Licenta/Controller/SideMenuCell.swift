//
//  SideMenuCell.swift
//  Licenta
//
//  Created by Beuca Alexandru on 18.04.2021.
//

import UIKit

class SideMenuCell: UITableViewCell {

    @IBOutlet weak var sideImage: UIImageView!
    @IBOutlet weak var sideLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
