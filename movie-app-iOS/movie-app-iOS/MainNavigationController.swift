//
//  MainNavigationController.swift
//  movie-app-iOS
//
//  Created by Ikechukwu Onuorah on 07/11/2020.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstScreen = ListMovieViewController()
        viewControllers = [firstScreen]
    }
}
