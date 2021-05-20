//
//  InfoCell.swift
//  Licenta
//
//  Created by Beuca Alexandru on 20.05.2021.
//

import UIKit

class InfoCell: UITableViewCell {

    @IBOutlet weak var telefonB: UILabel!
    @IBOutlet weak var adresaB: UILabel!
    @IBOutlet weak var numeB: UILabel!
    @IBOutlet weak var emailB: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
