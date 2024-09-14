/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main entry point of the Hello World experience.
*/

import SwiftUI
import RealityKit
import ARKit

@main
struct WorldApp: App {
    @State private var model = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    init() {
        // Register components if needed
        RotationComponent.registerComponent()
        RotationSystem.registerSystem()
    }
}

struct ARViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        // Load the USDZ object from the Limbo folder
        let objectAnchor = try! Entity.load(named: "limbo-fullrig") // Assuming 'example.usdz' is in Limbo
        
        // Add physics and collision components
        objectAnchor.components[PhysicsBodyComponent.self] = PhysicsBodyComponent(
            massProperties: .default,
            material: .default,
            mode: .dynamic // Makes the object react to forces and collisions
        )
        objectAnchor.components[CollisionComponent.self] = CollisionComponent(
            shapes: [.generateBox(size: [1.0, 1.0, 1.0])] // Adjust the size as necessary
        )

        // Add an anchor entity to hold the object
        let anchorEntity = AnchorEntity(world: [0, 0, -2]) // Position it 2 meters in front of the user
        anchorEntity.addChild(objectAnchor)
        
        // Add the anchor entity to the AR view
        arView.scene.addAnchor(anchorEntity)
        
        // Enable ARKit's collision detection
        arView.installGestures([.collision]) // Add collision detection gesture
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Update the AR view as needed.
    }
}
