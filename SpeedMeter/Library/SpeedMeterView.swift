//
//  SpeedMeterView.swift
//  Speed Run
//
//  Created by armin on 6/1/19.
//  Copyright © 2019 Armin Shalchian. All rights reserved.
//

import UIKit

@IBDesignable
class SpeedMeterView: UIView {

    @IBInspectable var speed: CGFloat = 0
    @IBInspectable var status: CGFloat = 0

    override func draw(_ rect: CGRect) {
        SpeedMeterKit.drawSpeedMeter(frame: self.bounds, resizing: .aspectFit, speed: speed, status: status)
    }
    
    func setSpeed(_speed: CGFloat) {
        speed = _speed
        self.setNeedsDisplay()
    }
    
    func setStatus(_status: CGFloat) {
        status = _status
        self.setNeedsDisplay()
    }

}
