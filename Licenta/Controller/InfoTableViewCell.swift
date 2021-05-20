//
//  InfoTableViewCell.swift
//  Licenta
//
//  Created by Beuca Alexandru on 19.05.2021.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var numarLabel: UILabel!
    @IBOutlet weak var adresLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
