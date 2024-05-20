//
//  EditViewModuleBuilder.swift
//  LibraryTestApp
//
//  Created by Алексей Авер on 20.05.2024.
//

import UIKit

class EditViewModuleBuilder {
    static func build(with book: Book?, delegate: EditViewPresenterDelegate) -> UIViewController {
        let interactor = EditViewInteractor()
        let router = EditViewRouter()
        let presenter = EditViewPresenter(interactor: interactor, router: router, book: book)
        presenter.delegate = delegate
        let viewController = EditViewViewController()
        viewController.presenter = presenter
        presenter.view = viewController
        router.view = viewController
        
        return viewController
    }
}
