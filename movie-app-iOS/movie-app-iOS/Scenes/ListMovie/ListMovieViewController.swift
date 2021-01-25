//
//  ListMovieViewController.swift
//  movie-app-iOS
//
//  Created by Lima on 08/11/2020.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ListMovieViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    func setupCollectionViewConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    var movies: [MovieDataModel] = []
    let customCellIdentifier = ListMoviesConstants.customCellIdentifier

    
    private func addBackgroundGradient() {
        let collectionViewBackgroundView = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = view.frame.size
        gradientLayer.colors = [#colorLiteral(red: 0.9643282043, green: 0.9643282043, blue: 0.9643282043, alpha: 1).cgColor, #colorLiteral(red: 0.8984032858, green: 0.8984032858, blue: 0.8984032858, alpha: 1).cgColor]
        collectionView.backgroundView = collectionViewBackgroundView
        collectionView.backgroundView?.layer.addSublayer(gradientLayer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        fetchMovies()
        addBackgroundGradient()
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: customCellIdentifier)
        layoutViews()
//        DataLoader.loadMovies { movieData in
//            self.movies = movieData
//        }
    }
    
    func isUserLoggedIn() -> Bool {
      return Auth.auth().currentUser != nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        title = ListMoviesConstants.listMoviesTitle
        setupNavigationBar()
        
        if isUserLoggedIn() {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: ListMoviesConstants.logoutTitle, style: .plain, target: self, action: #selector(handleLogout))
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: ListMoviesConstants.addMovieTitle, style: .plain, target: self, action: #selector(addMovie))
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: ListMoviesConstants.loginTitle, style: .plain, target: self, action: #selector(handleLogin))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: ListMoviesConstants.backTitle, style: .plain, target: nil, action: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: customCellIdentifier, for: indexPath) as? MovieCollectionViewCell else { fatalError(ListMoviesConstants.fatalError) }
        let movie = movies[(indexPath as NSIndexPath).item]
        customCell.movieCell = movie
        if let profileImageUrl = movie.image {
            customCell.movieThumbNail.loadImageUsingCacheWithUrlString(urlString: profileImageUrl)
        }
        return customCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.safeAreaLayoutGuide.layoutFrame.width, height: view.safeAreaLayoutGuide.layoutFrame.height/3.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = MovieDetailsViewController()
        let cell = collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell
        viewController.movie = movies[(indexPath as NSIndexPath).item]
        viewController.movieTitle.text = cell?.movieTitle.text
        viewController.imageView.image = cell?.movieThumbNail.image
        viewController.movieGenre.text = cell?.movieGenre.text
        viewController.movieRating.text = cell?.movieRatings.text
        viewController.ticketPrice.text = cell?.movieTicketPrice.text
        viewController.country.text = cell?.movieCountry.text
        viewController.releaseDate.text = cell?.movieReleaseDate.text
        viewController.descriptionView.text = cell?.movieDescription.text
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func layoutViews() {
        setupCollectionViewConstraints()
    }
    
    @objc func addMovie() {
        let viewController = AddMovieViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func fetchMovies() {
        Database.database().reference().child("Movies").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let movie = MovieDataModel()
                movie.setValuesForKeys(dictionary)
                self.movies.insert(movie, at: 0)
                print(movie.image ?? "", "<><><><><><><{}{}{}}{}{}")
                
                DispatchQueue.global(qos: .background).async {
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            }
        }, withCancel: nil)
    }
    
    @objc func handleLogout() {
        do {
          try Auth.auth().signOut()
        } catch {
          print("Sign out error")
        }
        let view = SignupViewController()
        navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func handleLogin() {
        let view = LoginViewController()
        navigationController?.pushViewController(view, animated: true)
    }
    
}

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func loadImageUsingCacheWithUrlString(urlString: String) {
//        check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSObject) as? UIImage {
            self.image = cachedImage
            return
        }
//        otherwise fire off a new download
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error ?? "")
                return
            }
            DispatchQueue.global(qos: .background).async {
                DispatchQueue.main.async {
                    if let downloadedImage = UIImage(data: data ?? Data()) {
                        imageCache.setObject(downloadedImage, forKey: urlString as NSObject)
                        self.image = downloadedImage
                    }
                }
            }
        }).resume()
    }
}
