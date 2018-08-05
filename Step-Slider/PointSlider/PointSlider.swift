//
//  PointSlider.swift
//  PointSlider
//
//  Created by Pairmi, Vikram (US - Bengaluru) on 8/3/18.
//  Copyright © 2018 vikram. All rights reserved.
//

import UIKit

class PointSlider: UISlider {
    
    var pathHeight: CGFloat = 1
    var tickColor: UIColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
 
    var pathLeftOffset: CGFloat {
        let rect = rectForValue(minimumValue)
        return rect.width/2
    }
    var pathRightOffset: CGFloat {
        let rect = rectForValue(maximumValue)
        return rect.width/2
    }
    var pathWidth: CGFloat {
        return self.bounds.size.width
    }
    var tickWidth: Double {
        return Double(pathWidth) / Double(ticks)
    }
//    var tickDistance: Double {
//        return
//    }
    var ticks: Int {
        return Int(maximumValue - minimumValue)
    }
    
    override func draw(_ rect: CGRect) {
        drawPath()
    }
    private func rectForValue(_ value: Float) -> CGRect {
        let trackRect = self.trackRect(forBounds: bounds)
        let rect = thumbRect(forBounds: bounds, trackRect: trackRect, value: value)
        return rect
    }
    
    private func drawPath() {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0.0)
        let transparentImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setMaximumTrackImage(transparentImage, for: .normal)
        setMinimumTrackImage(transparentImage, for: .normal)
        
        context?.setFillColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
        
        let pathX = pathLeftOffset
        let pathY = bounds.midY - CGFloat(1/2)
        let rect = CGRect(x: pathX,
                          y: pathY,
                          width: bounds.width - pathLeftOffset - pathRightOffset,
                          height: pathHeight)
        let path = UIBezierPath(rect: rect)
        context?.addPath(path.cgPath)
        context?.fillPath()
        
        //Draw Tickpoints
        
        context?.setFillColor(tickColor.cgColor)
        
        for index in 0...ticks {
            var offSet: CGFloat = 0
            switch index {
            case Int(minimumValue):
                offSet = pathLeftOffset
            case Int(maximumValue):
                offSet = -pathRightOffset
            default:
                break
            }
        }
    }
    
    func addTickMarks() {
     //   slider.addTarget(self, action: #selector(sliderValueChanged(slider:forEvent:)), for: .valueChanged)
        for tickIndex in 0...ticks {
            
            var thumbCenterX: CGFloat = 0
            var thumbCenterY: CGFloat = 0
            var offSet: CGFloat = 0
            switch tickIndex {
            case Int(minimumValue):
                offSet = pathLeftOffset
            case Int(maximumValue):
                offSet = -pathRightOffset
            default:
                offSet = 0.0
            }
            thumbCenterX = offSet + CGFloat(Double(tickIndex) * tickWidth) - CGFloat(5.0 / 2)
            thumbCenterY = offSet - CGFloat(5.0 / 2)
            let sliderDotView = UIView(frame: CGRect(x: thumbCenterX,
                                                     y: thumbCenterY,
                                                     width: 5.0,
                                                     height: 5.0))
            sliderDotView.layer.cornerRadius = 2.5
            sliderDotView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            addSubview(sliderDotView)
        }
    }
}
