//
//  APIServiceTarget.swift
//  ProjectNoName
//
//  Created by Leonir Alves Deolindo on 05/10/20.
//

import Foundation

protocol APIServiceTarget {
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var parameters: [String: String]? { get }
}
