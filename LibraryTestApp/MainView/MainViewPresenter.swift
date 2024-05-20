//
//  MainViewPresenter.swift
//  LibraryTestApp
//
//  Created by Алексей Авер on 20.05.2024.
//

import Foundation

protocol MainViewPresenterProtocol: AnyObject {
    var books: [Book] { get set }
    func viewDidLoad()
    func addBook()
    func editBook(_ book: Book)
    func deleteBook(_ book: Book)
    func sortBooks(by criteria: SortCriterion)
    func searchBooks(with query: String)
    func presentBooks()
    func refreshBooks()
}

class MainViewPresenter {
    weak var view: MainViewProtocol?
    var router: MainViewRouterProtocol
    var interactor: MainViewInteractorProtocol
    
    var books: [Book] = []
    
    init(router: MainViewRouterProtocol, interactor: MainViewInteractorProtocol) {
        self.router = router
        self.interactor = interactor
    }
}

extension MainViewPresenter: MainViewPresenterProtocol {
    
    func presentBooks() {
        view?.displayBooks(books)
        view?.reload()
    }
    
    
    func viewDidLoad() {
        interactor.loadBooks()
    }
    
    func addBook() {
        router.navigateToEditVC(book: nil)

    }
    
    func editBook(_ book: Book) {
        router.navigateToEditVC(book: book)

    }
    
    func deleteBook(_ book: Book) {
        interactor.deleteBook(book)
    }
    
    func searchBooks(with query: String) {
        interactor.searchBooks(with: query)
    }
    
    func sortBooks(by criteria: SortCriterion) {
        interactor.sortBooks(by: criteria)
    }
    
    func refreshBooks() {
        interactor.loadBooks()
    }
}

extension MainViewPresenter: EditViewPresenterDelegate {
    func didUpdateBooks() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshBooks()
            self?.presentBooks()
           
        }
    }
}
