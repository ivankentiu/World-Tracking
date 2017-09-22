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
        let node = SCNNode()
//        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
//        node.geometry = SCNCone(topRadius: 0.1, bottomRadius: 0.3, height: 0.3)
//        node.geometry = SCNCylinder(radius: 0.2, height: 0.2)
//        node.geometry = SCNSphere(radius: 0.1)
//        node.geometry = SCNTube(innerRadius: 0.2, outerRadius: 0.3, height: 0.5)
//        node.geometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.1)
//        node.geometry = SCNPlane(width: 0.2, height: 0.2)
//        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        
        let path = UIBezierPath()
        // align path exactly where our node is currently in position
        path.move(to: CGPoint(x:0, y: 0))
        // add line from this position
        path.addLine(to: CGPoint(x: 0, y: 0.2))
        // 0.2 meters above the previous line
        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
        path.addLine(to: CGPoint(x: 0.4, y: 0))
        // assign to geometry
        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        node.geometry = shape
        
        // specular light that is reflected off of a surface ( white light ) on works if default lighting is enabled
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        // randomvalues for x, y, z
//        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        node.position = SCNVector3(0 , 0, -0.7)
        
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
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    // use to place box in random directions instead of just one (random value in range that u give it)
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
}

