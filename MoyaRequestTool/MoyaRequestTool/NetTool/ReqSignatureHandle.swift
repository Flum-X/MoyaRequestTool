//
//  ReqSignatureHandle.swift
//  MoyaRequestTool
//  请求签名处理
//  Created by Flum on 2021/9/30.
//  Copyright © 2021 DaXiong. All rights reserved.
//

import Foundation
import Alamofire
import Moya

//Get请求参数编码
struct BracketLessGetEncoding: ParameterEncoding {
    
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try URLEncoding().encode(urlRequest, with: parameters)
        request.url = URL(string: request.url!.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "="))
        return request
    }
}

extension RequestAPI {
    
    func requestWithGetSign(_ params: [String: Any]) -> Task {
        .requestParameters(parameters: sign(params), encoding: BracketLessGetEncoding())
    }

    func requestWithBodySign(_ params: [String: Any]) -> Task {
        .requestParameters(parameters: sign(params), encoding: URLEncoding.httpBody)
    }
    
    func sign(_ params: [String: Any]) -> [String: Any] {
        var newParams = params
        //参数签名处理
        return newParams
    }

    func getMethodStr() -> String {
        switch method {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        case .patch:
            return "PATCH"
        default:
            return ""
        }
    }
    
}
