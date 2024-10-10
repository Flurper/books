//
//  Books.swift
//  myfavoritebooks
//
//  Created by AM Student on 9/26/24.
//

import Combine

class Book: ObservableObject {
    
    @Published var title: String
    @Published var author: String
    @Published var microReview: String
    @Published var myFavoriteBook: Bool
    
    init(
        title: String = "title",
        author: String = "author",
        microReview: String = "",
        myFavoriteBook: Bool = true
    ) {
        self.title = title
        self.author = author
        self.microReview = microReview
        self.myFavoriteBook = myFavoriteBook
    }
}

extension Book: Equatable {
    static func == (lhs: Book, rhs: Book) -> Bool {
        lhs === rhs
    }
}
extension Book: Hashable, Identifiable {
    func hash(into hasher: inout Hasher) {
    }
}
