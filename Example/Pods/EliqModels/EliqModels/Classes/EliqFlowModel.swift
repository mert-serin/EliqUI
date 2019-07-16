//
//  EliqFlowModel.swift
//  EliqModels
//
//  Created by MS on 2019-07-15.
//

import Foundation

public final class FlowModel:Codable{
    
    public var screenIdentifier:String
    public var title:String?
    public var rootView:Bool?
    public var text:String?
    public var links:[LoginButtonActionModel]?
    public var metaData:[MetaDataModel]?
    public var loginData:[LoginDataModel]?
    public var errors:[ErrorModel]?
    
    private enum CodingKeys: String, CodingKey{
        case title
        case text
        case links
        case errors
        case screenIdentifier = "screen_identifier"
        case rootView = "root_view"
        case metaData = "meta_data"
        case loginData = "login_data"
    }
}


public final class LoginButtonActionModel:Codable{
    
    public var buttonText:String
    public var type:String?
    public var buttonType:LoginButtonTypes!{
        get{
            if type != nil{
                return LoginButtonTypes(rawValue: type!)!
            }
            return .normal
        }
    }
    public var link:String
    public var text:String?
    private enum CodingKeys: String, CodingKey{
        case buttonText = "button_text"
        case link
        case type
        case text
    }
}

public final class MetaDataModel:Codable{
    public var type:String?
    public var value:String?
    public var name:String?
    public var text:String?
}

public final class LoginDataModel:Codable{
    public var type:String
    public var values:[MetaDataModel]
}

public final class ErrorModel:Codable{
    public var errorType:String
    public var title:String
    public var message:String
    
    private enum CodingKeys: String, CodingKey{
        case title
        case message
        case errorType = "error_type"
    }
}
