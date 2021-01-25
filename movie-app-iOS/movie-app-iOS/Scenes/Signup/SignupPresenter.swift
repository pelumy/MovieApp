//
//  SignupPresenter.swift
//  movie-app-iOS
//
//  Created by Ikechukwu Onuorah on 08/11/2020.
//

import Foundation

protocol SignupPresentationLogic {
    func displayDataSuccess(prompt: String)
    func displayDataError(prompt: String)
}

class SignupPresenter:SignupPresentationLogic {
    var signupView: SignupDisplayLogic?
    
    func displayDataSuccess(prompt: String) {
        signupView?.displaySuccessAlert(prompt: prompt)
    }
    
    func displayDataError(prompt: String) {
        signupView?.displayFailureAlert(prompt: prompt)
    }
}
