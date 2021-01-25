//
//  MovieDetailsWorker.swift
//  movie-app-iOS
//
//  Created by Ikechukwu Onuorah on 10/11/2020.
//

import Firebase
import FirebaseDatabase

protocol MovieDetailsWorkerProtocol {
    func postComment(userComment: CommentDataModel, success: @escaping ([CommentDataModelResponse]) -> (), failure: @escaping (String) -> ())
}

class MovieDetailsWorker: MovieDetailsWorkerProtocol {
    var ref: DatabaseReference!
    var allMovieComments: [CommentDataModelResponse] = []
    
    func postComment(userComment: CommentDataModel, success: @escaping ([CommentDataModelResponse]) -> (), failure: @escaping (String) -> ()) {
        ref = Database.database().reference()
        ref?.child("Comments")
        var userName = String()
        
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            userName = snapshot.value as? String ?? String()
            let key = self.ref?.child("Comments").childByAutoId().key
            let comment = [
                "comment": userComment.comment,
                "movieId": userComment.movieId,
                "user": userName
            ]
            self.ref?.child("Comments").child(key ?? "").setValue(comment)
          }) { (error) in
            print(error.localizedDescription)
        }
        print(self.allMovieComments)
    }
}
