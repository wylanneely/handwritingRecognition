//
//  CanvasView.swift
//  HandWritingRecognition
//
//  Created by Wylan L Neely on 4/11/20.
//  Copyright © 2020 Wylan L Neely. All rights reserved.
//

import UIKit

class CanvasView: UIView {

    var lineColor: UIColor!
    var lineWidth: CGFloat!
    var path: UIBezierPath!
    var touchPoint: CGFloat!
    var startingPoint: CGFloat!
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.isMultipleTouchEnabled = false
        
        lineColor = UIColor.white
        lineWidth = 10
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        startingPoint touch?.location(in: self)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
