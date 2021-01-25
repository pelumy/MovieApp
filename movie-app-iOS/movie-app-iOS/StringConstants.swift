//
//  String Constants.swift
//  movie-app-iOS
//
//  Created by Ikechukwu Onuorah on 07/11/2020.
//

import UIKit

enum SingupConstants {
    static let userName = "Username"
    static let title = "Signup"
    static let email = "Email"
    static let password = "Password"
    static let loginTitle = "Already have an account?"
}

enum LoginConstants {
    static let titleText = "Login"
    static let subtitleText = "Welcome to the movie world"
    static let emailPlaceholder = "example@email.com"
    static let passwordPlaceholder = "password"
    static let loginButtonTitle = "LOGIN"
    static let signupButtonTitle = "Create account"
}

enum AddMovieConstants {
    static let titlePlaceholder = NSMutableAttributedString(
        string: "Title", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
    static let genrePlaceholder = NSMutableAttributedString(
        string: "Genre", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
    static let ratingPlaceholder = NSMutableAttributedString(
        string: "Ratings", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
    static let countryPlaceholder = NSMutableAttributedString(
        string: "Country", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
    static let releasePlaceholder = NSMutableAttributedString(
        string: "Release date", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
    static let ticketPlaceholder = NSMutableAttributedString(
        string: "Ticket price", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
    static let descriptionPlaceholder = NSMutableAttributedString(
        string: "Description", attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ])
    static let addPhotoTitle = "Add Photo"
    static let addMovieTitle = "Add Movie"
}

enum MovieDetailsConstants {
    static let descriptionTitle = "Description"
    static let addCommentButtonTitle = "Add Comment"
    static let descriptionText = "This is a movie"
}

enum LoginWorkerConstants {
    static let invalidOperation = "Operation Not Allowed"
    static let userDisabled = "User has been Disabled"
    static let wrongPassword = "Wrong password"
    static let invalidEmail = "Invalid email"
    static let successMessage = "User signs in successfully"
}

enum ValidationConstants {
    static let invalidNameTitle = "Invalid Name"
    static let invalidNameMessage = "Length must be 18 characters max and 3 characters minimum"
    static let alertDismiss = "Dismiss"
    static let invalidEmailTitle = "Input Email"
    static let invalidEmailMessage = "Please input a valid email address"
    static let invalidPasswordTitle = "Incorrect Password"
    static let invalidPasswordMessage = "Minimum 8 characters at least 1 alphabet and 1 number"
}

enum ListMoviesConstants {
    static let customCellIdentifier = "customCellIdentifier"
    static let listMoviesTitle = "Movie App"
    static let logoutTitle = "Logout"
    static let addMovieTitle = "Add Movie"
    static let loginTitle = "Login"
    static let backTitle = "Back"
    static let fatalError = "Could not deque cell"
}
