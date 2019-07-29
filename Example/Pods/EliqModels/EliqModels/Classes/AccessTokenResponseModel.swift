//
//  AccessTokenResponseModel.swift
//  EliqModels
//
//  Created by MS on 2019-07-29.
//

import Foundation
public final class AccessTokenResponseModel:SystemActionResponseModel{
    public var data:AccessTokenDataModel
    
    enum CodingKeys: String, CodingKey{
        case data
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode(AccessTokenDataModel.self, forKey: .data)
        try super.init(from: decoder)
    }
}

public final class AccessTokenDataModel:Codable{
    public var accessToken:String
    public var tokenType:String
    public var expiresAt:String
    public var expiresIn:Double
    public var issuedAt:String
    public var userID:Int
    public var scope:String
    
    
    private enum CodingKeys: String, CodingKey{
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresAt = "expires_at"
        case expiresIn = "expires_in"
        case issuedAt = "issued_at"
        case userID = "user_id"
        case scope
    }
}
