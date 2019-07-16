//
//  EliqLabel.swift
//  Eliq
//
//  Created by MS on 2019-07-01.
//  Copyright © 2019 Mert Serin. All rights reserved.
//

import UIKit

struct EliqTextStyle{
    
    var font:UIFont
    var textStyle:NSUnderlineStyle?
    var textColor:UIColor
    
    static func getTextStyleFor(labelStyle:EliqLabel.LabelStyles, textColor:UIColor) -> EliqTextStyle{
        switch labelStyle {
        case .heading:
            return EliqTextStyle(font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.heavy), textStyle: nil, textColor: textColor)
        case .paragraph:
            return EliqTextStyle(font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular), textStyle: nil, textColor: textColor)
        case .subheading:
            return EliqTextStyle(font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular), textStyle: nil, textColor: textColor)
        case .subtext:
            return EliqTextStyle(font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light), textStyle: nil, textColor: textColor)
        }
    }
}

open class EliqLabel: UILabel {
    
    public enum LabelStyles:Int{
        case heading, subheading, paragraph, subtext
    }

    override open var text: String?{
        didSet{
            setupText(for: text)
        }
    }
    
    @IBInspectable var labelStyle:Int = 2{
        didSet{
            print(labelStyle)
            textStyle = EliqTextStyle.getTextStyleFor(labelStyle: LabelStyles(rawValue: labelStyle)!, textColor: textColor)
        }
    }
    private var textStyle:EliqTextStyle!{
        didSet{
            setupTextStyle()
        }
    }
    
    convenience init(labelStyle:LabelStyles, textColor:UIColor){
        self.init(frame: CGRect.zero)
        
        self.textColor = textColor
        self.labelStyle = labelStyle.rawValue
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var completionHandler:((String?)->())?
    var highligtedTexts:[(hg:String,link:String?)] = []
    
    
    private func setupText(for text:String?){
        guard let text = text else{
            return
        }
        
        var edittedText = text
        if let slices = text.find(pattern: "<a (.*?)</a>"){
            for slice in slices{
                let atts = slice.split(separator: ">")
                let highlightedText = atts[1].replacingOccurrences(of: "</a", with: "")
                let link = String(atts[0]).find(pattern: "\"(.*?)\"")?.first?.replacingOccurrences(of: "\"", with: "")
                highligtedTexts.append((highlightedText, link))
                edittedText = edittedText.replacingOccurrences(of: "\(atts[0])>\(atts[1])>", with: highlightedText)

            }
            let attributedString = NSMutableAttributedString(string: edittedText)
            for text in highligtedTexts{
                attributedString.addAttributes([NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)], range: (edittedText as NSString).range(of: text.hg))
            }
            self.attributedText = attributedString
            
            self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTappedLabel(tap:))))
        }
    }
    
    private func setupTextStyle(){
        self.textColor = textStyle.textColor
        self.font = textStyle.font
    }
    
    @objc private func onTappedLabel(tap:UITapGestureRecognizer){
        if completionHandler == nil{
            return
        }
        for texts in highligtedTexts{
            let range = (self.text! as NSString).range(of: texts.hg)
            if tap.didTapAttributedTextInLabel(label: self, inRange: range) {
                completionHandler!(texts.link)
                return
            }
        }
    }

}
