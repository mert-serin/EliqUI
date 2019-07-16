//
//  EliqButton.swift
//  Eliq
//
//  Created by MS on 2019-06-27.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit
import EliqModels
class EliqButton: UIButton {
    
    @IBInspectable var buttonBackgroundColor:UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    @IBInspectable var buttonCurrentTitleColor: UIColor = EliqModelsConfiguration.shared.brand.topBarLeftColor
    @IBInspectable var buttonCornerRadius:CGFloat = 0.0{
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
    
    required init?(coder aDecoder: NSCoder) {
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = buttonCornerRadius
    }
}
