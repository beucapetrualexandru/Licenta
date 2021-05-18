
import Foundation
import UIKit
import FirebaseUI
import Firebase

protocol MenuControllerDelegate {
    func didSelectMenuItem(named: SideMenuItem)
}

enum SideMenuItem: String, CaseIterable{
    case home = "Restaurante"
    case info = "Profilul meu"
    case logout = "Log Out"
 
}

class MenuController: UITableViewController {

    public var delegate: MenuControllerDelegate?

     var menuItems: [SideMenuItem]


    init(with menuItems: [SideMenuItem]) {
        self.menuItems = menuItems
        
        super.init(nibName: nil, bundle: nil)
        let nib = UINib(nibName: "SideMenuCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SideMenuCell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
      
    }
    
    

    
    
    
    
    

    // Table
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell", for: indexPath) as! SideMenuCell
       // cell.textLabel?.text = menuItems[indexPath.row].rawValue
        let side = menuItems[indexPath.row].rawValue
        cell.sideLabel.text = side
        cell.sideImage.image = UIImage(named: side)
        
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Relay to delegate about menu item selection
        let selectedItem = menuItems[indexPath.row]
        
        delegate?.didSelectMenuItem(named: selectedItem)
    }

}
