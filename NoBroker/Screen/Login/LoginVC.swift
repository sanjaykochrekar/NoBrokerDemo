//
//  LoginVC.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//

import UIKit




class LoginVC: UIViewController {
    var loginView: LoginView!
    weak var coordinator: MainCoordinator?
    lazy var vm = LoginVM()
    
    
    
    override func loadView() {
        super.loadView()
        loginView = LoginView()
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(loginView)
        view.backgroundColor = .appBg

        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()   
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
        
        let action = UIAction { [weak self] _ in
            self?.loginPressed()
        }
        
        loginView.loginBtn.addAction(action, for: .primaryActionTriggered)
        
        vm.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            loginView.scrollViewBottomAnchor.constant = -keyboardSize.height
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        loginView.scrollViewBottomAnchor.constant = 0
    }
    
}


//MARK: - Login methos
extension LoginVC {
    
    func loginPressed() {
        let email = loginView.emailTextField.text ?? ""
        let password = loginView.passwordTextField.text ?? ""
        vm.handleLogin(email: email, password: password)
    }
    
}


//MARK: - UITextFieldDelegate methods
extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView.emailTextField {
            loginView.passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            loginPressed()
        }
        return false
    }
    
}


//MARK: - LoginVMDelegate methods
extension LoginVC: LoginVMDelegate {
    
    func handleError(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func loginSuccess() {
        coordinator?.loginSuccess()
    }
    
}


