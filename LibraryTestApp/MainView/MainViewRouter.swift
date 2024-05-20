//
//  MainViewRouter.swift
//  LibraryTestApp
//
//  Created by Алексей Авер on 20.05.2024.
//

import Foundation

protocol MainViewRouterProtocol: AnyObject {
    func navigateToEditVC(book: Book?)
}

class MainViewRouter: MainViewRouterProtocol {
    weak var view: MainViewController?
    
    func navigateToEditVC(book: Book?) {
        guard let mainViewController = view else { return }
        let editVC = EditViewModuleBuilder.build(with: book, delegate: mainViewController.presenter as! EditViewPresenterDelegate)
        view?.navigationController?.pushViewController(editVC, animated: true)
    }
}
