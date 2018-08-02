//
//  StepSliderView.swift
//  Step-Slider
//
//  Created by Pairmi, Vikram (US - Bengaluru) on 8/2/18.
//  Copyright © 2018 vikram. All rights reserved.
//

import UIKit

class StepSliderView: UIView {
    
    @IBOutlet weak var slider: UISlider!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let view =  viewFromNib()
        view.frame = bounds
        addSubview(view)
        addTickMarks()
    }
    
    func viewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    @objc var stepWidth: Double {
        return Double(trackWidth) / Double(steps)
    }
    @objc var trackWidth: CGFloat {
        return self.bounds.size.width
    }
    
    @objc var steps: Int {
        return Int(slider.maximumValue - slider.minimumValue)
    }
    
    func addTickMarks() {
        let ticks = Int(slider.maximumValue)
        slider.addTarget(self, action: #selector(sliderValueChanged(slider:forEvent:)), for: .valueChanged)
        for tickIndex in 0...ticks {
            
            var thumbCenterX: CGFloat = 0
            var thumbCenterY: CGFloat = 0
            var offset: CGFloat = 0
            
            let trackRect = slider.trackRect(forBounds: slider.bounds)
            let thumbRect = slider.thumbRect(forBounds: slider.bounds,
                                             trackRect: trackRect,
                                             value: Float(tickIndex))
            switch tickIndex {
            case Int(slider.minimumValue):
                offset = (thumbRect.width / 2)
            case Int(slider.maximumValue):
                offset = -(thumbRect.width / 2)
            default:
                offset = 0.0
            }
            thumbCenterX = offset + CGFloat(Double(tickIndex) * stepWidth) - CGFloat(5.0 / 2)
            thumbCenterY = offset - CGFloat(5.0 / 2)
            let sliderDotView = UIView(frame: CGRect(x: thumbCenterX,
                                                     y: thumbCenterY,
                                                     width: 5.0,
                                                     height: 5.0))
            sliderDotView.layer.cornerRadius = 2.5
            sliderDotView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            slider.addSubview(sliderDotView)
        }
    }
    
    @objc func sliderValueChanged(slider: UISlider, forEvent: UIEvent) {
        if let touchEvent = forEvent.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                break
            case .moved:
                break
            case .stationary:
                break
            case .ended:
                slider.setValue(Float(lroundf(slider.value)), animated: true)
            case .cancelled:
                break
            }
        }
        
    }
}
