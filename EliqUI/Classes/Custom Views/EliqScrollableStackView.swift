//
//  EliqScrollableStackView.swift
//  Eliq
//
//  Created by MS on 2019-07-04.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

open class EliqScrollableStackView: UIView {
    
    enum StackTypes:Int{
        case horizontal, vertical
    }
    
    lazy open var scrollView:UIScrollView = {
        var s = UIScrollView()
        s.backgroundColor = .clear
        return s
    }()
    
    lazy open var contentView:UIView = {
        var v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    private var lastAddedView:UIView?
    @IBInspectable private var stackType:Int = 1
    @IBInspectable private var padding:CGFloat = 0.0
    
    convenience init(padding:CGFloat) {
        self.init(frame: CGRect.zero)
        self.padding = padding
        setupUI()
    }
    
    private func setupUI(){
        self.backgroundColor = UIColor.clear
        
        
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.scrollView)
            make.left.right.equalTo(self)
            make.width.equalTo(self.scrollView)
            make.height.equalTo(self.scrollView)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if lastAddedView != nil{
            if StackTypes(rawValue: stackType) == .horizontal{
                
            }else{
                scrollView.contentSize = CGSize(width: self.frame.width, height: lastAddedView!.frame.maxY + padding)
            }
        }
    }
    
    open func addView(view:UIView, height:CGFloat){
        self.contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(height)
            if lastAddedView == nil{
                make.top.equalTo(0)
            }else{
                make.top.equalTo(lastAddedView!.snp.bottom).offset(padding)
            }
        }
        
        lastAddedView = view
    }
    
}
