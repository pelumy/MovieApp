//
//  MovieDetailsPresenter.swift
//  movie-app-iOS
//
//  Created by Ikechukwu Onuorah on 10/11/2020.
//

import Foundation

protocol MovieDetailsPresentationLogic {
    func displayDataSuccess(prompt: [CommentDataModelResponse])
    func displayDataError(prompt: String)
}

class MovieDetailsPresenter:MovieDetailsPresentationLogic {
    var MovieDetailsView: MovieDetailsDisplayLogic?
    
    func displayDataSuccess(prompt: [CommentDataModelResponse]) {
        MovieDetailsView?.displaySuccessAlert(prompt: prompt)
    }
    
    func displayDataError(prompt: String) {
        MovieDetailsView?.displayFailureAlert(prompt: prompt)
    }
}
