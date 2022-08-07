//
//  AugmentedRealityViewController.swift
//  RealtimeNumberReader
//
//  Created by Wylan L Neely on 8/7/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit
import RealityKit
import ARKit

class AugmentedRealityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //createAREntity()
    }
    
    @IBOutlet weak var arView: ARView!
    
    func createAREntity () {
        
        let mesh = MeshResource.generateBox(size: 0.2)
        let material = SimpleMaterial(color: .red, isMetallic: true)
        let modelEntity = ModelEntity(mesh: mesh, materials: [material])
        let anchorEntity = AnchorEntity(plane: .horizontal)
        anchorEntity.addChild(modelEntity)
        arView.scene.addAnchor(anchorEntity)
        
    }
    
    @IBAction func addObject(_ sender: Any) {
        createAREntity()
    }
    func addARObjectToScene() {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
