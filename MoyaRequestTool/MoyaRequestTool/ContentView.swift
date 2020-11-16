//
//  ContentView.swift
//  MoyaRequestTool
//
//  Created by DaXiong on 2020/7/20.
//  Copyright © 2020 DaXiong. All rights reserved.
//

import SwiftUI
import Moya

struct ContentView: View {
        
    var body: some View {
        
        Button(action: {
            self.sendRequest()
        }) {
            Text("Send Request")
        }
    }
    
    func sendRequest() {
        
        print("开始发送请求")
        
//        netWorkRequest(.easyRequest, completion: { (responseStr) in
//
//            print(responseStr)
//        }, failed: { (failedRes) in
//
//        })
        
        var params = [String:Any]()
        params["token"] = "s4qrhtuypfnw3qo3mjj63pw4pw"
        params["channel_id"] = 362
        params["user_id"] = 79
        params["offset"] = 0
        params["limit"] = 20

        netWorkRequest(.basicAPI(parameters: params), completion: { (responseStr) in

            print(responseStr)
        }, failed: { (failedRes) in

        }, errorResult: {

        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
