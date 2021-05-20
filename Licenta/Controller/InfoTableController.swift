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
    var emailAddress: String
    
}

class InfoTableController: UITableViewController
{
    let cellReuseIdentifier = "InfoTableCell"
    
    var info: [Info] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
           getCartProducts()
        let nib = UINib(nibName: "InfoCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "InfoCell")
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
                    guard let address = data?["address"] as? String else {return}
                    guard let  name = data?["name"] as? String else {return}
                    guard let phoneNumber = data?["phoneNumber"] as? String else {return}
                    guard let emailAddress = data?["email"] as? String else {return}
                    let newEntry = Info(address: address, name: name , phoneNumber: phoneNumber, emailAddress: emailAddress)
                    
                    
        
                    self.info.append(newEntry)
                }
            }
            
            DispatchQueue.main.async {
                //  self.datas = self.filteredData
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as! InfoCell
        
        let infos = info[indexPath.row]
    
        cell.numeB.text = infos.name
        cell.numeB.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        cell.adresaB.text = infos.address
        cell.adresaB.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        cell.telefonB.text = infos.phoneNumber
        cell.telefonB.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        cell.emailB.text = infos.emailAddress
        cell.emailB.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        
        return cell
    }
    
    
    
    

}




