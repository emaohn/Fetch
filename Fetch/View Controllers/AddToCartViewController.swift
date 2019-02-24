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
