//
//  ViewController.swift
//  Stevie
//
//  Created by Phillip Caudell on 03/12/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CameraViewDelegate {
    
    let cameraView = CameraView()
    let imagePreview = UIImageView()
    let overlayView = OverlayView()
    var actionButton: UIButton?
    var testLabel = UILabel()
    var lookingForItem: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(cameraView)
        cameraView.delegate = self
        cameraView.start()
        
        self.view.backgroundColor = UIColor.white

        let gesture = UITapGestureRecognizer(target: self, action:#selector(self.capture))
        self.view.addGestureRecognizer(gesture)
        self.view.addSubview(overlayView)
        
//        actionButton = UIButton(type: .system)
//        actionButton?.setImage(#imageLiteral(resourceName: "actionButton"), for: .normal)
        overlayView.speechButton.addTarget(self, action: #selector(self.startListening), for: .touchUpInside)
//        self.view.addSubview(actionButton!)
        
//        testLabel.text = "Hello"
//        testLabel.frame = CGRect(x: 0, y: 0, width: 300, height: 100)
//        testLabel.textColor = UIColor.red
//        testLabel.backgroundColor = UIColor.black
//        self.view.addSubview(testLabel)
        
        overlayView.state = .idle
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        cameraView.frame = self.view.bounds
        overlayView.frame = self.view.bounds
//        actionButton?.frame = CGRect(x: self.view.bounds.size.width / 2 - 44, y: self.view.bounds.size.height - 120, width: 88, height: 88)
    }

    func capture() {
        cameraView.requestImage()
    }
    
    func cameraView(_: CameraView, image: UIImage) {
        
        if lookingForItem == nil {
            return
        }
        
        AppController.sharedController.detect(item: lookingForItem!, image: image, completion:{(confidence: Float) -> (Void) in

            
            // If we're not sure, keep looking
            if confidence < 0.8 {
                self.capture()
            }
            
            UIView.animate(withDuration: 0.5, animations: {() in
                
                if confidence <= 0.1 {
                    AppController.sharedController.speak(text: "Really cold", pitch: 1)
                    self.overlayView.speechTextLabel.text = "Really cold"
                    self.overlayView.warmOverlayImageView.alpha = 0.0
                } else if confidence <= 0.2 {
                    AppController.sharedController.speak(text: "Cold", pitch: 1)
                    self.overlayView.speechTextLabel.text = "Cold"
                    self.overlayView.warmOverlayImageView.alpha = 0.1
                } else if confidence <= 0.5 {
                    AppController.sharedController.speak(text: "Warm", pitch: 1)
                    self.overlayView.speechTextLabel.text = "Warm"
                    self.overlayView.warmOverlayImageView.alpha = 0.5
                } else if confidence <= 0.7 {
                    AppController.sharedController.speak(text: "Really warm!", pitch: 1.5)
                    self.overlayView.speechTextLabel.text = "Really warm"
                    self.overlayView.warmOverlayImageView.alpha = 1.0
                } else if confidence <= 0.8 {
                    AppController.sharedController.speak(text: "Found it", pitch: 1)
                    self.overlayView.speechTextLabel.text = "Found it"
                    self.overlayView.warmOverlayImageView.alpha = 0.0
                    self.lookingForItem = nil
                    self.overlayView.state = .idle
                }
            })
        })
    }
    
    func startListening() {
        
        overlayView.state = .listening
        
        AppController.sharedController.listen { (result, didUnderstand) -> (Void) in
            
            self.testLabel.text = result
            
            if didUnderstand {
                
                self.overlayView.speechTextLabel.text = "Looking for " + result!
                self.lookingForItem = result!
                self.capture()
                self.overlayView.state = .looking
                
            } else {
                self.overlayView.speechTextLabel.text = "I don't understand?"
                self.overlayView.state = .idle
            }
            
            AppController.sharedController.speak(text: self.overlayView.speechTextLabel.text!, pitch: 1)
        }
    }
}

