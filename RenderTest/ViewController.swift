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
        
        add3dAnimation(fileName: "wolf")
//        add3dObject(fileName: "snake")
    }
    
    //you should put filename without .dae and path
    func add3dAnimation(fileName: String){
        
        let pathAndNameAndType = "art.scnassets/"+fileName+".dae"
        let pathAndName = "art.scnassets/"+fileName
        let animationIdentifier = fileName + "-1"
        
        let objectScene = SCNScene(named: pathAndNameAndType)!
      
        let objectNode = SCNNode()

        for child in objectScene.rootNode.childNodes{
            objectNode.addChildNode(child)
        }

        objectNode.scale = SCNVector3(1, 1, 1)
        objectNode.position = SCNVector3(x: 0, y: -1, z: -2)
        
        
        sceneView.scene.rootNode.addChildNode(objectNode)
        
        loadAnimation(withKey: "animation1", sceneName: pathAndName, animationIdentifier: animationIdentifier)

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
    
    func loadAnimation(withKey: String, sceneName : String, animationIdentifier: String){
        
        guard let sceneURL = Bundle.main.url(forResource: sceneName, withExtension: "dae") else{
            print("no file")
            return
        }
        let sceneSource = SCNSceneSource(url: sceneURL, options: nil)
        
        
        if let animationObject = sceneSource?.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self) {
            
            animationObject.usesSceneTimeBase = false
            animationObject.repeatCount = 1
            // To create smooth transitions between animations
            animationObject.fadeInDuration = CGFloat(1)
            animationObject.fadeOutDuration = CGFloat(0.5)
            
            
            // Store the animation for later use
            animations[withKey] = animationObject
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let location = touches.first!.location(in: sceneView)
//
//        // Let's test if a 3D Object was touch
//        var hitTestOptions = [SCNHitTestOption: Any]()
//        hitTestOptions[SCNHitTestOption.boundingBoxOnly] = true
//
//        let hitResults: [SCNHitTestResult]  = sceneView.hitTest(location, options: hitTestOptions)
//
//        if hitResults.first != nil {
//            if(idle) {
//                playAnimation(key: "animation1")
//            } else {
//                stopAnimation(key: "animation1")
//            }
//            idle = !idle
//            return
//        }
//    }
//
//    func playAnimation(key: String) {
//        // Add the animation to start playing it right away
//        sceneView.scene.rootNode.addAnimation(animations[key]!, forKey: key)
//    }
//
//    func stopAnimation(key: String) {
//        // Stop the animation with a smooth transition
//        sceneView.scene.rootNode.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
//    }
    
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
