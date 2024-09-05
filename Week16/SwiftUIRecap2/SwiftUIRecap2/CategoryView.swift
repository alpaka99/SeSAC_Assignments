//
//  CategoryView.swift
//  SwiftUIRecap2
//
//  Created by user on 9/6/24.
//

import SwiftUI

struct CategoryView: View {
    @State private var genre = "로맨스"
    @State private var genres = ["로맨스", "느와르", "액션", "스릴러"]
    var body: some View {
        NavigationView {
            VStack {
                CategoryPresentView(selectedGenre: genre)
                
                GenreView(genres: genres, selectedGenre: $genre)
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        print("Tapped")
                        if let randomGenre = genres.randomElement() {
                            genres.append(randomGenre)
                            print(genres)
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct CategoryPresentView: View {
    let selectedGenre: String
    var body: some View {
        Text("선택한 장르: \(selectedGenre)")
            .font(.title)
    }
}

struct GenreView: View {
    let genres: [String]
    
    @Binding private var selectedGenre: String
    
    init(genres: [String], selectedGenre: Binding<String>) {
        self.genres = genres
        self._selectedGenre = selectedGenre
    }
    
    var body: some View {
            ScrollView {
                VStack {
                    ForEach(genres, id: \.self) { genre in
                        Button {
                            selectedGenre = genre
                        } label: {
                            Text(genre)
                        }
                    }
                }
            }
    }
}


#Preview {
    CategoryView()
}
