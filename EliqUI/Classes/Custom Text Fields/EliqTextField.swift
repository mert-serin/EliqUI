//
//  EliqTextField.swift
//  Eliq
//
//  Created by MS on 2019-06-27.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

class EliqTextField: UIView {

    let kCONTENT_XIB_NAME = "EliqTextField"
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet private weak var textFieldLabel: EliqLabel!
    var keyboardType:UIKeyboardType{
        get{
            return textField.keyboardType
        }set{
            textField.keyboardType = newValue
        }
    }
    var textAlignment:NSTextAlignment = .center{
        didSet{
            textField.textAlignment = textAlignment
        }
    }
    var textFieldRadius:CGFloat{
        get{
            return textField.layer.cornerRadius
        }set{
            textField.layer.cornerRadius = newValue
        }
    }
    var textFieldColor:UIColor?{
        get{
            return textField.textColor
        }set{
            textField.textColor = newValue
        }
    }
    
    var text:String{
        get{
            return textField.text ?? ""
        }set{
            textField.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        let bundle = Bundle(for: EliqTextField.self)
        bundle.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        containerView.fixInView(self)
        setupUI()
    }
    
    private func setupUI(){
        textField.textAlignment = textAlignment
        keyboardType = .emailAddress
        textFieldRadius = 5
        textFieldColor = .white
    }
    
    var placeholder:String?{
        didSet{
            textField.placeholder = placeholder
            textFieldLabel.text = placeholder
        }
    }
}
