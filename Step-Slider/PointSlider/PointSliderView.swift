//
//  PointSliderView.swift
//  PointSlider
//
//  Created by Pairmi, Vikram (US - Bengaluru) on 8/2/18.
//  Copyright © 2018 vikram. All rights reserved.
//

import UIKit

class PointSliderView: UIView {
    
    @IBOutlet weak var slider: PointSlider!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        let view =  viewFromNib()
        view.frame = bounds
        addSubview(view)
        slider.addTarget(self, action: #selector(sliderValueChanged(slider:forEvent:)), for: .valueChanged)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sliderTapped(gestureRecognizer:)))
        slider.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func viewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    @objc private func sliderValueChanged(slider: UISlider, forEvent: UIEvent) {
        if let touchEvent = forEvent.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                break
            case .moved:
                break
            case .stationary:
                break
            case .ended:
                UIView.animate(withDuration: 0.75, animations: {() in
                    self.slider.setValue(Float(lroundf(slider.value)), animated: true)
                })
            case .cancelled:
                break
            }
        }
        
    }
    
    @objc private func sliderTapped(gestureRecognizer: UIGestureRecognizer) {
        
        let pointTapped: CGPoint = gestureRecognizer.location(in: self)
        
        let positionOfSlider: CGPoint = slider.frame.origin
        let widthOfSlider: CGFloat = slider.frame.size.width
        let newValue = Float((pointTapped.x - positionOfSlider.x) * CGFloat(slider.maximumValue) / widthOfSlider)
        
        UIView.animate(withDuration: 0.75, animations: {() in
            self.slider.setValue(Float(lroundf(newValue)), animated: true)
        })
    }
}
