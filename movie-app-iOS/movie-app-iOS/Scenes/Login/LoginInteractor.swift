//
//  LoginInteractor.swift
//  movie-app-iOS
//
//  Created by Ikechukwu Onuorah on 08/11/2020.
//

import Foundation

protocol LoginBusinessLogic {
    func login(userDetail: LoginDataModel)
}

class LoginInteractor: LoginBusinessLogic {
    var worker: loginWorkerProtocol?
    var presenter: LoginPresentationLogic?
    
    func login(userDetail: LoginDataModel) {
        worker?.login(userDetail: userDetail, success: { (successEmail) in
            self.presenter?.displayDataSuccess(prompt: successEmail)
        }, failure: { (error) in
            self.presenter?.displayDataError(prompt: error)
        })
    }
}

