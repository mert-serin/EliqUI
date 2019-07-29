//
//  LoginResponseModel.swift
//  EliqModels
//
//  Created by MS on 2019-07-22.
//

import Foundation

public final class LoginResponseModel:Codable{
    public var method:String
    public var debug:Bool
    public var data:LoginResponseDataModel
    
}

public final class LoginResponseDataModel:Codable{
    public var user:LoginResponseUserModel
    public var login:LoginResponseLoginModel
}

public final class LoginResponseUserModel:Codable{
    public var id:Int
    public var extRef:String
    public var username:String
    public var name:String
    public var forname:String
    public var surname:String
    public var phone:String
    public var createdDate:String
    public var email:String
    public var languageCode:String
    public var createdByClientID:Int
    public var plus:Bool
    public var addressID:Int
    public var isReadOnly:Bool
    public var lastLoginDate:String
    
    private enum CodingKeys: String, CodingKey{
        case id
        case extRef = "ext_ref"
        case username
        case name
        case forname
        case surname
        case phone
        case createdDate = "created_date"
        case email
        case languageCode = "language_code"
        case createdByClientID = "created_by_client_id"
        case plus
        case addressID = "address_id"
        case isReadOnly = "is_readonly"
        case lastLoginDate = "last_login_date"
    }
}

public final class LoginResponseLoginModel:Codable{
    public var type:String
    public var termsRequired:Bool
    public var policyRequired:Bool
    public var passwordRequired:Bool
    public var ticketID:String
    
    private enum CodingKeys: String, CodingKey{
        case type
        case termsRequired = "terms_required"
        case policyRequired = "policy_required"
        case passwordRequired = "password_required"
        case ticketID = "ticket_id"
    }
}
