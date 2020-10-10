//
//  URLRequest+Extensions.swift
//  NetworkLayerWithCombine
//
//  Created by Fábio Salata on 08/10/20.
//

import Foundation

extension URLRequest {
    init(baseUrl: String, target: APIServiceTarget) {
        
        let url = URL(baseUrl: baseUrl, path: target.path, params: target.parameters, method: target.method)
        self.init(url: url)
        
        httpMethod = target.method.rawValue
        
        setValue("application/json", forHTTPHeaderField: "Accept")
        setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        target.header?.forEach({
            setValue($0.key, forHTTPHeaderField: $0.value)
        })
        
        switch target.method {
        case .POST, .PUT:
            httpBody = try? JSONSerialization.data(withJSONObject: target.parameters ?? "", options: [])
        default:
            break
        }
    }
}
