//
//  CartViewController.swift
//  Licenta
//
//  Created by Beuca Alexandru on 13.04.2021.
//

import UIKit
import Firebase
import FirebaseUI

struct Cart
{
    var photoKeyCart: String
    var foodCart: String
    var priceCart: Int
    
    
}

class CartViewController: UIViewController {
    
    var cart: [Cart] = []
    var foodCart: String!
    @IBOutlet  var cartTableView: UITableView!
    
    @IBOutlet weak var priceTotalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCartProducts()
        let nib = UINib(nibName: "CartTableViewCell", bundle: nil)
        cartTableView.register(nib, forCellReuseIdentifier: "CartTableViewCell")
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
    }
    func getCartProducts() {
        
        let db = Firestore.firestore()
        let userID = (Auth.auth().currentUser?.uid)!
        db.collection("CartDatabase").document(userID).collection("CartItems").getDocuments {  (document, error) in
            if let error = error {
                print(error)
                return
            } else {
                for document in document!.documents {
                    let data = document.data()
                    let newEntry = Cart(photoKeyCart: data["photoKeyCart"] as! String, foodCart: data["foodCart"] as! String , priceCart: data["priceCart"] as! Int
                    )
                    
                    
                    
                    
                    self.cart.append(newEntry)
                }
            }
            
            DispatchQueue.main.async {
                //  self.datas = self.filteredData
                self.cartTableView.reloadData()
            }
            
        }
    }
    
    
    
    
    
    
    
}

extension CartViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sum = 0
        
        for item in cart{
            sum += item.priceCart
        }
        
        priceTotalLabel.text = "\(sum) lei"
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cartTableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        let carts = cart[indexPath.row]
        let storageRef = Storage.storage().reference()
        let photoRef = storageRef.child(carts.photoKeyCart)
        cell.foodInCartPrice.text = " \(carts.priceCart) lei "
        cell.foodInCartName.text = carts.foodCart
        cell.foodInCartImage.sd_setImage(with: photoRef)
        cell.foodInCartImage.layer.borderWidth = 1
        cell.foodInCartImage.layer.masksToBounds = false
        cell.foodInCartImage.layer.borderColor = UIColor.black.cgColor
        cell.foodInCartImage.layer.cornerRadius = cell.foodInCartImage.frame.height/2
        cell.foodInCartImage.clipsToBounds = true
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cartTableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
            let carts = cart[indexPath.row]

            let storageRef = Storage.storage().reference()
            let photoRef = storageRef.child(carts.photoKeyCart)
            
            photoRef.delete { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("File deleted successfully")
                }
            }
        let db = Firestore.firestore()
            let name = cart[indexPath.row].foodCart
                    let user = Auth.auth().currentUser
                    let collectionReference = db.collection("CartDatabase").document((user?.uid)!).collection("CartItems")
            let query : Query = collectionReference.whereField("foodCart", isEqualTo: name)
                    query.getDocuments(completion: { (snapshot, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            for document in snapshot!.documents {
                                //print("\(document.documentID) => \(document.data())")
                                db.collection("CartDatabase").document((user?.uid)!).collection("CartItems").document("\(document.documentID)").delete()
                        }
                    }})
        
        
        
        
        cart.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        
    }
    
    
    
    
    
}
}
