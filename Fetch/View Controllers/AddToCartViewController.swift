//
//  AddToCartViewController.swift
//  Fetch
//
//  Created by Emmie Ohnuki on 2/24/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit

class AddToCartViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cancelButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        cancelButton.layer.shadowOpacity = 1
        cancelButton.layer.shadowOffset = CGSize.zero
        cancelButton.layer.shadowColor = UIColor.black.cgColor
        cancelButton.layer.shadowRadius = 15
        cancelButton.layer.cornerRadius = 10
        cancelButton.layer.masksToBounds = true
        
        addButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        addButton.layer.shadowOpacity = 1
        addButton.layer.shadowOffset = CGSize.zero
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowRadius = 15
        addButton.layer.cornerRadius = 10
        addButton.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AddButtonPressed(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("addItem"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name("ToggleAddCart"), object: nil)
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
         NotificationCenter.default.post(name: NSNotification.Name("ToggleAddCart"), object: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
