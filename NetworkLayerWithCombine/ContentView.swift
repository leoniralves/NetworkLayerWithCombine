//
//  ContentView.swift
//  ProjectNoName
//
//  Created by Leonir Alves Deolindo on 28/09/20.
//

import SwiftUI
import Combine

struct User: Decodable {
    let name: String
}

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

class UserClient: ObservableObject {
    
    @Published var user: User?
    
    private var cancellable: AnyCancellable?
    
    init() {
        
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

struct ContentView: View {
    
    @ObservedObject var userClient = UserClient()
    
    var body: some View {
        VStack {
            Text(userClient.user?.name ?? "")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
