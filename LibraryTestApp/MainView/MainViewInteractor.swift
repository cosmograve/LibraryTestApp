//
//  MainViewInteractor.swift
//  LibraryTestApp
//
//  Created by Алексей Авер on 20.05.2024.
//

import CoreData
import UIKit

enum SortCriterion {
    case title, author, year
}


protocol MainViewInteractorProtocol: AnyObject {
    func loadBooks()
    func deleteBook(_ book: Book)
    func sortBooks(by criteria: SortCriterion)
    func searchBooks(with query: String)
}

class MainViewInteractor: MainViewInteractorProtocol {
    weak var presenter: MainViewPresenterProtocol?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func loadBooks() {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        do {
            let books = try context.fetch(fetchRequest)
            presenter?.books = books
            presenter?.presentBooks()
        } catch {
            print("Failed to fetch books: \(error)")
        }
    }
    
    func deleteBook(_ book: Book) {
        context.delete(book)
        saveContext()
        loadBooks()
    }
    
    func searchBooks(with query: String) {
        if query.isEmpty {
            loadBooks()
            return
        }
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title CONTAINS[cd] %@ OR author CONTAINS[cd] %@ or year CONTAINS[cd] %@", query, query, query)
        do {
            let books = try context.fetch(fetchRequest)
            presenter?.books = books
            presenter?.presentBooks()
        } catch {
            print("Failed to fetch books: \(error)")
        }
    }
    
    func sortBooks(by criteria: SortCriterion) {
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
        switch criteria {
        case .title:
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        case .author:
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        case .year:
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "year", ascending: true)]
        }
        do {
            let books = try context.fetch(fetchRequest)
            presenter?.books = books
            presenter?.presentBooks()
        } catch {
            print("Failed to fetch books: \(error)")
        }
    }
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
