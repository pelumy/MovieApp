//
//  LoginPresenter.swift
//  movie-app-iOS
//
//  Created by Ikechukwu Onuorah on 08/11/2020.
//

import Foundation

protocol LoginPresentationLogic {
    func displayDataSuccess(prompt: String)
    func displayDataError(prompt: String)
}

class LoginPresenter:LoginPresentationLogic {
    var loginView: LoginDisplayLogic?
    
    func displayDataSuccess(prompt: String) {
        loginView?.displaySuccessAlert(prompt: prompt)
    }
    
    func displayDataError(prompt: String) {
        loginView?.displayFailureAlert(prompt: prompt)
    }
}
