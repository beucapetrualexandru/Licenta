//
//  InfoViewController.swift
//  Licenta
//
//  Created by Beuca Alexandru on 18.04.2021.
//

import UIKit
import Firebase

struct Info {
    var address: String
    var name: String
    var phoneNumber: String
    
}

class InfoViewController: UITableViewController
{
    let cellReuseIdentifier = "Cell"
    
    var info: [Info] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCartProducts()
      // self.tableView.register(InfoTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
       
        navigationItem.title = "Profilul meu"
        
        
        
    }
    func getCartProducts() {
        
        let db = Firestore.firestore()
        let userID = (Auth.auth().currentUser?.uid)!
        db.collection("Users").document(userID).getDocument{  (document, error) in
            if let error = error {
                print(error)
                return
            } else {
                if let  document = document {
                    let data = document.data()
                    let newEntry = Info(address: data!["address"] as! String, name: data!["name"] as! String , phoneNumber: data!["phoneNumber"] as! String
                    )
                    
        
                    self.info.append(newEntry)
                }
            }
            
            DispatchQueue.main.async {
                //  self.datas = self.filteredData
                self.tableView.reloadData()
            }
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! InfoTableViewCell
        
        let infos = info[indexPath.row]
        cell.nameLabel.text = infos.name
        cell.adresLabel.text = infos.address
        cell.numarLabel.text = infos.phoneNumber
        
        
        return cell
    }
    
    
    
    

}




