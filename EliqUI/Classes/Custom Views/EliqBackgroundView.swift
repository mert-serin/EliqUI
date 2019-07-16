//
//  EliqBackgroundView.swift
//  Eliq
//
//  Created by MS on 2019-07-01.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit
import EliqModels
class EliqBackgroundView: UIView {
    
    enum BackgroundTypes:Int{
        case plain, gradient
    }

    var brand:Brand!{
        get{
            return EliqModelsConfiguration.shared.brand
        }
    }
    
    @IBInspectable var backgroundType:Int = 0{
        didSet{
            setupBackgroundColorWith(backgroundType: BackgroundTypes(rawValue: backgroundType)!)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupBackgroundColorWith(backgroundType: BackgroundTypes(rawValue: backgroundType)!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setupBackgroundColorWith(backgroundType: BackgroundTypes(rawValue: backgroundType)!)
    }

    private func setupBackgroundColorWith(backgroundType:BackgroundTypes){
        if backgroundType == .gradient{
            setupGradient()
        }else{
            self.backgroundColor = brand.plainBackgroundColor
        }
    }
    
    private func setupGradient() {
        let cgColors: [CGColor] = [brand.topBarLeftColor.cgColor, brand.topBarRightColor.cgColor]
        self.setGradient(colors: cgColors, angle: brand.gradientAngle, alphaValue: 1.0)
    }

}
