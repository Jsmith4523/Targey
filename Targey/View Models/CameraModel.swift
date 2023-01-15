//
//  CameraModel.swift
//  Targey
//
//  Created by Jaylen Smith on 12/25/22.
//

import Foundation
import SwiftUI
import AVFoundation


protocol BarcodeScannerDelegate: AnyObject {
    func didRecieveBarcodeObjectString(_ barcode: String)
}

protocol CameraDelegate: AnyObject {
    func didRecieveProcessedPhoto(_ photo: UIImage)
}

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate, AVCaptureMetadataOutputObjectsDelegate {
    
    weak var barcodeDelegate: BarcodeScannerDelegate?
    weak var cameraDelegate: CameraDelegate?
    
    @Published var deviceHasTorch = true
    @Published var torchIsOn = false
    
    @Published var stopScanningForObject = false
    
    @Published var previewLayer: AVCaptureVideoPreviewLayer!
    @Published var session = AVCaptureSession()
    @Published var output = AVCapturePhotoOutput()
    
    
    func setDelegate(barcodeDelegate: BarcodeScannerDelegate) {
        self.barcodeDelegate = barcodeDelegate
    }
    
    func setCameraDelegate(cameraDelegate: CameraDelegate) {
        self.cameraDelegate = cameraDelegate
    }
    
    func toggleTorch() {
        guard let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) else {
            print("This device is either a simulator or a device without a camera. In other words, you cannot access the camera! Sorry...")
            return
        }
        
        self.torchIsOn.toggle()
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                device.torchMode = .on
                torchIsOn = true
            
                device.unlockForConfiguration()
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func checkForAccessToCamera() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .notDetermined:
            requestAccessToCamera()
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            beginSetup()
        @unknown default:
            requestAccessToCamera()
        }
    }
    
    private func requestAccessToCamera() {
        AVCaptureDevice.requestAccess(for: .video) { _ in
            self.checkForAccessToCamera()
        }
    }
    
    func beginSetup() {
            
        guard let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back) else {
            print("This device is either a simulator or a device without a camera. In other words, you cannot access the camera! Sorry...")
            return
        }
        
        if device.hasTorch || device.isTorchAvailable {
            self.deviceHasTorch = true
        }
      
        do {
            self.session.beginConfiguration()
            
            let input = try AVCaptureDeviceInput(device: device)
            
            if self.session.canAddInput(input) {
                self.session.addInput(input)
                self.session.commitConfiguration()
            } else {
                return
            }
            
            if !(cameraDelegate == nil) {
                outPutSessionWithCapture()
            } else if !(barcodeDelegate == nil) {
                outputSessionWithMetadata()
            }
        } catch {
            print(error.localizedDescription)
        }
        
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
        }
    }
    
    private func outputSessionWithMetadata() {
        let metadata = AVCaptureMetadataOutput()
        
        if self.session.canAddOutput(metadata) {
            self.session.addOutput(metadata)
            metadata.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadata.metadataObjectTypes = [.ean8, .ean13, .code128, .code93, .code39, .pdf417, .qr]
            
        } else {
            return
        }
    }
    
    private func outPutSessionWithCapture() {
        let output = AVCapturePhotoOutput()
        
        if self.session.canAddOutput(output) {
            self.session.addOutput(output)
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first, stopScanningForObject == false {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {
                return
            }
            
            guard let readableString = readableObject.stringValue else {
                return
            }
            
            let generator = UIImpactFeedbackGenerator(style: .rigid)
            generator.impactOccurred()
           
            session.stopRunning()
            
            barcodeDelegate?.didRecieveBarcodeObjectString(readableString)
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        session.stopRunning()
        guard let data = photo.fileDataRepresentation(), let photo = UIImage(data: data), error == nil else {
            return
        }
        cameraDelegate?.didRecieveProcessedPhoto(photo)
    }
    
    func relaunchSesson() {
        DispatchQueue.main.async {
            self.stopScanningForObject = false
        }
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now()) {
            self.session.startRunning()
        }
    }

    deinit {
        session.stopRunning()
    }
}

struct CameraSession: UIViewRepresentable {
    
    @ObservedObject var cameraModel: CameraModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            cameraModel.previewLayer = AVCaptureVideoPreviewLayer(session: cameraModel.session)
            cameraModel.previewLayer.frame = view.frame
            cameraModel.previewLayer.videoGravity = .resizeAspectFill
            
            view.layer.addSublayer(cameraModel.previewLayer)
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
    
    typealias UIViewType = UIView

}
