//
//  Enums.swift
//  EliqModels
//
//  Created by MS on 2019-07-15.
//

import Foundation

public enum LoginButtonTypes:String{
    case bottom = "bottom"
    case email = "email"
    case call = "call"
    case normal
    case sendEmailAgain = "send_email_again"
    case signUpFlowExternalRef = "sign_up_flow_external_ref"
    case sendTextMessage = "send_text_message"
}

public enum BrandTypes:String{
    case Bristol = "Bristol"
    case Robinhood = "Robinhood"
    case Eliq = "Eliq"
}
