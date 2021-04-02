//
//  MoyaConfig.swift
//  MoyaRequestTool
//
//  Created by DaXiong on 2020/7/20.
//  Copyright © 2020 DaXiong. All rights reserved.
//

import Foundation

enum Environment {
    case develop
    case test
    case offical
}
//环境变量
let enviroment: Environment = .offical

//定义基础域名
private let baseUrl_dev = "https://tv-api-dev.shike.co/" //开发域名
private let baseUrl_test = "https://tv-api-test.shike.co/" //测试域名
private let baseUrl_offical = "https://tv-api.shike.co/" //正式域名

var moyaBaseUrl: String {
    switch enviroment {
    case .develop:
        return baseUrl_dev
    case .test:
        return baseUrl_test
    case .offical:
        return baseUrl_offical
    }
}
