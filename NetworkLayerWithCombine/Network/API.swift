//
//  API.swift
//  ProjectNoName
//
//  Created by Leonir Alves Deolindo on 05/10/20.
//

import Foundation

struct API {
    static var baseURL: String {
        #if DEBUG
        return "https://api.themoviedb.org/3/"
        #endif
    }
}
