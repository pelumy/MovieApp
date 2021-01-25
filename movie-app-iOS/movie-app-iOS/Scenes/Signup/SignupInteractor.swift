//
//  SignupInteractor.swift
//  movie-app-iOS
//
//  Created by Ikechukwu Onuorah on 08/11/2020.
//

import Foundation

protocol SignupBusinessLogic {
    func signup(userDetail: SignupDataModel)
}

class SignupInteractor: SignupBusinessLogic {
    var worker: SignupWorkerProtocol?
    var presenter: SignupPresentationLogic?
    
    func signup(userDetail: SignupDataModel) {
        worker?.signup(userDetail: userDetail, success: { (successEmail) in
            self.presenter?.displayDataSuccess(prompt: successEmail)
        }, failure: { (error) in
            self.presenter?.displayDataError(prompt: error)
        })
    }
}
