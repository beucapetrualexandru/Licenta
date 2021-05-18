//
//  MenuViewController.swift
//  Licenta
//
//  Created by Beuca Alexandru on 18.04.2021.
//

import UIKit

enum MenuType: Int
{
    
    case home
    case profile
    case logout
}
class MenuViewController: UITableViewController
{
    var didTapMenuType: ((MenuType) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else {return}
        dismiss(animated: true) { [weak self ] in
        print("DDismissing: \(menuType)")
            self!.didTapMenuType?(menuType)
        
    }
    }
    
    
   
    

}
