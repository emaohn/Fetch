//
//  CreateUsernameViewController.swift
//  WPI App
//
//  Created by Emmie Ohnuki on 1/19/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseUI
import FirebaseAuth

class CreateUsernameViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.layer.shadowOffset = CGSize(width: 0, height: 1)
        usernameTextField.layer.shadowOpacity = 1
        usernameTextField.layer.shadowOffset = CGSize.zero
        usernameTextField.layer.shadowColor = UIColor.black.cgColor
        usernameTextField.layer.shadowRadius = 15
        usernameTextField.layer.cornerRadius = 10
        usernameTextField.layer.masksToBounds = true
        
        nextButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        nextButton.layer.shadowOpacity = 1
        nextButton.layer.shadowOffset = CGSize.zero
        nextButton.layer.shadowColor = UIColor.black.cgColor
        nextButton.layer.shadowRadius = 15
        nextButton.layer.cornerRadius = 10
        nextButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else {
                // handle error
                return
            }
            
            User.setCurrent(user, writeToUserDefaults: true)
            
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            if let initialViewController = storyboard.instantiateInitialViewController() {
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
