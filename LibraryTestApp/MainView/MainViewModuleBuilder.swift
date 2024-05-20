//
//  MainViewModuleBuilder.swift
//  LibraryTestApp
//
//  Created by Алексей Авер on 20.05.2024.
//

import UIKit

class MainViewModuleBuilder {
    static func build() -> UIViewController {
        let interactor = MainViewInteractor()
        let router = MainViewRouter()
        let presenter = MainViewPresenter(router: router, interactor: interactor)
        let viewController = MainViewController()
        
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        router.view = viewController
        
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}

