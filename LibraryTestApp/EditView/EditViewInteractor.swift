//
//  EditViewInteractor.swift
//  LibraryTestApp
//
//  Created by Алексей Авер on 20.05.2024.
//

import UIKit

protocol EditViewInteractorProtocol: AnyObject {
    func addBook(title: String, author: String, year: Int16)
    func editBook(book: Book, title: String, author: String, year: Int16)
}

class EditViewInteractor: EditViewInteractorProtocol {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addBook(title: String, author: String, year: Int16) {
        let book = Book(context: context)
        book.title = title
        book.author = author
        book.year = year
        saveContext()
    }
    
    func editBook(book: Book, title: String, author: String, year: Int16) {
        book.title = title
        book.author = author
        book.year = year
        saveContext()
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
