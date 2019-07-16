//
//  EliqButton.swift
//  Eliq
//
//  Created by MS on 2019-06-27.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit
import EliqModels

open class EliqButton: UIButton {
    
    @IBInspectable open var buttonBackgroundColor:UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    @IBInspectable open var buttonCurrentTitleColor: UIColor = EliqModelsConfiguration.shared.brand.topBarLeftColor
    @IBInspectable open var buttonCornerRadius:CGFloat = 0.0{
        didSet{
            layoutSubviews()
        }
    }
    
    convenience init(textColor:UIColor, backgroundColor:UIColor) {
        self.init(frame: CGRect.zero)
        
        setTitleColor(textColor, for: .normal)
        self.backgroundColor = backgroundColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtonUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButtonUI()
    }
    
    private func setupButtonUI(){
        self.backgroundColor = buttonBackgroundColor
        self.setTitleColor(buttonCurrentTitleColor, for: .normal)
        self.tintColor = buttonCurrentTitleColor
    }
    
    func roundCornersWith(cornerRadius:CGFloat? = nil){
        if cornerRadius == nil{
            buttonCornerRadius = self.frame.height / 2
        }else{
            buttonCornerRadius = cornerRadius!
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = buttonCornerRadius
    }
}
