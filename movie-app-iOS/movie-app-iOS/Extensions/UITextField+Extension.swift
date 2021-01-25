//
//  UITextField+Extension.swift
//  movie-app-iOS
//
//  Created by Ikechukwu Onuorah on 07/11/2020.
//

import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    func setRightPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if isSecureTextEntry{
            button.setTitle("Show", for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
        } else {
            button.setTitle("Hide", for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
        }
    }
    
    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 12)
        button.setTitleColor(UIColor(red: 0.273, green: 0.316, blue: 0.504, alpha: 1), for: .normal)
        let cgX = CGFloat(self.frame.size.width - 25)
        button.frame = CGRect(x: cgX, y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    @objc func togglePasswordView(_ sender: UIButton) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender)
    }
}
