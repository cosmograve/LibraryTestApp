//
//  EditViewRouter.swift
//  LibraryTestApp
//
//  Created by Алексей Авер on 20.05.2024.
//

import UIKit

protocol EditViewRouterProtocol: AnyObject {
    func dismiss()
}

class EditViewRouter: EditViewRouterProtocol {
    weak var view: UIViewController?
    
    func dismiss() {
        view?.navigationController?.popViewController(animated: true)
    }
}
