//
//  EliqModelsConfiguration.swift
//  EliqModels
//
//  Created by MS on 2019-07-16.
//

import Foundation

public final class EliqModelsConfiguration{
    
    public static var shared = EliqModelsConfiguration()
    public var brand:Brand!
    public var jsonFileURL:URL?
}
