//
//  ViewController.swift
//  Licenta
//
//  Created by Beuca Alexandru on 09.03.2021.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var logInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleElements()
     
        
    }

   func styleElements()
   {
    Utilities.styleFilledButton(logInButton)
   }

}

