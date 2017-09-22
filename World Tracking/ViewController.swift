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
    
    // declare config use to track the position and orientation of device relative to real world at all times (very important)
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // debug show features points(information about features in the world around) and world origin(starting position) (if properly detected) device remember position
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        // make sure it rans as soon as view is loaded!
        self.sceneView.session.run(configuration)
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add(_ sender: Any) {
        // node position in space (no shape, size, color)
        let node = SCNNode()
        
        // give the node a shape! (chamferRadius (how round the edges of box are)
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        
        // give it a color (diffuse = color of entire surface)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        // position in meters
        node.position = SCNVector3(0, 0, 0.3)
        
        // scene = display camera view of real world (position node here)
        // root node exactly where the starting position is!
        // what ever is place inside will be relative to root node
        // it inside but where is it positioned? nowhere?
        self.sceneView.scene.rootNode.addChildNode(node)
        
        
    }
    
}

