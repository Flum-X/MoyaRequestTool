//
//  DXError.swift
//  MoyaRequestTool
//  错误码定义
//  Created by Flum on 2021/9/30.
//  Copyright © 2021 DaXiong. All rights reserved.
//

import Foundation

@objc enum ErrorCode: Int {
    
case unknow = -1

case networkNotConnect = -1000       //无网络
    
}

@objc class DXError: NSObject {
    @objc var code: ErrorCode
    @objc var message: String
    @objc init(_ code: ErrorCode, _ message: String) {
        self.code = code
        self.message = message
    }
}
