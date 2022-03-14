import ARKit

extension ARRecordingViewController: ARSCNViewDelegate, ARSessionDelegate {
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        
//        let isAnyObjectInView = viewModel.virtualObjectLoader.loadedObjects.contains { object in
//            return sceneView.isNode(object, insideFrustumOf: sceneView.pointOfView!)
//        }
        let objectsPlaced = isVirtualObjectsPlaced
        
        DispatchQueue.main.async {
            self.updateFocusSquare(isObjectVisible: objectsPlaced)
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else { return }
//        DispatchQueue.main.async {
//            if self.virtualObjectLoader.loadedObjects.isEmpty {
//                self.statusViewController.scheduleMessage("TAP + TO PLACE AN OBJECT", inSeconds: 7.5, messageType: .contentPlacement)
//            }
//        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        updateQueue.async {
            if let objectAtAnchor = self.viewModel.virtualObjectLoader.loadedObjects.first(where: { $0.anchor == anchor }) {
                objectAtAnchor.simdPosition = anchor.transform.translation
                objectAtAnchor.anchor = anchor
            }
        }
    }
    
    /// - Tag: ShowVirtualContent
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
//        statusViewController.showTrackingQualityInfo(for: camera.trackingState, autoHide: true)
//        switch camera.trackingState {
//        case .notAvailable, .limited:
//            statusViewController.escalateFeedback(for: camera.trackingState, inSeconds: 3.0)
//        case .normal:
//            statusViewController.cancelScheduledMessage(for: .trackingStateEscalation)
//            showVirtualContent()
//        }
    }

    func showVirtualContent() {
        viewModel.virtualObjectLoader.loadedObjects.forEach { $0.isHidden = false }
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
//        guard error is ARError else { return }
//
//        let errorWithInfo = error as NSError
//        let messages = [
//            errorWithInfo.localizedDescription,
//            errorWithInfo.localizedFailureReason,
//            errorWithInfo.localizedRecoverySuggestion
//        ]
//
//        let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")
//
//        DispatchQueue.main.async {
//            self.displayErrorMessage(title: "The AR session failed.", message: errorMessage)
//        }
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Hide content before going into the background.
        hideVirtualContent()
    }
    
    /// - Tag: HideVirtualContent
    func hideVirtualContent() {
        viewModel.virtualObjectLoader.loadedObjects.forEach { $0.isHidden = true }
    }

    /*
     Allow the session to attempt to resume after an interruption.
     This process may not succeed, so the app must be prepared
     to reset the session if the relocalizing status continues
     for a long time -- see `escalateFeedback` in `StatusViewController`.
     */
    /// - Tag: Relocalization
    func sessionShouldAttemptRelocalization(_ session: ARSession) -> Bool {
        return true
    }
    
}