//
//  ViewController.swift
//  Fetch
//
//  Created by Emmie Ohnuki on 2/24/19.
//  Copyright © 2019 Emmie Ohnuki. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import FirebaseDatabase
class ScanViewController: UIViewController, ARSCNViewDelegate {
    var data: DataSnapshot?
    var addOptionOpen = false
    var cart: [Item]?
    
    var currentItem: Item?
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/scene.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
        
        NotificationCenter.default.addObserver(self, selector: #selector(toggleAddCart), name: NSNotification.Name("ToggleAddCart"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        containerBottomConstraint.constant = -100
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        configuration.detectionObjects = ARReferenceObject.referenceObjects(inGroupNamed: "Items", bundle: Bundle.main)!
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    @objc func toggleAddCart() {
        if addOptionOpen {
            containerBottomConstraint.constant = -100
            addOptionOpen = !addOptionOpen
        } else {
            containerBottomConstraint.constant = 24
            addOptionOpen = !addOptionOpen
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        switch identifier {
        case "back":
            guard let destination = segue.destination as? DisplayStoreViewController else {return}
            guard let cart = self.cart else {return}
            destination.cart = cart
        default: return
        }
    }
    
    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let objectAnchor = anchor as? ARObjectAnchor {
            let plane = SCNPlane(width: CGFloat(objectAnchor.referenceObject.extent.x * 0.8), height: CGFloat(objectAnchor.referenceObject.extent.y * 0.3))
            plane.cornerRadius = plane.width / 8
            let spriteKitScene = SKScene(fileNamed: "label.sks")
            
            plane.firstMaterial?.diffuse.contents = spriteKitScene
            plane.firstMaterial?.isDoubleSided = true
            plane.firstMaterial?.diffuse.contentsTransform = SCNMatrix4Translate(SCNMatrix4MakeScale(1, -1, 1), 0, 1, 0)
            let planeNode = SCNNode(geometry: plane)
            planeNode.position = SCNVector3Make(objectAnchor.referenceObject.center.x, objectAnchor.referenceObject.center.y + 0.1, objectAnchor.referenceObject.center.z)
            node.addChildNode(planeNode)
            
            if let itemName = objectAnchor.name {
                let catalog = data?.value as! [String: Any]
                let price = catalog["catalog"] as! [String: Any]
                let obj = price[itemName] as! Double
                let item = Item(title: itemName, price: obj)
                currentItem = item
                
                if let titleLabel = spriteKitScene?.childNode(withName: "title") as? SKLabelNode{
                    titleLabel.text = itemName
                }
                
                if let priceLabel = spriteKitScene?.childNode(withName: "price") as? SKLabelNode{
                    priceLabel.text = "\(obj)"
                }
            }
            toggleAddCart()
        }
        
        return node
    }
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
