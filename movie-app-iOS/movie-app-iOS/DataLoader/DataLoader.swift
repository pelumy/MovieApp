//
//  DataLoader.swift
//  movie-app-iOS
//
//  Created by USER on 08/11/2020.
//

import Foundation
import Firebase
class DataLoader {
//    static func loadMovies(completionHandler: @escaping ([MovieDataModel]) -> ()) {
//        if let moviesLocation = Bundle.main.url(forResource: "jsonformatter", withExtension: "json") {
//            do {
//                let movies = try Data(contentsOf: moviesLocation)
//                let jsonDecoder = JSONDecoder()
//                let moviesFromJson = try jsonDecoder.decode([MovieDataModel].self, from: movies)
//                completionHandler(moviesFromJson)
//                print(moviesFromJson)
//            } catch {
//                print(error)
//            }
//        }
//    }
    
//    func showImage() {
//
//        Database.database().reference().child("iosMovies").child("abcd").observeSingleEvent(of: .value, with: { snapshot in
//            if let url = snapshot.value as? String {
//                URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
//                    if error == nil {
//                        let image = UIImage(data: data!)
//                        imageView.image = image
//                    }
//                }.resume()
//            }
//        })
//    }
    
//    func showImage() {
//
//        Database.database().reference().child("Images").child("abcd").observeSingleEvent(of: .value, with: { snapshot in
//            if let url = snapshot.value as? String {
//                URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
//                    if error == nil {
//                        let image = UIImage(data: data!)
//                        imageView.image = image
//                    }
//                }.resume()
//            }
//        })
//    }
}
