//
//  EliqLoginButton.swift
//  Eliq
//
//  Created by MS on 2019-07-02.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit
import SnapKit
import EliqModels

public typealias EliqLoginButtonCompletionHandler = ((String) -> Void)

open class EliqLoginButton:UIView{
    
    lazy open var button:EliqButton = {
        var b = EliqButton(type: UIButton.ButtonType.system)
        b.addTarget(self, action: #selector(onTappedButton), for: .touchUpInside)
        return b
    }()
    
    open var completionHandler:EliqLoginButtonCompletionHandler?
    open var viewModel:LoginButtonActionModel!
    
    convenience public init(model: LoginButtonActionModel, completionHandler:EliqLoginButtonCompletionHandler? = nil){
        self.init(frame: CGRect.zero)
        
        isUserInteractionEnabled = true
        self.viewModel = model
        self.completionHandler = completionHandler
    }
    
    public static func getLoginButtonView(for viewModel: LoginButtonActionModel, completion: @escaping EliqLoginButtonCompletionHandler) -> EliqLoginButton{
        var view:EliqLoginButton!{
            didSet{
                view.prepareUI()
            }
        }
        if viewModel.buttonType == .bottom{
            view = EliqLoginBottomButtonView(model: viewModel, completionHandler: completion)
        }else{
            if viewModel.buttonType == .call || viewModel.buttonType == .email{
                view = EliqContactOptionView(model: viewModel, completionHandler: completion)
            }else{
                view = EliqLoginButtonView(model: viewModel, completionHandler: completion)
            }
        }
        return view
    }
    
    func prepareUI(){
        fatalError("#### This method should override in child class ####")
    }
    
    @objc private func onTappedButton(){
        completionHandler?(viewModel.link)
    }
}

open class EliqLoginButtonView: EliqLoginButton{
    
    lazy var buttonLabel:EliqLabel = {
        var l = EliqLabel(labelStyle: EliqLabel.LabelStyles.paragraph, textColor: UIColor.white)
        l.numberOfLines = 0
        l.textAlignment = .center
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareUI(){
        if viewModel.text == nil{
            self.addSubview(button)
            
            button.snp.makeConstraints { (make) in
                make.left.right.equalTo(0)
                make.top.bottom.equalTo(0)
            }
            
            self.snp.updateConstraints { (make) in
                make.height.equalTo(50)
            }
        }else{
            self.addSubview(buttonLabel)
            self.addSubview(button)
            
            buttonLabel.snp.makeConstraints { (make) in
                make.left.equalTo(25)
                make.right.equalTo(-25)
                make.top.equalTo(20)
            }
            
            button.snp.makeConstraints { (make) in
                make.height.equalTo(50)
                make.left.equalTo(25)
                make.right.equalTo(-25)
                make.top.equalTo(buttonLabel.snp.bottom).offset(10)
            }
            
            buttonLabel.text = viewModel.text!
        }
        button.setTitle(viewModel.buttonText, for: .normal)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if viewModel.text != nil{
            self.snp.updateConstraints { (make) in
                make.height.equalTo(button.frame.maxY + 20)
            }
        }
        button.roundCornersWith(cornerRadius: button.frame.height / 2)
    }
    
}

open class EliqLoginBottomButtonView:EliqLoginButton{
    
    lazy var buttonLabel:EliqLabel = {
        var l = EliqLabel(labelStyle: .paragraph, textColor: EliqModelsConfiguration.shared.brand.topBarLeftColor)
        l.textAlignment = .center
        return l
    }()
    
    lazy var buttonRightImageView:UIImageView = {
        var i = UIImageView()
        i.tintColor = EliqModelsConfiguration.shared.brand.topBarLeftColor
        i.image = #imageLiteral(resourceName: "right-arrow").withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        return i
    }()
    
    override func prepareUI(){
        if viewModel.buttonType != .bottom{
            fatalError("### button type is not available for this UI View class ###")
        }
        
        self.addSubview(buttonLabel)
        self.addSubview(buttonRightImageView)
        self.addSubview(button)
        
        buttonLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self).offset(-15)
            make.centerY.equalTo(self)
        }
        
        buttonRightImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(20)
            make.left.equalTo(buttonLabel.snp.right).offset(10)
            make.centerY.equalTo(buttonLabel)
        }
        
        button.snp.makeConstraints { (make) in
            make.top.left.right.bottom.equalTo(0)
        }
        
        self.backgroundColor = .white
        self.button.backgroundColor = .clear
        buttonLabel.text = viewModel.buttonText
    }
}

open class EliqContactOptionView: EliqLoginButton {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet private weak var leftImageView: UIImageView!{
        didSet{
            
        }
    }
    @IBOutlet private weak var rightImageView: UIImageView!
    @IBOutlet private weak var viewDescriptionLabel: EliqLabel!
    @IBOutlet private weak var viewLabel: EliqLabel!
    
    let kCONTENT_XIB_NAME = "EliqContactOptionView"
    
    //MARK: Overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle(for: EliqTextField.self)
        bundle.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        containerView.fixInView(self)
    }
    
    override open func layoutSubviews() {
        super.layoutIfNeeded()
        
        if  viewModel.text == nil{
            self.snp.updateConstraints { (make) in
                make.height.equalTo(70)
            }
        }else{
            self.snp.updateConstraints { (make) in
                make.height.equalTo(viewDescriptionLabel.frame.maxY + 20)
            }
        }
        
    }
    
    override func prepareUI() {
        viewLabel.text = viewModel.buttonText
        viewDescriptionLabel.text = viewModel.text
        
        rightImageView.image = #imageLiteral(resourceName: "keyboard-right-arrow-button").withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        leftImageView.image = UIImage(named: "contact-option-\(viewModel.buttonType.rawValue)")
        self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.backgroundColor = .clear
        
        self.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.width.height.equalTo(self)
        }
    }
    
}
