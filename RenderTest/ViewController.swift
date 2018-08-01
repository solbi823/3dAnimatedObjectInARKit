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
        

        
        let fileName = "fixedHipHop"
        
        //animationIdentifier is automatically being "filename-1", "filename-2"... like this.
        //So you should input correct identifier to trigger exact animation you want.
        let pathAndNameAndType = "art.scnassets/"+fileName+".dae"
        let pathAndName = "art.scnassets/"+fileName
        let animationIdentifier = fileName + "-1"
        
        let sambaNode = addAnimatedNode(fileName: pathAndNameAndType, scale: 0.005)
        sambaNode.position = SCNVector3(x: 0, y: -1, z: -2)
        
        sceneView.scene.rootNode.addChildNode(sambaNode)
        loadAnimation(withKey: "sambaAni", sceneName: pathAndName, animationIdentifier: animationIdentifier)
        
//        add3dObject(fileName: "snake")
    }
    

    
    
    //this function returns 3d object node but you should use "load animation" function later to trigger the animation.
    //input file name and certain scale value you want.
    func addAnimatedNode(fileName: String, scale: Float)-> SCNNode {
        
        let objectNode = SCNNode()
        
        guard let objectScene = SCNScene(named: fileName) else{
            print("no file. ")
            return objectNode
        }
        
        for child in objectScene.rootNode.childNodes{
            objectNode.addChildNode(child)
        }
        
        objectNode.scale = SCNVector3(scale, scale, scale)
        
        return objectNode
        
    }
    
    
    //this is  function to trigger animation. you can choose the animation you want by animaitonIdentifier
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
