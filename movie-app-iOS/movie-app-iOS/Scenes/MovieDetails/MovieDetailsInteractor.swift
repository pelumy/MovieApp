//
//  MovieDetailsInteractor.swift
//  movie-app-iOS
//
//  Created by Ikechukwu Onuorah on 10/11/2020.
//

import Foundation

protocol MovieDetailsBusinessLogic {
    func postComment(userComment: CommentDataModel)
}

class MovieDetailsInteractor: MovieDetailsBusinessLogic {
    var worker: MovieDetailsWorkerProtocol?
    var presenter: MovieDetailsPresentationLogic?

    func postComment(userComment: CommentDataModel) {
        worker?.postComment(userComment: userComment, success: { (allComments) in
            self.presenter?.displayDataSuccess(prompt: allComments)
        }, failure: { (error) in
            self.presenter?.displayDataError(prompt: error)
        })
    }
}
