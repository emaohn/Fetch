//
//  DisplayStoreViewController.swift
//  Fetch
//
//  Created by Emmie Ohnuki on 2/24/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit
import FirebaseDatabase
class DisplayStoreViewController: UIViewController {
    var data: DataSnapshot?
    var cart = [Item]()
    var dataLoaded = false
    var ref: DatabaseReference?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startScanButton: UIButton!
    @IBOutlet weak var purchaseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataLoaded = false
        retrieveData()
    }
    
    func retrieveData() {

    }
    
    @IBAction func startScanButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "openScanner", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "openScanner":
            guard let destination = segue.destination as? ScanViewController else {return}
            destination.cart = cart
            destination.data = self.data
        default: return
        }
    }
    
    @IBAction func purchaseButtonPressed(_ sender: Any) {
        ref?.child("K-Mart/requests/customer").setValue(cart)
    }
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
       tableView.reloadData()
    }
}

extension DisplayStoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell") as! ItemTableViewCell
        let item = cart[indexPath.row]
        cell.titleLabel.text = item.title
        cell.priceLabel.text = "\(item.price)"
        
        return cell
    }
    
    
}
