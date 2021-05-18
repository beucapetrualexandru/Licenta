//
//  SignInViewController.swift
//  Licenta
//
//  Created by Beuca Alexandru on 09.03.2021.
//

import UIKit
import Firebase
class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var parolaTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgotButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      styleElements()

    }
    
func styleElements()
{
    errorLabel.alpha = 0
    Utilities.styleTextField(emailTextField)
    Utilities.styleTextField(parolaTextField)
    Utilities.styleFilledButton(logInButton)
    
   
}
   
    @IBAction func forgotPressedd(_ sender: UIButton) {
    }
    @IBAction func loginPressed(_ sender: UIButton) {
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = parolaTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil
            {
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else
            {
                let homeNavController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? UINavigationController
                    
                self.view.window?.rootViewController = homeNavController
                self.view.window?.makeKeyAndVisible()

            }
            
        }

}
}
