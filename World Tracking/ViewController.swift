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
        
        // enable default lighting (light that spreads across the entire scene)
        self.sceneView.autoenablesDefaultLighting = true
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func add(_ sender: Any) {
    
        // Door
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown

        // Body
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue

        // roof
        let node = SCNNode()
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        // specular light that is reflected off of a surface ( white light ) on works if default lighting is enabled
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red

        node.position = SCNVector3(0 , 0, -0.7) // roof of the house
        // rotation roof 180 x
        node.eulerAngles = SCNVector3(Float(180.degreesToRadians), 0, 0)
        
        boxNode.position = SCNVector3(0, -0.05, 0) // body of the house
        doorNode.position = SCNVector3(0, -0.02, 0.053)

        self.sceneView.scene.rootNode.addChildNode(node)

        // make cylinderNode a child of node
        node.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
//        self.sceneView.scene.rootNode.addChildNode(cylinderNode)

        
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
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // use to place box in random directions instead of just one (random value in range that u give it)
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

