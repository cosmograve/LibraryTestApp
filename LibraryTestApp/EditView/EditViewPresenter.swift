//
//  EditViewPresenter.swift
//  LibraryTestApp
//
//  Created by Алексей Авер on 20.05.2024.
//

import Foundation

protocol EditViewPresenterDelegate: AnyObject {
    func didUpdateBooks()
}

protocol EditViewPresenterProtocol: AnyObject {
    var delegate: EditViewPresenterDelegate? { get set }

    func viewDidLoad()
    func saveBook(title: String, author: String, year: Int16)
}

class EditViewPresenter {
    weak var view: EditViewControllerProtocol?
    var interactor: EditViewInteractorProtocol
    var router: EditViewRouterProtocol
    var book: Book?
    weak var delegate: EditViewPresenterDelegate?
    
    init(interactor: EditViewInteractorProtocol, router: EditViewRouterProtocol, book: Book?) {
        self.interactor = interactor
        self.router = router
        self.book = book
    }
}

extension EditViewPresenter: EditViewPresenterProtocol {
    
    func viewDidLoad() {
        if let book = book {
            view?.displayBook(book)
        }
    }
    
    func saveBook(title: String, author: String, year: Int16) {
        if let book = book {
            interactor.editBook(book: book, title: title, author: author, year: year)
        } else {
            interactor.addBook(title: title, author: author, year: year)
        }
        delegate?.didUpdateBooks()
        router.dismiss()
    }
}
