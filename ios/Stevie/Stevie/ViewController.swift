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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(cameraView)
        cameraView.delegate = self
        cameraView.start()
        
        self.view.backgroundColor = UIColor.white
        
        let gesture = UITapGestureRecognizer(target: self, action:#selector(self.capture))
        self.view.addGestureRecognizer(gesture)
        
        imagePreview.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.view.addSubview(imagePreview)
        imagePreview.backgroundColor = UIColor.red
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        cameraView.frame = self.view.bounds
    }

    func capture() {
        cameraView.requestImage()
    }
    
    func cameraView(_: CameraView, image: UIImage) {
        print("got an image!")
        print(image)
    }
}

