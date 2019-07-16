//
//  EliqCheckboxView.swift
//  Eliq
//
//  Created by MS on 2019-06-27.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

public struct EliqCheckboxViewModel{
    let title:String
    
    public init(title:String){
        self.title = title
    }
}

open class EliqCheckboxView:UIView{
    
    @IBOutlet open var containerView: UIView!
    @IBOutlet private weak var leftImageView: UIImageView!
    @IBOutlet private weak var viewLabel: EliqLabel!
    
    let kCONTENT_XIB_NAME = "EliqCheckboxView"
    
    private var canContinueWithoutChecking: Bool = false
    private var isChecked:Bool = false{
        didSet{
            if isChecked{
                leftImageView.image = checkedImage
            }else{
                leftImageView.image = uncheckedImage
            }
        }
    }
    private var checkedImage: UIImage = #imageLiteral(resourceName: "checkbox")
    private var uncheckedImage: UIImage = #imageLiteral(resourceName: "unchecked_box")
    open var viewModel:EliqCheckboxViewModel!{
        didSet{
            viewLabel.text = viewModel.title
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
    
    private func setupUI(){
        leftImageView.image = uncheckedImage
    }
    
    private func commonInit() {
        let bundle = Bundle(for: EliqTextField.self)
        bundle.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)
        containerView.fixInView(self)
        setupUI()
    }
    
    func isEligableToGoToNextStep() -> Bool{
        return isChecked
    }
    
    @IBAction private func onTappedViewButton(_ sender: UIButton) {
        isChecked = !isChecked
    }
    
}
