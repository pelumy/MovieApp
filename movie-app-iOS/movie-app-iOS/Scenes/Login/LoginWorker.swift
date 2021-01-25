//
//  LoginWorker.swift
//  movie-app-iOS
//
//  Created by Ikechukwu Onuorah on 08/11/2020.
//

import Firebase

protocol loginWorkerProtocol {
    func login(userDetail: LoginDataModel, success: @escaping (String) -> (), failure: @escaping (String) -> ())
}

class LoginWorker: loginWorkerProtocol {
    func login(userDetail: LoginDataModel, success: @escaping (String) -> (), failure: @escaping (String) -> ()) {
        let email = userDetail.email
        let password = userDetail.password
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                    failure(LoginWorkerConstants.invalidOperation)
                case .userDisabled:
                    failure(LoginWorkerConstants.userDisabled)
                case .wrongPassword:
                    failure(LoginWorkerConstants.wrongPassword)
                case .invalidEmail:
                    failure(LoginWorkerConstants.invalidEmail)
                default:
                    failure("Error: \(error.localizedDescription)")
                }
            } else {
                print(LoginWorkerConstants.successMessage)
                let userInfo = Auth.auth().currentUser
                guard let email = userInfo?.email else { return }
                success(email)
            }
        }
    }
    
}
