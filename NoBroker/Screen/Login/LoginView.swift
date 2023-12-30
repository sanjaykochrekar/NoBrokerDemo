//
//  LoginView.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//

import UIKit
import AppUI




class LoginView: UIView {
    var scrollView: UIScrollView!
    var contentView: UIView!
    var emailTextField: AppTextField!
    var passwordTextField: AppTextField!
    var loginBtn: UIButton!
    
    var scrollViewBottomAnchor: NSLayoutConstraint!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createSubViews()
    }
    
    
    private func createSubViews() {
        
        scrollView = UIScrollView()
        addSubview(scrollView)
        
        contentView = UIView()
        scrollView.addSubview(contentView)

        
        emailTextField = AppTextField()
        emailTextField.keyboardType = .emailAddress
        emailTextField.returnKeyType = .next
        emailTextField.placeholder = "Email"
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = UIColor.gray.cgColor
        emailTextField.layer.masksToBounds = true
        emailTextField.layer.cornerRadius = 8
        contentView.addSubview(emailTextField)
        
        
        passwordTextField = AppTextField()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.returnKeyType = .go
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.gray.cgColor
        passwordTextField.layer.masksToBounds = true
        passwordTextField.layer.cornerRadius = 8
        contentView.addSubview(passwordTextField)
        
        
        loginBtn = UIButton()
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.backgroundColor = .accent
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = 8
        contentView.addSubview(loginBtn)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        
        scrollViewBottomAnchor = scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollViewBottomAnchor,
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor),

            emailTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20),
            
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            passwordTextField.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            loginBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            loginBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            loginBtn.heightAnchor.constraint(equalTo: emailTextField.heightAnchor)
        ])
    }
    
}

