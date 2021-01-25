//
//  CommentDataModel.swift
//  movie-app-iOS
//
//  Created by Ikechukwu Onuorah on 10/11/2020.
//

import Foundation

@objcMembers class CommentDataModelResponse: NSObject {//} Codable {
    var comment, movieId, user: String?
}

struct CommentDataModel {
    var comment, movieId, user: String
}
