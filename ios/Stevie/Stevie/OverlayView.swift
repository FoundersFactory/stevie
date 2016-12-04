//
//  OverlayView.swift
//  Stevie
//
//  Created by Rod on 03/12/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

import UIKit

enum OverlayViewState {
    case idle
    case listening
    case looking
    case found
    case error
}

class OverlayView: UIView {
    
    let overlayImageView = UIImageView()
    let speechButton = UIButton()
    let speechImageView = UIImageView()
    let speechTextLabel = UILabel()
    let spinnerImageView = UIImageView()
    let largeSpinnerImageView = UIImageView()
    
    var state: OverlayViewState? {
        didSet {
            redraw()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        overlayImageView.image = #imageLiteral(resourceName: "overlay")
        self.addSubview(overlayImageView)
        
        speechImageView.image = #imageLiteral(resourceName: "bubble")
        self.addSubview(speechImageView)
        
        speechTextLabel.text = "Hey! What can I help you find?"
        speechTextLabel.numberOfLines = 0
        speechTextLabel.textAlignment = .center
        self.addSubview(speechTextLabel)
        
        spinnerImageView.image = #imageLiteral(resourceName: "spinner")
        spinnerImageView.alpha = 1
        rotateView(spinnerView: spinnerImageView)
        self.addSubview(spinnerImageView)
        
        speechButton.setImage(#imageLiteral(resourceName: "actionButton"), for: .normal)
        self.addSubview(speechButton)
        
        largeSpinnerImageView.image = #imageLiteral(resourceName: "spinnerBig")
        rotateView(spinnerView: largeSpinnerImageView)
        largeSpinnerImageView.alpha = 1
        self.addSubview(largeSpinnerImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    

    override func layoutSubviews() {
        
        overlayImageView.frame = CGRect(x: 0, y:0, width: frame.size.width, height: frame.size.height)
        
        speechImageView.frame = CGRect(x: (frame.size.width/2) - ((frame.size.width*0.8)/2), y: (frame.size.height/5)-(frame.size.height/8), width: frame.size.width*0.8, height: frame.size.height/6);
        speechTextLabel.frame = CGRect(x: (frame.size.width/2) - ((frame.size.width*0.7)/2), y: (frame.size.height/5)-(frame.size.height/8), width: frame.size.width*0.7, height: (frame.size.height/6)-((frame.size.height/6)*0.1478))
        speechButton.frame =  CGRect(x: (frame.size.width/2)-30, y: frame.size.height-(frame.size.height/5), width: 60, height: 60)
        spinnerImageView.frame =  CGRect(x: speechButton.frame.origin.x-20, y: speechButton.frame.origin.y-20, width: 100, height: 100)
        largeSpinnerImageView.frame =  CGRect(x: (frame.size.width/2)-((frame.size.width*0.8)/2), y: (frame.size.height/2)-((frame.size.width * 0.8)/2), width: (frame.size.width*0.8), height: (frame.size.width * 0.8))
    }
    
    func redraw() {
        
        if state == .idle {
            spinnerImageView.alpha = 0.0
            largeSpinnerImageView.alpha = 0.0
        }
        
        if state == .listening {
            spinnerImageView.alpha = 1.0
        }
        
        if state == .looking {
            spinnerImageView.alpha = 0.0
            largeSpinnerImageView.alpha = 1.0
        }
    }
    
    func rotateView(spinnerView : UIImageView) {
        let animate = CABasicAnimation(keyPath: "transform.rotation")
        animate.duration = 1.5
        animate.repeatCount = Float.infinity
        animate.fromValue = 0.0
        animate.toValue = Float(M_PI * 2.0)
        spinnerView.layer.add(animate, forKey: "rotation")
    }
}
