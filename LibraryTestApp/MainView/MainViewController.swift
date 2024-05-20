//
//  ViewController.swift
//  LibraryTestApp
//
//  Created by Алексей Авер on 20.05.2024.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func displayBooks(_ books: [Book])
    func reload()
}

class MainViewController: UIViewController {
    var presenter: MainViewPresenterProtocol?
    
    private let contentView: MainView = .init()
    private var dataSource: UITableViewDiffableDataSource<Int, Book>!
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSearchBar()
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    func reload() {
        contentView.tableView.reloadData()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = contentView.addButton
        navigationItem.leftBarButtonItem = contentView.sortButton

        navigationItem.title = "Библиотека"
        
        contentView.addButton.target = self
        contentView.addButton.action = #selector(didTapAddBook)
        
        contentView.sortButton.target = self
        contentView.sortButton.action = #selector(didTapSortButton)
    }
    
    private func setupSearchBar() {
        contentView.searchBar.delegate = self

    }
    
    private func setupTableView() {
        contentView.tableView.delegate = self
        
        dataSource = UITableViewDiffableDataSource<Int, Book>(tableView: contentView.tableView) { (tableView, indexPath, book) -> UITableViewCell? in
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
            let title = book.title ?? "Unknown Title"
            let author = book.author ?? "Unknown Author"
            let year = book.year
            cell.textLabel?.text = title + " - " + author
            cell.detailTextLabel?.text = ("Год издания: \(year)")
            return cell
        }
        
        contentView.tableView.dataSource = dataSource
    }
    
    @objc private func didTapAddBook() {
        presenter?.addBook()
    }
    
    @objc private func didTapSortButton() {
        let alert = UIAlertController(title: "Сортировка", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Название", style: .default, handler: { _ in self.presenter?.sortBooks(by: .title) }))
        alert.addAction(UIAlertAction(title: "Автор", style: .default, handler: { _ in self.presenter?.sortBooks(by: .author) }))
        alert.addAction(UIAlertAction(title: "Год", style: .default, handler: { _ in self.presenter?.sortBooks(by: .year) }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: MainViewProtocol {
    func displayBooks(_ books: [Book]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Book>()
        snapshot.appendSections([0])
        snapshot.appendItems(books)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let book = dataSource.itemIdentifier(for: indexPath) {
            presenter?.editBook(book)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            if let book = self?.dataSource.itemIdentifier(for: indexPath) {
                self?.presenter?.deleteBook(book)
            }
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchBooks(with: searchText)
    }
}
