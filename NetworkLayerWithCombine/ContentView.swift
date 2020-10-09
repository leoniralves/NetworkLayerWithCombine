//
//  ContentView.swift
//  ProjectNoName
//
//  Created by Leonir Alves Deolindo on 28/09/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var moviesViewModel = MoviesViewModel()
    
    var body: some View {
        List {
            if let movies = moviesViewModel.movies {
                ForEach(movies, id: \.id) { movie in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(movie.title)")
                                .font(.title2)
                            
                            Text("\(movie.overview ?? "")")
                                .font(.caption)
                                .padding(.top, 5)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
