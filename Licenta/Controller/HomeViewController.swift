//
//  HomeViewController.swift
//  Licenta
//
//  Created by Beuca Alexandru on 10.03.2021.
//
import SideMenu
import UIKit
import Firebase
import FirebaseUI
private var sideMenu: SideMenuNavigationController?



struct Category {
    let titles: String
    let photoKeyHome: String
}



class HomeViewController: UIViewController, MenuControllerDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var homeTableView: UITableView!
    
    private var sideMenu: SideMenuNavigationController?
    private let infoController = InfoViewController()
    var datas: [Category] = []
    var filteredData: [Category]!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDatabaseRecords()
        let menu = MenuController(with: SideMenuItem.allCases)
        menu.delegate = self
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        addChildControllers()
        filteredData = datas
        
        
        let nib = UINib(nibName: "homeTableViewCell", bundle: nil)
        homeTableView.register(nib, forCellReuseIdentifier: "homeTableViewCell")
        // Delegates
        homeTableView.dataSource = self
        homeTableView.delegate = self
        searchBar.delegate = self
        navigationItem.title = "Restaurante"
        homeTableView.separatorStyle = .none
        
    }
    
    private func addChildControllers() {
        addChild(infoController)
        view.addSubview(infoController.view)
        infoController.view.frame = view.bounds
        infoController.didMove(toParent: self)
        infoController.view.isHidden = true
    }
    
    
    @IBAction func didTapMenuButton(_ sender: UIBarButtonItem) {
        present(sideMenu!, animated: true)
    }
    func didSelectMenuItem(named: SideMenuItem) {
        sideMenu?.dismiss(animated: true, completion: nil)
        
        title = named.rawValue
        switch named {
        case .home:
            
            infoController.view.isHidden = true
            
        case .info:
            
            let infoViewController = self.storyboard?.instantiateViewController(identifier: "infoVC") as? UINavigationController
            
            self.view.window?.rootViewController = infoViewController
            self.view.window?.makeKeyAndVisible()
            
        case .logout:
            
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                let logOutNavController = self.storyboard?.instantiateViewController(identifier: "LogOut") as? UINavigationController
                
                self.view.window?.rootViewController = logOutNavController
                self.view.window?.makeKeyAndVisible()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
            
            
            
        }
    }
    
    
    func getDatabaseRecords() {
        
        let db = Firestore.firestore()
        //  Empty the array
        filteredData = []
        
        db.collection("HomeTableViewRestuarants").getDocuments { (snapshot, error) in
            if let error = error {
                print(error)
                return
            } else {
                for document in snapshot!.documents {
                    let data = document.data()
                    let newEntry = Category(
                        titles: data["title"] as! String,
                        photoKeyHome: data["photoKeyHome"] as! String
                        
                    )
                    
                    
                    
                    
                    self.filteredData
                        .append(newEntry)
                }
            }
            DispatchQueue.main.async {
                self.datas = self.filteredData
                self.homeTableView.reloadData()
            }
        }
    }
    
    
    
    
    
    
}






//MARK: - Table View

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! homeTableViewCell
        let restaurant = filteredData[indexPath.row]
        let storageRef = Storage.storage().reference()
        let photoRef = storageRef.child(restaurant.photoKeyHome)
        cell.myLabel.text = restaurant.titles
        cell.myImage.sd_setImage(with: photoRef)
        
        cell.myView.layer.cornerRadius = cell.myView.frame.height / 5
        cell.myImage.layer.cornerRadius = cell.myImage.frame.height / 5
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        homeTableView.deselectRow(at: indexPath, animated: true)
        //let vc = RestaurantViewControllerr()
        // vc.restaurantName = filteredData[indexPath.row].titles
        // navigationController?.pushViewController(vc, animated: true)
        let vc = RestaurantViewController()
        vc.restaurantName = filteredData[indexPath.row].titles
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
        
    }
    
    
}

extension HomeViewController: UISearchBarDelegate{
    //MARK: Search bar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredData = datas
        } else {
            filteredData = datas.filter{ $0.titles.range(of: searchText, options: .caseInsensitive) != nil  }
        }
        self.homeTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { // Dispare tastatura cand apasam pe search
        searchBar.resignFirstResponder()
        
    }
    
}




























