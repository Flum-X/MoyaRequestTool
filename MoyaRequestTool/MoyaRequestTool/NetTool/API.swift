//
//  API.swift
//  MoyaRequestTool
//
//  Created by DaXiong on 2020/7/20.
//  Copyright © 2020 DaXiong. All rights reserved.
//

import Foundation
import Moya
import Alamofire

//Get请求参数编码
struct BracketLessGetEncoding: ParameterEncoding {
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try URLEncoding().encode(urlRequest, with: parameters)
        request.url = URL(string: request.url!.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "="))
        return request
    }
}

enum Module1API {
    
    case easyAPI
    case basicGetAPI(parameters:[String:Any])
    case basicPostAPI(parameters:[String:Any])
}


extension Module1API: TargetType {
    
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
