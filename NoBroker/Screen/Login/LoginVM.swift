//
//  LoginVM.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//

import Foundation




protocol LoginVMDelegate: AnyObject {
    func handleError(message: String)
    func loginSuccess()
}



class LoginVM {
    weak var delegate: LoginVMDelegate?
    
    
    func handleLogin(email: String, password: String) {
        //TODO: need to add more validation
        if !isValidEmail(email) {
            delegate?.handleError(message: "Enter Valida Email")
            return
        }
        
        if password.count < 8 {
            delegate?.handleError(message: "password must be 8 character long")
            return
        }
        
        if email.uppercased() != "ABC@GMAIL.COM" {
            delegate?.handleError(message: "Email is abc@gmail.com")
            return
        }
        
        if password != "12345678" {
            delegate?.handleError(message: "password 12345678")
            return
        }
        
        //TODO: After API call credential need be stored
        delegate?.loginSuccess()
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
