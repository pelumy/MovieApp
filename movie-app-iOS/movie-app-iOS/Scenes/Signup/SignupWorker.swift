//
//  SignupWorker.swift
//  movie-app-iOS
//
//  Created by Ikechukwu Onuorah on 08/11/2020.
//

import Firebase

protocol SignupWorkerProtocol {
    func signup(userDetail: SignupDataModel, success: @escaping (String) -> (), failure: @escaping (String) -> ())
}

class SignupWorker: SignupWorkerProtocol {
    func signup(userDetail: SignupDataModel, success: @escaping (String) -> (), failure: @escaping (String) -> ()) {
        let email = userDetail.email
        let password = userDetail.password
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
            switch AuthErrorCode(rawValue: error.code) {
            case .operationNotAllowed:
                failure("Invalid Operation")
            case .emailAlreadyInUse:
                failure("Email already in use")
            case .invalidEmail:
                failure("Invalid email")
            case .weakPassword:
                failure("Weak password")
            default:
                print("Error: \(error.localizedDescription)")
                failure("Error: \(error.localizedDescription)")
            }
          } else {
            print("User signs up successfully")
            let newUserInfo = Auth.auth().currentUser
            guard let email = newUserInfo?.email else { return }
            let ref = Database.database().reference()
            ref.child("users")
            let key = newUserInfo?.uid
            ref.child("users").child(key ?? "").setValue(userDetail.username)
            success(email)
          }
        }
    }
}
