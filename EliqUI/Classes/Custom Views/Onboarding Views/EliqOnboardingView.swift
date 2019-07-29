//
//  EliqOnboardingView.swift
//  EliqModels
//
//  Created by MS on 2019-07-29.
//

import UIKit
import EliqModels

open class EliqOnboardingParentView:UIView{
    open var skipButtonAction: (() -> ())?
    open var tapButtonAction: ((_ identifier:String) -> ())?
}

open class EliqOnboardingView: EliqOnboardingParentView,ViewImpl {

    @IBOutlet private weak var skipButton: UIButton!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet var containerView: UIView!
    
    let kCONTENT_XIB_NAME = "EliqOnboardingView"
    
    open var viewModel:OnboardingModel!{
        didSet{
            skipButton.isHidden = viewModel.isSkippable
            titleLabel.text = viewModel.text
            descriptionLabel.text = viewModel.message
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
        let bundle = Bundle(for: EliqOnboardingView.self)
        bundle.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        containerView.fixInView(self)
    }
    
    @IBAction private func onTappedSkipButton(_ sender: UIButton) {
        skipButtonAction?()
    }
    
}
