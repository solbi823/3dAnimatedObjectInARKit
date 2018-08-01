//
//  3dAnimatedObjectClass.swift
//  RenderTest
//
//  Created by 최솔비 on 2018. 8. 1..
//  Copyright © 2018년 최솔비. All rights reserved.
//

import Foundation

import UIKit
import SceneKit
import ARKit


class AniModel : SCNNode {
    
    var fileName : String?
    
    var animations = [String : CAAnimation]()
    var idle : Bool = false

    //input file name and certain scale value you want.
    init(fileName: String, scale: Float) {
        
        super.init()
        
        self.fileName = fileName

        guard let objectScene = SCNScene(named: self.fileName!) else{
            print("no file. ")
            return
        }
        
        for child in objectScene.rootNode.childNodes{
            for key in child.animationKeys where child.animationPlayer(forKey: key) != nil
            {
                let player = child.animationPlayer(forKey: key)
                player?.stop()
            }
            
            self.addChildNode(child)
        }
        
        self.scale = SCNVector3(scale, scale, scale)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    //this is  function to load animation. you can register the animation you want by animaitonIdentifier
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
            self.animations[withKey] = animationObject
        }
    }
    
    //functions to trigger and stop certain animation. you can choose by key which you registered before.
    func playAnimation(key: String) {
        // Add the animation to start playing it right away
        self.addAnimation(animations[key]!, forKey: key)
        self.idle = true
    }
    
    func stopAnimation(key: String) {
        // Stop the animation with a smooth transition
        self.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
        self.idle = false
    }
    
    
}
