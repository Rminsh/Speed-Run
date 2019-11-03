//
//  SpeedMeterKit.swift
//  Speed Run
//
//  Created by Armin on 6/1/19.
//  Copyright © 2019 Armin Shalchian. All rights reserved.
//

import UIKit

public class SpeedMeterKit : NSObject {
    
    //// Drawing Methods
    
    @objc dynamic public class func drawSpeedMeter(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 250, height: 250), resizing: ResizingBehavior = .aspectFit, speed: CGFloat = 0, status: CGFloat = 0) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 250, height: 250), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 250, y: resizedFrame.height / 250)
        
        
        //// Color Declarations
        let borderColor = status == 0 ? UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000) : UIColor(red:1.00, green:0.42, blue:0.42, alpha:1.0)
        let speedTextColor = UIColor(red: 0.247, green: 0.638, blue: 0.949, alpha: 1.000)
        let kmhColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let pointerFillColor = UIColor(red: 0.883, green: 0.075, blue: 0.075, alpha: 1.000)
        
        //// Variable Declarations
        let speedRotation: CGFloat = -speed * 1
        let speedText = "\(Int(round(speed)))"
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 209.64, y: 229.91))
        bezierPath.addCurve(to: CGPoint(x: 246, y: 143.44), controlPoint1: CGPoint(x: 232.07, y: 207.95), controlPoint2: CGPoint(x: 246, y: 177.32))
        bezierPath.addCurve(to: CGPoint(x: 125, y: 22.44), controlPoint1: CGPoint(x: 246, y: 76.61), controlPoint2: CGPoint(x: 191.83, y: 22.44))
        bezierPath.addCurve(to: CGPoint(x: 4, y: 143.44), controlPoint1: CGPoint(x: 58.17, y: 22.44), controlPoint2: CGPoint(x: 4, y: 76.61))
        bezierPath.addCurve(to: CGPoint(x: 40.99, y: 230.53), controlPoint1: CGPoint(x: 4, y: 177.64), controlPoint2: CGPoint(x: 18.19, y: 208.52))
        bezierPath.move(to: CGPoint(x: 125, y: 20))
        bezierPath.addLine(to: CGPoint(x: 125, y: 28))
        bezierPath.move(to: CGPoint(x: 4, y: 144))
        bezierPath.addLine(to: CGPoint(x: 12, y: 144))
        bezierPath.move(to: CGPoint(x: 39.4, y: 228.5))
        bezierPath.addLine(to: CGPoint(x: 45.06, y: 223.23))
        bezierPath.move(to: CGPoint(x: 38.11, y: 58.4))
        bezierPath.addLine(to: CGPoint(x: 43.77, y: 64.06))
        bezierPath.move(to: CGPoint(x: 238, y: 144))
        bezierPath.addLine(to: CGPoint(x: 246, y: 144))
        bezierPath.move(to: CGPoint(x: 205.82, y: 223.11))
        bezierPath.addLine(to: CGPoint(x: 211.5, y: 228.3))
        bezierPath.move(to: CGPoint(x: 206.11, y: 64.18))
        bezierPath.addLine(to: CGPoint(x: 211.77, y: 58.53))
        borderColor.setStroke()
        bezierPath.lineWidth = 5
        bezierPath.stroke()
        
        
        //// Label 2 Drawing
        let label2Rect = CGRect(x: 89.2, y: 185, width: 71.6, height: 46)
        let label2TextContent = "KM/h"
        let label2Style = NSMutableParagraphStyle()
        label2Style.alignment = .center
        let label2FontAttributes = [
            .font: UIFont(name: "STHeitiTC-Light", size: 20)!,
            .foregroundColor: kmhColor,
            .paragraphStyle: label2Style,
            ] as [NSAttributedString.Key: Any]
        
        let label2TextHeight: CGFloat = label2TextContent.boundingRect(with: CGSize(width: label2Rect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: label2FontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: label2Rect)
        label2TextContent.draw(in: CGRect(x: label2Rect.minX, y: label2Rect.minY + (label2Rect.height - label2TextHeight) / 2, width: label2Rect.width, height: label2TextHeight), withAttributes: label2FontAttributes)
        context.restoreGState()
        
        
        //// Label Drawing
        let labelRect = CGRect(x: 62.17, y: 87, width: 124.65, height: 76)
        let labelStyle = NSMutableParagraphStyle()
        labelStyle.alignment = .center
        let labelFontAttributes = [
            .font: UIFont(name: "STHeitiTC-Light", size: 75)!,
            .foregroundColor: speedTextColor,
            .paragraphStyle: labelStyle,
            ] as [NSAttributedString.Key: Any]
        
        let labelTextHeight: CGFloat = speedText.boundingRect(with: CGSize(width: labelRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: labelFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: labelRect)
        speedText.draw(in: CGRect(x: labelRect.minX, y: labelRect.minY + (labelRect.height - labelTextHeight) / 2, width: labelRect.width, height: labelTextHeight), withAttributes: labelFontAttributes)
        context.restoreGState()
        
        
        //// Pointer
        context.saveGState()
        context.translateBy(x: 125.55, y: 144)
        context.rotate(by: -(speedRotation + 135) * CGFloat.pi/180)
        
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 0.94, y: -118.08))
        bezier3Path.addLine(to: CGPoint(x: 4.55, y: -96.43))
        bezier3Path.addCurve(to: CGPoint(x: 0.72, y: -91.07), controlPoint1: CGPoint(x: 4.97, y: -93.89), controlPoint2: CGPoint(x: 3.25, y: -91.49))
        bezier3Path.addCurve(to: CGPoint(x: -0.05, y: -91), controlPoint1: CGPoint(x: 0.46, y: -91.02), controlPoint2: CGPoint(x: 0.21, y: -91))
        bezier3Path.addCurve(to: CGPoint(x: -4.71, y: -95.66), controlPoint1: CGPoint(x: -2.62, y: -91), controlPoint2: CGPoint(x: -4.71, y: -93.09))
        bezier3Path.addCurve(to: CGPoint(x: -4.65, y: -96.43), controlPoint1: CGPoint(x: -4.71, y: -95.92), controlPoint2: CGPoint(x: -4.69, y: -96.17))
        bezier3Path.addLine(to: CGPoint(x: -1.04, y: -118.08))
        bezier3Path.addCurve(to: CGPoint(x: 0.11, y: -118.91), controlPoint1: CGPoint(x: -0.95, y: -118.63), controlPoint2: CGPoint(x: -0.43, y: -119))
        bezier3Path.addCurve(to: CGPoint(x: 0.94, y: -118.08), controlPoint1: CGPoint(x: 0.54, y: -118.84), controlPoint2: CGPoint(x: 0.87, y: -118.51))
        bezier3Path.close()
        bezier3Path.usesEvenOddFillRule = true
        pointerFillColor.setFill()
        bezier3Path.fill()
        
        
        
        context.restoreGState()
        
        context.restoreGState()
        
    }
    
    
    
    
    @objc(StyleKitNameResizingBehavior)
    public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.
        
        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }
            
            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)
            
            switch self {
            case .aspectFit:
                scales.width = min(scales.width, scales.height)
                scales.height = scales.width
            case .aspectFill:
                scales.width = max(scales.width, scales.height)
                scales.height = scales.width
            case .stretch:
                break
            case .center:
                scales.width = 1
                scales.height = 1
            }
            
            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
