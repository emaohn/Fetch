//
//  StoresViewController.swift
//  Fetch
//
//  Created by Emmie Ohnuki on 2/24/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit
import FirebaseDatabase

class StoresViewController: UIViewController {
    var ref: DatabaseReference!
    var stores = [DataSnapshot]()
    var dataRetrieved = false
    var selectedStoreIndex: Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        retrieveData()
    }
 
    func retrieveData() {
        let dataRef = Database.database().reference().child("store")
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        
        DispatchQueue.main.async {
            dataRef.observeSingleEvent(of: .value) { (snapshot) in
                
                guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {return }
                
                self.stores = [DataSnapshot]()
                
                for store in snapshot {
                    self.stores.append(store)
                }
                
                dispatchGroup.leave()
                self.dataRetrieved = true
                self.tableView.reloadData()
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "openStore":
            guard let destination = segue.destination as? DisplayStoreViewController, let selectedIndex = selectedStoreIndex else {return}
            destination.data = stores[selectedIndex]
        default: return
        }
    }

}

extension StoresViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataRetrieved{
            return stores.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeTableViewCell") as! StoreTableViewCell
        let data = stores[indexPath.row]
        let stuff = data.value as! [String: Any]
        let title = stuff["name"] as! String
        cell.titleLabel.text = title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedStoreIndex = indexPath.row
        self.performSegue(withIdentifier: "openStore" , sender: self)
    }
}
