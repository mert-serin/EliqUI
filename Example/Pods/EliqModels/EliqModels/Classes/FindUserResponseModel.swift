//
//  FindUserResponseModel.swift
//  EliqModels
//
//  Created by MS on 2019-07-29.
//

import Foundation

public final class FindUserResponseModel:SystemActionResponseModel{
    public var data:[FindUserDataModel]
    
    enum CodingKeys: String, CodingKey{
        case data
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([FindUserDataModel].self, forKey: .data)
        try super.init(from: decoder)
    }
}

public final class FindUserDataModel:Codable{
    public var id:Int
}
