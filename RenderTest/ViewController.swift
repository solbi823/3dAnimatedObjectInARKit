//
//  ViewController.swift
//  RenderTest
//
//  Created by 최솔비 on 2018. 7. 24..
//  Copyright © 2018년 최솔비. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!

    
    var animations = [String : CAAnimation]()
    var idle : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene()
        
        // Set the scene to the view
        sceneView.scene = scene
        
//        //to make realistic light, turn off the default light.
//        sceneView.automaticallyUpdatesLighting = true

        
        let fileName = "fixedHipHop"
        
        //animationIdentifier is automatically being "filename-1", "filename-2"... like this.
        //So you should input correct identifier to trigger exact animation you want.
        let pathAndNameAndType = "art.scnassets/"+fileName+".dae"
        let pathAndName = "art.scnassets/"+fileName
        let animationIdentifier = fileName + "-1"
        
        let sambaNode = AniModel(fileName: pathAndNameAndType, scale: 0.005)
        sambaNode.loadAnimation(withKey: "sambaAni", sceneName: pathAndName, animationIdentifier: animationIdentifier)
    
        sambaNode.position = SCNVector3(x: 0, y: -1, z: -2)
        
        sceneView.scene.rootNode.addChildNode(sambaNode)
        
        sambaNode.playAnimation(key: "sambaAni")

        
//        add3dObject(fileName: "snake")
    }
    

    func add3dObject(fileName : String){
        
        let pathAndNameAndType = "art.scnassets/"+fileName+".dae"
        
        let objectScene = SCNScene(named: pathAndNameAndType)!
        
        let objectNode = SCNNode()
        
        for child in objectScene.rootNode.childNodes{
            objectNode.addChildNode(child)
        }

        objectNode.scale = SCNVector3(0.001, 0.001, 0.001)
        objectNode.position = SCNVector3(x: 0, y: -1, z: -80)
        
        
        sceneView.scene.rootNode.addChildNode(objectNode)
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
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
