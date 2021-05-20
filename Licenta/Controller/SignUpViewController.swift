//
//  SignUpViewController.swift
//  Licenta
//
//  Created by Beuca Alexandru on 09.03.2021.
//

import UIKit
import FirebaseAuth
import Firebase
class SignUpViewController: UIViewController {
    @IBOutlet weak var numeTextField: UITextField!
    @IBOutlet weak var adresaTextField: UITextField!
    @IBOutlet weak var numarTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var parolaTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleElements()

    }
    
    func styleElements()
    {
        errorLabel.alpha = 0
        Utilities.styleTextField(numeTextField)
        Utilities.styleTextField(adresaTextField)
        Utilities.styleTextField(numarTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(parolaTextField)
        Utilities.styleFilledButton(signUpButton)
    }

    @IBAction func signUpPressed(_ sender: UIButton) {
        
        let error = validateFields()
        if error != nil {
            showError(error!)
            
        }
        
        else
        {
            let nameUser = numeTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let addressUser = adresaTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let numberUser = numarTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let emailUser = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let passwordUser = parolaTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: emailUser, password: passwordUser) { (result, err) in
                if  err != nil {
                    self.showError("Eroare creeare utilizator.")
                }
                
                else
                {
                    let db = Firestore.firestore()
                    let userID = (Auth.auth().currentUser?.uid)!
                    //db.collection("Users").addDocument(data: ["name": nameUser, "address": addressUser, "phoneNumber": numberUser, "uid": result!.user.uid]) { (error) in
                    db.collection("Users").document(userID).setData(["name": nameUser, "address": addressUser, "phoneNumber": numberUser,"email": emailUser, "uid": result!.user.uid]) { (error) in
                        if error != nil
                        {
                            self.showError("Eroare la salvarea datelor")
                        }
                    }
                    self.transitionToHome()
                
                }
            }
            
        }
        
    }
    func transitionToHome() {
        
        let homeNavController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? UINavigationController
            
            view.window?.rootViewController = homeNavController
            view.window?.makeKeyAndVisible()
        
    }
    
    func validateFields() -> String?
    {
        //Check daca toate campurile sunt umplute
        if numeTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||  adresaTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || numarTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || parolaTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "please fill all the fields"
            
        }
        
        let cleanedPassword = parolaTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
       if Utilities.isPasswordValid(cleanedPassword) == false {
            return "Parola trebuie sa contina 8 caractere si un caracter special"
        }
        
        
        //Check if the password is secure
        return nil
        
    }
    
    func showError (_ message: String)
    {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    

}
