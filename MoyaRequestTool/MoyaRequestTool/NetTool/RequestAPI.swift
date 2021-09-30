//
//  API.swift
//  MoyaRequestTool
//  请求API定义
//  Created by DaXiong on 2020/7/20.
//  Copyright © 2020 DaXiong. All rights reserved.
//

import Foundation

enum RequestAPI {
    
    case easyAPI
    case basicGetAPI(parameters:[String:Any])
    case basicPostAPI(parameters:[String:Any])
}
