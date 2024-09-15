/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main entry point of the Hello World experience.
*/

import SwiftUI
import RealityKit
import WorldAssets

/// The main entry point of the Hello World experience.
@main
struct WorldApp: App {
    @State private var model = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ARViewContainer()
                .edgesIgnoringSafeArea(.all) // Full-screen AR view
        }
    }
    
    init() {
        // Remove any unnecessary system registration
        RotationComponent.registerComponent()
        RotationSystem.registerSystem()
    }
}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Load the USDZ object from the Limbo folder
        let objectAnchor = try! Entity.load(named: "limbo-fullrig") 
        let anchorEntity = AnchorEntity(world: [0, 0, -2]) 
        anchorEntity.addChild(objectAnchor)
        
        // Add the object to the AR view
        arView.scene.addAnchor(anchorEntity)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Any updates to the AR view go here.
    }
}

