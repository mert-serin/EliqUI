//
//  EliqOnboardingWithButtonView.swift
//  EliqUI
//
//  Created by MS on 2019-07-29.
//

import UIKit
import EliqModels

class EliqOnboardingWithButtonView: EliqOnboardingParentView,ViewImpl {
    
    @IBOutlet private weak var skipButton: EliqButton!
    @IBOutlet private weak var descriptionLabel: EliqLabel!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: EliqLabel!
    @IBOutlet private weak var stackView: EliqScrollableStackView!
    
    @IBOutlet var containerView: UIView!
    
    let kCONTENT_XIB_NAME = "EliqOnboardingWithButtonView"
    open var estimatedButtonHeight:CGFloat = 50
    
    open var viewModel:OnboardingModel!{
        didSet{
            skipButton.isHidden = viewModel.isSkippable
            titleLabel.text = viewModel.text
            descriptionLabel.text = viewModel.message
            
            if viewModel.links != nil{
                var addedButton:EliqButton!
                for link in viewModel.links!{
                    //TO-DO change it with enum values
                    if link.linkStyle == "underlined"{
                        addedButton = EliqButton(textColor: .white, backgroundColor: .clear)
                        addedButton.setTitleColor(.white, for: .normal)
                        addedButton.setAttributedTitle(NSAttributedString(string: link.linkText, attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single, NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
                    }else if link.linkStyle == "positive_button"{
                        addedButton = EliqButton(textColor: .white, backgroundColor: EliqModelsConfiguration.shared.brand.energyColor)
                        addedButton.setTitleColor(.white, for: .normal)
                        addedButton.setTitle(link.linkText, for: .normal)
                        addedButton.roundCornersWith(cornerRadius: 25)
                    }else if link.linkStyle == "negative_button"{
                        addedButton = EliqButton(textColor: EliqModelsConfiguration.shared.brand.energyColor, backgroundColor: .white)
                        addedButton.setTitleColor(.white, for: .normal)
                        addedButton.setTitle(link.linkText, for: .normal)
                        addedButton.roundCornersWith(cornerRadius: 25)
                    }
                }
                stackView.addView(view:addedButton, size:50)
            }
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commonInit() {
        let bundle = Bundle(for: EliqOnboardingWithButtonView.self)
        bundle.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        containerView.fixInView(self)
    }
    
    @IBAction func onTappedSkipButton(_ sender: UIButton) {
        skipButtonAction?()
    }
    
    
    
}
