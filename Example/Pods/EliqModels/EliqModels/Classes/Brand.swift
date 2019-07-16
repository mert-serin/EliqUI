//
//  Brand.swift
//  EliqModels
//
//  Created by MS on 2019-07-16.
//

import Foundation
import UIKit

public final class Brand{
    
    public var JSONFileName:String?{
        get{
            return nil
        }
    }
    
    public var signUpFlow:[FlowModel]!
    public var plainBackgroundColor:UIColor!{
        get{
            return UIColor.blue
        }
    }
    public var topBarLeftColor:UIColor!{
        get{
            return UIColor.black
        }
    }
    public var topBarRightColor:UIColor!{
        get{
            return UIColor.black
        }
    }
    public var gradientAngle:Double!{
        get{
            return 90.0
        }
    }
    
    func setSignUpFlow() -> [FlowModel]{
        if let url = EliqModelsConfiguration.shared.jsonFileURL {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                self.signUpFlow = try decoder.decode([FlowModel].self, from: data)
                return signUpFlow
            } catch {
                print("error:\(error)")
            }
        }
        return []
    }
}
