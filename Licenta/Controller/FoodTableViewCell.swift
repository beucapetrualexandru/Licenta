//
//  FoodTableViewCell.swift
//  Licenta
//
//  Created by Beuca Alexandru on 06.04.2021.
//

import UIKit

//protocol CustomCellDelegate {
   // func diddTapButtonCell (_ cell: FoodTableViewCell)
    
class FoodTableViewCell: UITableViewCell {
    
  //  var delegate: CustomCellDelegate?
    var didTapButton : (()->())?
  
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var foodNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    
    
    @IBAction func addToCart(_ sender: Any) {
       // delegate?.diddTapButtonCell(self)
        didTapButton?()
    }
    
    
    
}
