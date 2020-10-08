//
//  ContentView.swift
//  ProjectNoName
//
//  Created by Leonir Alves Deolindo on 28/09/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var userViewModel = UserViewModel()
    
    var body: some View {
        VStack {
            Text(userViewModel.user?.name ?? "")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
