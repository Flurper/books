//
//  Library.swift
//  myfavoritebooks
//
//  Created by AM Student on 9/30/24.
//

import SwiftUI
import Combine

class Library: ObservableObject {
    var sortedBooks: [Section: [Book]] {
        get {
            let groupedBooks = Dictionary(grouping: bookCache, by: \.myFavoriteBook)
            return Dictionary(uniqueKeysWithValues: groupedBooks.map {
                (($0.key ? .myFavoriteBooks : .finished), $0.value)
            })
        } set {
            bookCache =
            newValue
                .sorted { $1.key == .finished }
                .flatMap { $0.value }
        }
        
    }
    //sorts books and u0pdates the cache
    func sortbooks() {
        bookCache =
        sortedBooks
            .sorted { $1.key == .finished }
            .flatMap { $0.value }
        
        objectWillChange.send()
    }
    //adds new books
    func addNewBook(_ book: Book, image: Image?) {
        bookCache.insert(book, at: 0)
        images[book] = image
    }
    func deleteBooks(atOffSets offsets: IndexSet, section: Section) {
        let booksBeforeDeletion = bookCache
        
        sortedBooks[section]?.remove(atOffsets: offsets)
        for change in bookCache.difference(from: booksBeforeDeletion) {
            if case .remove(_, let deletedBook, _) = change {
                images[deletedBook] = nil
            }
        }
    }
    func moveBooks(oldOffSets: IndexSet, newOffSet: Int, section: Section) {
        sortedBooks[section]?.move(fromOffsets: oldOffSets, toOffset: newOffSet)
    }
    
    @Published private var bookCache: [Book] = [
        .init(title: "captain underpants 1", author: "REAL LIFE", microReview: "its peak"),
        .init(title: "captain underpants 2", author: "REAL LIFE", microReview: "its peak"),
        .init(title: "captain underpants 3", author: "REAL LIFE", microReview: "its peak"),
        .init(title: "captain underpants 4", author: "REAL LIFE", microReview: "its peak"),
        .init(title: "captain underpants 5", author: "REAL LIFE", microReview: "its peak"),
        .init(title: "captain underpants 6", author: "REAL LIFE", microReview: "its peak"),
        .init(title: "captain underpants 7", author: "REAL LIFE", microReview: "its peak"),
        .init(title: "captain underpants 8", author: "REAL LIFE", microReview: "its peak"),
        .init(title: "captain underpants 9", author: "REAL LIFE", microReview: "its peak"),
        .init(title: "captain underpants 10", author: "REAL LIFE", microReview: "its peak")
        

    ]
    
    @Published var images: [Book: Image] = [:]
    
    init() {
        if let captain = bookCache.first(where: { $0.title == "captain underpants"}) {
            images[captain] = Image("captain")
        }
        if let captain = bookCache.first(where: { $0.title == "captain underpants 2"}) {
            images[captain] = Image("captain2")
        }
        if let captain = bookCache.first(where: { $0.title == "captain underpants 3"}) {
            images[captain] = Image("captain3")
        }
        if let captain = bookCache.first(where: { $0.title == "captain underpants 4"}) {
            images[captain] = Image("captain4")
        }
        if let captain = bookCache.first(where: { $0.title == "captain underpants 5"}) {
            images[captain] = Image("captain5")
        }
    }
}

enum Section: CaseIterable {
    case myFavoriteBooks
    case finished
}
