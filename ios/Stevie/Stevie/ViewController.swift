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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(cameraView)
        cameraView.delegate = self
        cameraView.start()
        
        self.view.backgroundColor = UIColor.white

        let gesture = UITapGestureRecognizer(target: self, action:#selector(self.capture))
        self.view.addGestureRecognizer(gesture)
        self.view.addSubview(overlayView)
        
        overlayView.state = .thinking
        
        actionButton = UIButton(type: .system)
        actionButton?.setImage(#imageLiteral(resourceName: "actionButton"), for: .normal)
        actionButton?.addTarget(self, action: #selector(self.capture), for: .touchUpInside)
        self.view.addSubview(actionButton!)
        
        testLabel.text = "Hello"
        testLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        testLabel.textColor = UIColor.red
        testLabel.backgroundColor = UIColor.black
        self.view.addSubview(testLabel)
    }
    
    override func viewWillLayoutSubviews() {
        
        super.viewWillLayoutSubviews()
        
        cameraView.frame = self.view.bounds
        overlayView.frame = self.view.bounds
        actionButton?.frame = CGRect(x: self.view.bounds.size.width / 2 - 44, y: self.view.bounds.size.height - 120, width: 88, height: 88)
    }

    func capture() {
        cameraView.requestImage()
    }
    
    func cameraView(_: CameraView, image: UIImage) {

        AppController.sharedController.detect(item: "cat", image: image, completion:{(confidence: Float) -> (Void) in
            print(confidence)
            self.testLabel.text = confidence.description
        })
    }
    
    func startListening() {
        
    }
}

