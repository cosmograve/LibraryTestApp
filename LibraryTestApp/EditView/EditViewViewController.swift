//
//  EditViewViewController.swift
//  LibraryTestApp
//
//  Created by Алексей Авер on 20.05.2024.
//

import UIKit

protocol EditViewControllerProtocol: AnyObject {
    func displayBook(_ book: Book)
}

class EditViewViewController: UIViewController {
    var presenter: EditViewPresenterProtocol?
    private let contentView: EditView = .init()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        presenter?.viewDidLoad()
    }
    
    @objc private func didTapSaveButton() {
        guard let title = contentView.titleTextField.text, !title.isEmpty,
              let author = contentView.authorTextField.text, !author.isEmpty,
              let yearText = contentView.yearTextField.text, let year = Int16(yearText) else { return }
        presenter?.saveBook(title: title, author: author, year: year)
    }

}

extension EditViewViewController: EditViewControllerProtocol {
    func displayBook(_ book: Book) {
        contentView.titleTextField.text = book.title
        contentView.authorTextField.text = book.author
        contentView.yearTextField.text = "\(book.year)"
    }
}
