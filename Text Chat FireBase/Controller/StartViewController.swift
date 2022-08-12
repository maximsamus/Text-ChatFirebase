//
//  StartViewController.swift
//  Text Chat FireBase
//
//  Created by Максим Самусь on 12.08.2022.
//

import UIKit

class StartViewController: UIViewController {
    
    
    @IBOutlet weak var appLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5723067522, green: 0.5723067522, blue: 0.5723067522, alpha: 1)
        registerButton.backgroundColor = #colorLiteral(red: 0, green: 0.3094544113, blue: 0.7490285039, alpha: 1)
        loginButton.backgroundColor = #colorLiteral(red: 0.9741447568, green: 0.9539191127, blue: 1, alpha: 1)
        
        appLabel.text = ""
        appLabel.textColor = #colorLiteral(red: 0.9413530231, green: 0, blue: 0, alpha: 1)
        appLabel.font = .boldSystemFont(ofSize: 50)
        var charIndex = 0.0
        let appLabelText = "TEXT📲 CHAT"
        for letter in appLabelText {
            Timer.scheduledTimer(withTimeInterval: 0.33 * charIndex, repeats: false) { timer in
                self.appLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }

    @IBAction func registerButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
    
    
}

