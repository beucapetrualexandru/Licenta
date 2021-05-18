import UIKit
import Firebase
import FirebaseUI



struct Food {
    
    var photoKeyRestaurant: String
    var foodName: String
    var foodDescription: String
    var restaurantName: String
    var priceFood: Int
    
    
}







class RestaurantViewController: UIViewController {
    
   
    var restaurantName: String!
    var food: [Food] = []
   
  
    
    
    private let tableView: UITableView = {
        let table = UITableView()

        return table
    }()
    
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "cart"), style: .plain, target: self, action: #selector(rightButtonPressed(sender:)))
                navigationItem.rightBarButtonItems = [rightButton]
            

           
        getDatabaseRecords()
        view.backgroundColor = .systemBackground
        let nib = UINib(nibName: "FoodTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FoodTableViewCell")
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
      
        
       
        
       

    }
    
    @objc func rightButtonPressed(sender: UIBarButtonItem) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let cartVC = storyBoard.instantiateViewController(withIdentifier: "CartVC") as! CartViewController
        self.present(cartVC, animated: true, completion: nil)
       
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
       
    }
    
    func getDatabaseRecords() {
        
       
            
            let db = Firestore.firestore()
          food = []
            
        db.collection("RestaurantViewController").whereField("restaurantName", isEqualTo: restaurantName!).getDocuments { (snapshot, error) in
                if let error = error {
                    print(error)
                    return
                } else {
                    for document in snapshot!.documents {
                        let data = document.data()
                        let newEntry = Food(photoKeyRestaurant: data["photoKeyRestaurant"] as! String, foodName: data["foodName"] as! String, foodDescription: data["foodDescription"] as! String, restaurantName: data["restaurantName"] as! String , priceFood: data["priceLabel"] as! Int
                        )
                        
                            
                            
                            
                        self.food.append(newEntry)
                    }
                }
                DispatchQueue.main.async {
                 //  self.datas = self.filteredData
                   self.tableView.reloadData()
                }
            }
        }

    


    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    

   

}

extension RestaurantViewController: UITableViewDelegate, UITableViewDataSource
        
{
   
    
        
    func updateDocument(collection: String, newValueDict: [String : Any], completion:@escaping (Bool) -> Void = {_ in }) {
        
                    
                     let db = Firestore.firestore()
        let userID = (Auth.auth().currentUser?.uid)!
        db.collection(collection).document(userID).collection("CartItems").document().setData(newValueDict, merge: true){ err in
                        if let err = err {
                            print("Error writing document: \(err)")
                            completion(false)
                            
                        }else{
                            
                            completion(true)
                          
                           
                        }
                    }
                     
                 }
      
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell
        
       
       
     //   cell.delegate = self
        let mancare = food[indexPath.row]
        let storageRef = Storage.storage().reference()
        let photoRef = storageRef.child(mancare.photoKeyRestaurant)
        cell.foodImage.sd_setImage(with: photoRef)
        cell.descriptionLabel.text = mancare.foodDescription
        cell.foodNameLabel.text = mancare.foodName
        cell.priceLabel.text = "\(mancare.priceFood) lei"
        
        cell.didTapButton = {
            
            self.updateDocument(collection: "CartDatabase",newValueDict: ["foodCart" : mancare.foodName, "photoKeyCart": mancare.photoKeyRestaurant, "priceCart": mancare.priceFood])
           
        }
      
        //Fac ca imaginea sa fie cerc  - start
        
        cell.foodImage.layer.borderWidth = 1
        cell.foodImage.layer.masksToBounds = false
        cell.foodImage.layer.borderColor = UIColor.black.cgColor
        cell.foodImage.layer.cornerRadius = cell.foodImage.frame.height/2
        cell.foodImage.clipsToBounds = true
     
        //Fac ca imaginea sa fie cerc  - finish
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
