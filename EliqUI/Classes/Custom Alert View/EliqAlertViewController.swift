//
//  EliqAlertViewController.swift
//  Eliq
//
//  Created by MS on 2019-07-04.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

struct EliqAlertViewModel{
    var title:String? = "Warning"
    var message:String?
    var alertButtons:[EliqAlertViewButtonModel] = []
}

struct EliqAlertViewButtonModel{
    var buttonTitle:String
    var buttonBackgroundColor:UIColor
    var buttonTextColor:UIColor
    var completion:(()->())?
}

class EliqAlertViewController: UIViewController {
    
    enum AnimationType{
        case appear, dismiss
    }
    
    lazy var containerView:UIView = {
        var v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 8
        return v
    }()
    
    lazy var errorLabel:EliqLabel = {
        var l = EliqLabel(labelStyle: EliqLabel.LabelStyles.paragraph, textColor: UIColor.black)
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()
    
    var errorModel:EliqAlertViewModel!{
        didSet{
            errorLabel.text = errorModel.message
            setupButtons()
        }
    }
    
    private var lastAddedButton:EliqButton?
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(containerView)
        self.containerView.addSubview(errorLabel)
        
        containerView.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.height.equalTo(150)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(-1500)
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.top.equalTo(30)
        }
    }
    
    override func viewDidLayoutSubviews() {
        containerView.snp.updateConstraints { (make) in
            if lastAddedButton != nil{
                make.height.equalTo(lastAddedButton!.frame.maxY + 20)
            }else{
                make.height.equalTo(50)
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            let hitView = self.view.hitTest(firstTouch.location(in: self.view), with: event)
            if !(hitView === containerView){
                animateViews(animationType: EliqAlertViewController.AnimationType.dismiss, completion: {
                    self.dismiss(animated: false, completion: nil)
                })
            }
        }
    }
    
    func animateViews(animationType:AnimationType, completion: (()->())?){
        self.containerView.snp.updateConstraints({ (make) in
            if animationType == .appear{
                make.centerY.equalTo(self.view)
            }else{
                make.centerY.equalTo(self.view).offset(1500)
            }
        })
        
        UIView.animate(withDuration: 0.3, delay: 0, options: UIView.AnimationOptions.curveEaseIn, animations: {[weak self] () -> Void in
            if animationType == .dismiss{
                self?.view.backgroundColor = .clear
            }
            self?.view.layoutIfNeeded()
            }, completion: {(finished) -> Void in
                completion?()
        })
    }
    
    private func setupButtons(){
        if errorModel.alertButtons.count == 2{
            setupButtonsForTwo()
        }else{
            for buttonModel in errorModel.alertButtons{
                let button = EliqButton(textColor: buttonModel.buttonTextColor, backgroundColor: buttonModel.buttonBackgroundColor)
                button.roundCornersWith(cornerRadius: 25)
                button.setTitle(buttonModel.buttonTitle, for: .normal)
                
                containerView.addSubview(button)
                
                button.snp.makeConstraints { (make) in
                    make.left.equalTo(25)
                    make.right.equalTo(-25)
                    make.height.equalTo(50)
                    if lastAddedButton != nil{
                        make.top.equalTo(lastAddedButton!.snp.bottom).offset(15)
                    }else{
                        make.top.equalTo(errorLabel.snp.bottom).offset(35)
                    }
                }
                lastAddedButton = button
            }
        }
    }
    
    private func setupButtonsForTwo(){
        let leftButtonModel = errorModel.alertButtons[0]
        let leftButton = EliqButton(textColor: leftButtonModel.buttonTextColor, backgroundColor: leftButtonModel.buttonBackgroundColor)
        leftButton.roundCornersWith(cornerRadius: 25)
        leftButton.setTitle(leftButtonModel.buttonTitle, for: .normal)
        
        let rightButtonModel = errorModel.alertButtons[1]
        let rightButton = EliqButton(textColor: rightButtonModel.buttonTextColor, backgroundColor: rightButtonModel.buttonBackgroundColor)
        rightButton.roundCornersWith(cornerRadius: 25)
        rightButton.setTitle(rightButtonModel.buttonTitle, for: .normal)
        
        containerView.addSubview(leftButton)
        containerView.addSubview(rightButton)
        
        leftButton.snp.makeConstraints { (make) in
            make.left.equalTo(25)
            make.width.equalTo(containerView).offset(-50).dividedBy(2)
            make.height.equalTo(50)
            make.top.equalTo(errorLabel.snp.bottom).offset(35)
        }
        
        rightButton.snp.makeConstraints { (make) in
            make.right.equalTo(-25)
            make.centerY.height.width.equalTo(leftButton)
        }
        
        lastAddedButton = leftButton
    }

}
