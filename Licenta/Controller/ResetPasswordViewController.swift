//
//  ResetPasswordViewController.swift
//  Licenta
//
//  Created by Beuca Alexandru on 19.04.2021.
//

import UIKit
import Firebase

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var forgotButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()

       setUpElements()
    }
    
    func setUpElements() {
        

        Utilities.styleTextField(emailTextField)
        Utilities.styleFilledButton(forgotButton)
    }

    @IBAction func forgotPressed(_ sender: UIButton) {
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: emailTextField.text!) { (error) in
            if let error = error{
                let alert = UIAlertController(title: "Eroare!", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true  )
                return
                
            }
            let alerts = UIAlertController(title: "Succes", message: "E-mailul de resetare a parolei a fost trimis", preferredStyle: .alert)
            alerts.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alerts, animated: true, completion: nil )
            
        }
    }
    
}
