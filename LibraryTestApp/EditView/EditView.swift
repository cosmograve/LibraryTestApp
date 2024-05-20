//
//  EditView.swift
//  LibraryTestApp
//
//  Created by Алексей Авер on 20.05.2024.
//

import UIKit

class EditView: UIView {
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Название"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var authorTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Автор"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Год издания"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        addSubview(titleTextField)
        addSubview(authorTextField)
        addSubview(yearTextField)
        addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            authorTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            authorTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            authorTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            yearTextField.topAnchor.constraint(equalTo: authorTextField.bottomAnchor, constant: 20),
            yearTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            yearTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            saveButton.topAnchor.constraint(equalTo: yearTextField.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}



