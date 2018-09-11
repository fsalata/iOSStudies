//
//  ViewController.swift
//  ARKitDemo
//
//  Created by Fabio Salata on 11/09/18.
//  Copyright © 2018 Fabio Salata. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.addTarget(self, action: #selector(segmentControlChanged), for: .valueChanged)
        
        addTapGestureToSceneView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.session.pause()
    }
    
    func addBox(x: Float = 0, y: Float = 0, z: Float = -0.2) {
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        box.materials = [material]

        
        let boxNode = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3(x, y, z)
        
        sceneView.scene.rootNode.addChildNode(boxNode)
    }
    
    func addText(x: Float = 0, y: Float = 0, z: Float = -0.2) {
        let text = SCNText(string: "BIN", extrusionDepth: 1)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        text.materials = [material]
        
        let textNode = SCNNode()
        textNode.geometry = text
        textNode.position = SCNVector3(x, y, z)
        textNode.scale = SCNVector3(0.01, 0.01, 0.01)
        
        sceneView.scene.rootNode.addChildNode(textNode)
        sceneView.autoenablesDefaultLighting = true
    }

    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        let tapLocation = recognizer.location(in: sceneView)
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else {
            let hitTestResultsWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
            
            if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
                let translation = hitTestResultWithFeaturePoints.worldTransform.translation
                segmentedControl.selectedSegmentIndex == 0 ? addBox(x: translation.x, y: translation.y, z: translation.z) : addText(x: translation.x, y: translation.y, z: translation.z)
            }
            
            return
        }
        node.removeFromParentNode()
    }
    
    @objc func segmentControlChanged(segment: UISegmentedControl) {
        print(segment.selectedSegmentIndex)
    }
}

extension float4x4 {
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
}

