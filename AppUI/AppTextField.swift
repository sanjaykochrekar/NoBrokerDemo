//
//  AppTextField.swift
//  AppUI
//
//  Created by Sanju on 29/12/23.
//

import UIKit


public class AppTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
