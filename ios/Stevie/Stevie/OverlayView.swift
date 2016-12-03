//
//  OverlayView.swift
//  Stevie
//
//  Created by Phillip Caudell on 03/12/2016.
//  Copyright © 2016 Founders Factory. All rights reserved.
//

import UIKit

enum OverlayViewState {
    case idle
    case listening
    case thinking
    case found
    case error
}

class OverlayView: UIView {
    
    let topPartOfEye = UIView()
    var bottomPartOfEye: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    var state: OverlayViewState? {
        didSet {
            redraw()
        }
    }
    
    func redraw() {
        
        if state == .idle {
            self.backgroundColor = UIColor.blue
        }
        
        if state == .listening {
            self.backgroundColor = UIColor.green
        }
    }
}
