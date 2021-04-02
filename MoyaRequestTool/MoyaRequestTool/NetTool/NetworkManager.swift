//
//  NetworkManager.swift
//  MoyaRequestTool
//
//  Created by DaXiong on 2020/7/20.
//  Copyright © 2020 DaXiong. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON
import Moya


private var requestTimeout: Double = 30

typealias successCallback = ((String)->Void)

typealias failureCallback = ((String)->Void)

typealias errorCallback = (()->Void)


private let myEndpointClosure = { (target: Module1API) -> Endpoint in
    
    let url = target.baseURL.absoluteString + target.path
    var task = target.task
    
    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: task,
        httpHeaderFields: target.headers
    )
    
    requestTimeout = 30
    
    switch target {
    case .easyAPI:
        return endpoint
    default:
        requestTimeout = 20
        return endpoint
    }
}

private let requestClosure = { (endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    
    do {
        var request = try endpoint.urlRequest()
        // 设置请求时长
        request.timeoutInterval = requestTimeout
        // 打印请求参数
        if let requestData = request.httpBody {
            print("\(request.url!)" + "\n" + "\(request.httpMethod ?? "")" + "发送参数" + "\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")")
        } else {
            print("\(request.url!)" + "\(String(describing: request.httpMethod))")
        }
        done(.success(request))
    } catch {
        done(.failure(MoyaError.underlying(error, nil)))
    }
}

private let networkPlugin = NetworkActivityPlugin.init { (changeType, _) in
    
    print("networkPlugin \(changeType)")
    // targetType 是当前请求的基本信息
    switch changeType {
    case .began:
        print("开始请求网络")

    case .ended:
        print("请求结束")
    }
}

//网络请求发送的核心初始化方法，创建网络请求对象
let provider = MoyaProvider<Module1API>(endpointClosure: myEndpointClosure, requestClosure: requestClosure,  plugins: [networkPlugin], trackInflights: false)

func networkRequest(_ target: Module1API, completion: @escaping successCallback) {
    
    netWorkRequest(target, completion: completion, failed: nil, errorResult: nil)
}

func netWorkRequest(_ target: Module1API, completion: @escaping successCallback, failed: failureCallback?) {
    
    netWorkRequest(target, completion: completion, failed: failed, errorResult: nil)
}

@discardableResult //用于禁止显示 Result unused 警告的一个属性
func netWorkRequest(_ target: Module1API, completion: @escaping successCallback, failed: failureCallback?, errorResult: errorCallback?) -> Cancellable? {
    
    if !UIDevice.isNetworkConnect {
        print("请检查您的网络是否正常连接")
        return nil
    }
    
    //loading...
    return provider.request(target) { result in
        //隐藏loading
        
        switch result {
            
        case let .success(response):
                
                completion(String(data: response.data, encoding: String.Encoding.utf8)!)
        case let .failure(error):
            print("请求失败\(error)")
        }
        
    }
}
















/// 基于Alamofire,网络是否连接，，这个方法不建议放到这个类中,可以放在全局的工具类中判断网络链接情况
/// 用计算型属性是因为这样才会在获取isNetworkConnect时实时判断网络链接请求，如有更好的方法可以fork
extension UIDevice {
    static var isNetworkConnect: Bool {
        let network = NetworkReachabilityManager()
        return network?.isReachable ?? true // 无返回就默认网络已连接
    }
}
