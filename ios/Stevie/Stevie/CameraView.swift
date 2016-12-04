//
//  CameraView.swift
//  Stevie
//
//  Created by Phillip Caudell on 03/12/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

import UIKit
import AVFoundation

protocol CameraViewDelegate {
    
    func cameraView(_:CameraView, image: UIImage)
}

class CameraView: UIView, AVCapturePhotoCaptureDelegate {
    
    let captureSession = AVCaptureSession()
    var previewLayer: AVCaptureVideoPreviewLayer?
    let stillImageOutput = AVCaptureStillImageOutput()
    var delegate: CameraViewDelegate?
    
    func start() {
        
        // Stop crashing my simulator thanks / too lazy for real error checking x
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            return
        #endif
        
        captureSession.sessionPreset = AVCaptureSessionPresetMedium
        
        do {
            let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
            let captureDeviceInput = try AVCaptureDeviceInput.init(device: captureDevice)
            captureSession.addInput(captureDeviceInput)
        } catch {
            
            print("Unable to start camera")
        }
        
        stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
        captureSession.addOutput(stillImageOutput)
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        self.layer.addSublayer(previewLayer!)
        
        captureSession.startRunning()
    }
    
    override func layoutSubviews() {
        previewLayer?.frame = self.bounds
    }

    func requestImage() {
    
        if let videoConnection = stillImageOutput.connection(withMediaType: AVMediaTypeVideo) {
            
            stillImageOutput.captureStillImageAsynchronously(from: videoConnection) {
                (imageDataSampleBuffer, error) -> Void in
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                let image = UIImage(data: imageData!)
                self.delegate?.cameraView(self, image: image!)
            }
        }
    }
}

