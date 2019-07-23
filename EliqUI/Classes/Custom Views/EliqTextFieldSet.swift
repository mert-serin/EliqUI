//
//  EliqTextFieldSet.swift
//  Eliq
//
//  Created by MS on 2019-07-01.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

public struct EliqTextFieldSetViewModel{
    var numberOfTextField:Int
    var prePopulatedValue:String?
    var maxLength:Int
    
    public init(numberOfTextField:Int, prePopulatedValue:String?, maxLength:Int){
        self.numberOfTextField = numberOfTextField
        self.prePopulatedValue = prePopulatedValue
        self.maxLength = maxLength
    }
}

open class EliqBackwardTextField:UITextField{
    
    private var cornerRadius:CGFloat = 0.0
    open var completionHandlerOnDelete:((UITextField)->())?
    
    convenience public init(frame:CGRect, cornerRadius:CGFloat) {
        self.init(frame: frame)
        
        self.cornerRadius = cornerRadius
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func deleteBackward() {
        super.deleteBackward()
        
        completionHandlerOnDelete?(self)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = cornerRadius
    }
    
}

open class EliqTextFieldSet: UIView {
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private weak var stackView: UIStackView!
    
    let kCONTENT_XIB_NAME = "EliqTextFieldSet"
    private var textFields:[UITextField] = []
    @IBInspectable open var maxLength:Int = 1
    open var keyboardType:UIKeyboardType = .numberPad{
        didSet{
            textFields.forEach { (textField) in
                textField.keyboardType = keyboardType
            }
        }
    }
    open var viewModel:EliqTextFieldSetViewModel!{
        didSet{
            for i in 0..<viewModel.numberOfTextField{
                let customTextField = EliqBackwardTextField(frame: CGRect(x: 0, y: 0, width: 0, height: 50), cornerRadius: 5)
                customTextField.tag = i
                customTextField.placeholder = ""
                customTextField.textColor = .black
                customTextField.keyboardType = keyboardType
                customTextField.delegate = self
                customTextField.textAlignment = .center
                customTextField.completionHandlerOnDelete = {(textField) -> Void in
                    self.textFieldValueChange(textField: textField)
                }
                customTextField.addTarget(self, action: #selector(onChangedValueTextField(textField:)), for: UIControl.Event.editingChanged)
                if viewModel.prePopulatedValue != nil && i == 0{
                    customTextField.text = viewModel.prePopulatedValue!
                    customTextField.isUserInteractionEnabled = false
                    customTextField.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                }else{
                    customTextField.backgroundColor = .white
                }
                textFields.append(customTextField)
                stackView.addArrangedSubview(customTextField)
            }
            self.maxLength = viewModel.maxLength
        }
    }
    
    
    //MARK: Overrides
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open func getString() -> String{
        var string = ""
        textFields.forEach { (textField) in
            string += textField.text ?? ""
        }
        
        return string
    }
    
    private func commonInit() {
        let bundle = Bundle(for: EliqTextFieldSet.self)
        bundle.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        containerView.fixInView(self)
    }
    
    @objc private func onChangedValueTextField(textField:UITextField){
        textFieldValueChange(textField: textField)
    }
    
    private func textFieldValueChange(textField:UITextField){
        let tag = textField.tag
        if textField.text!.count < self.maxLength {
            if viewModel.prePopulatedValue != nil{
                if tag == 1{
                    return
                }
            }else{
                if tag == 0{
                    return
                }
            }
            textFields[tag - 1].becomeFirstResponder()
            return
        }
        if tag >= viewModel.numberOfTextField - 1 {
            textField.resignFirstResponder()
            return
        } else {
            textFields[tag+1].becomeFirstResponder()
        }
    }
    
}

extension EliqTextFieldSet:UITextFieldDelegate{
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = self.maxLength
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        if !(newString.length <= maxLength){
            textFieldValueChange(textField: textField)
        }
        return newString.length <= maxLength
    }
}
