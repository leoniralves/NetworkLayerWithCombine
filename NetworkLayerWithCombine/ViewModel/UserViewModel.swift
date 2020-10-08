//
//  UserService.swift
//  NetworkLayerWithCombine
//
//  Created by Fábio Salata on 08/10/20.
//

import Foundation
import Combine

struct User: Decodable {
    let name: String
}

class UserViewModel: ObservableObject {
    @Published var user: User?
    
    private var cancellable: AnyCancellable?
    
    init() {
        getUser()
    }
}

extension UserViewModel {
    func getUser() {
        let userTarget = UserTarget.user
        
        let networkManager = NetworkManager()
        let request: AnyPublisher<User, APIError> = networkManager.request(for: userTarget)
        cancellable = request
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion) in
                print("Completion \(completion)")
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { (user) in
                self.user = user
            })
    }
}

extension UserViewModel {
    enum UserTarget: APIServiceTarget {
        case user
        
        var path: String {
            "/user"
        }
        
        var method: HTTPMethod {
            .GET
        }
        
        var header: [String : String]? {
            nil
        }
        
        var parameters: [String : String]? {
            nil
        }
    }
}
