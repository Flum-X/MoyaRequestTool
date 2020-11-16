//
//  API.swift
//  MoyaRequestTool
//
//  Created by DaXiong on 2020/7/20.
//  Copyright © 2020 DaXiong. All rights reserved.
//

import Foundation
import Moya

enum Module1API {
    
    case basicAPI(parameters:[String:Any])
    case easyAPI
}


extension Module1API: TargetType {
    
    var baseURL: URL {
        switch self {
        case .basicAPI:
            return URL.init(string: "https://tv-api.shike.co/")!
        case .easyAPI:
            return URL.init(string: "https://tv-api.shike.co/")!
        } //"https://news-at.zhihu.com/api/"
    }
    
    var path: String {
        switch self {
        case .easyAPI:
            return "channels/362/members" //"4/news/latest"
        default:
            return "channel/audience"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .easyAPI:
            return .get
        default:
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
        case let .basicAPI(parameters: params):
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
