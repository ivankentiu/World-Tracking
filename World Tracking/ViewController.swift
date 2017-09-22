//
//  ViewController.swift
//  World Tracking
//
//  Created by Ivan Ken Tiu on 21/09/2017.
//  Copyright © 2017 Ivan Ken Tiu. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add(_ sender: Any) {
        let node = SCNNode()
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.position = SCNVector3(0, 0, 0.3)
        self.sceneView.scene.rootNode.addChildNode(node)
        
        
    }
    
    
    @IBAction func reset(_ sender: Any) {
        
        self.restartSession()
        
    }
    
    func restartSession() {
        // stops keeping track of position or orientation
        self.sceneView.session.pause()
        
        // enumerate every single child node, and remove them
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        
        // resetTracking forget about old starting position and make a new one base on where you are at the moment
        // remove anchor(simple the imformation of the position and orientation of an object in sceneView(start from scratch)
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
}

