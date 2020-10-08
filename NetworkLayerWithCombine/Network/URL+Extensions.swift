//
//  URL+Extensions.swift
//  NetworkLayerWithCombine
//
//  Created by Fábio Salata on 08/10/20.
//

import Foundation

extension URL {
    init(baseUrl: String, path: String, params: JSON?, method: HTTPMethod) {
        var components = URLComponents(string: baseUrl)!
        components.path += path
        
        switch method {
        case .GET, .DELETE:
            components.queryItems = params?.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        default:
            break
        }
        
        self = components.url!
    }
}
