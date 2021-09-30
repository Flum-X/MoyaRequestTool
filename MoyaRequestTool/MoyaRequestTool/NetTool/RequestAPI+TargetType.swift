//
//  RequestAPI+TargetType.swift
//  MoyaRequestTool
//  Target协议实现
//  Created by Flum on 2021/9/30.
//  Copyright © 2021 DaXiong. All rights reserved.
//

import Foundation
import Moya

extension RequestAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: moyaBaseUrl)!
    }
    
    var path: String {
        switch self {
        case .easyAPI:
            return "channels/362/members"
        case .basicGetAPI:
            return "channel/audience"
        case .basicPostAPI :
            return "channel/audience"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .easyAPI:
            return .get
        case .basicGetAPI:
            return .get
        case .basicPostAPI:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .easyAPI:
            return .requestPlain
        case let .basicGetAPI(parameters: params):
            return .requestParameters(parameters: params, encoding: BracketLessGetEncoding())
        case let .basicPostAPI(parameters: params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
                
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        headers["X-Channel"] = "0"
        headers["X-User"] = "79"
        headers["Authorization"] = "Bearer s4qrhtuypfnw3qo3mjj63pw4pw"
        headers["X-Version"] = "ios/2.2.3"
        headers["X-Sign"] = "iRSbWhCjncAFTQh2W5r55pvLHiATYXGPf0cKGKpM8jzJSHUKc4e0w8XVPv2iIwQtg3Vscb4ZGWBREmV0a8f6gNddCfJGSGyW9CSen+F2Jpc="

        return headers
    }
}
