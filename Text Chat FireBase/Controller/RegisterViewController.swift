//
//  RegisterViewController.swift
//  Text Chat FireBase
//
//  Created by Максим Самусь on 12.08.2022.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var registerButtonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8672644496, green: 0.8492578864, blue: 0.8938599229, alpha: 1)
        registerButtonLabel.backgroundColor = #colorLiteral(red: 0, green: 0.3094544113, blue: 0.7490285039, alpha: 1)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: "RegisterToChat", sender: self)
                }
            }
        }
    }
}

