//
//  MovieDetailsViewController.swift
//  movie-app-iOS
//
//  Created by mac on 07/11/2020.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

protocol MovieDetailsDisplayLogic {
    func displaySuccessAlert(prompt: [CommentDataModelResponse])
    func displayFailureAlert(prompt: String)
}

class MovieDetailsViewController: UIViewController {
    var movieDetailsInteractor: MovieDetailsBusinessLogic?
    var scrollView = UIScrollView(frame: .zero)
    var imageView = UIImageView()
    var cardView = UIView()
    var viewContainer = UIView()
    var verticalStackView = UIStackView()
    var movieTitle = UILabel()
    var movieGenre = UILabel()
    var ticketPrice = UILabel()
    var movieRating = UILabel()
    var country = UILabel()
    var releaseDate = UILabel()
    var descriptionLabel = UILabel()
    var descriptionView = UITextView()
    var commentLabel = UILabel()
    var commentField = UITextView()
    var addCommentButton = UIButton()
    var commentTableView = UITableView(frame: .zero, style: .plain)
    var movie: MovieDataModel?
    var movieComments: [CommentDataModelResponse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchComments()
        setupViews()
        commentTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        view.backgroundColor = #colorLiteral(red: 0.9449954033, green: 0.9451572299, blue: 0.9449852109, alpha: 1)
        setupNavigationBar()
        self.commentTableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    func setup() {
        let presenter = MovieDetailsPresenter()
        presenter.MovieDetailsView = self
        let worker = MovieDetailsWorker()
        let interactor = MovieDetailsInteractor()
        interactor.presenter = presenter
        interactor.worker = worker
        self.movieDetailsInteractor = interactor
    }
    
    func setupViews() {
        setupScrollView()
        setupImageView()
        setupViewContainer()
        setupCardView()
        setupVerticalStackView()
        setupVerticalView()
        setupDescriptionLabel()
        setupDescriptionView()
        setupCommentLabel()
        setupCommentTableView()
        setupCommentField()
        setupAddCommentButton()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.frame = self.view.bounds
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 500)
        scrollView.bounces = true
    }
    
    func setupImageView() {
        scrollView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(scrollView.snp.width)
            make.height.equalTo(scrollView.snp.height).multipliedBy(0.1)
            make.top.equalTo(scrollView).offset(150)
        }
    }
    
    func setupViewContainer() {
        scrollView.addSubview(viewContainer)
        viewContainer.backgroundColor = .clear
        viewContainer.layer.cornerRadius = 5
        viewContainer.clipsToBounds = true
        viewContainer.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(280)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(scrollView.snp.height).multipliedBy(0.2)
        }
    }
    
    func setupVerticalStackView() {
        viewContainer.addSubview(verticalStackView)
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalSpacing
        verticalStackView.snp.makeConstraints { (make) in
            make.top.equalTo(viewContainer.snp.top).offset(0)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.bottom.equalTo(viewContainer.snp.bottom)
        }
    }
    
    func setupVerticalView() {
        movieTitle.font = UIFont.boldSystemFont(ofSize: 25)
        movieGenre.font = UIFont.systemFont(ofSize: 16)
        movieGenre.textColor = .gray
        ticketPrice.font = UIFont.systemFont(ofSize: 16)
        ticketPrice.textColor = .gray
        movieRating.font = UIFont.systemFont(ofSize: 16)
        movieRating.textColor = .gray
        country.font = UIFont.systemFont(ofSize: 16)
        country.textColor = .gray
        releaseDate.textColor = .gray
        releaseDate.font = UIFont.systemFont(ofSize: 16)
        verticalStackView.addArrangedSubview(movieTitle)
        verticalStackView.addArrangedSubview(movieGenre)
        verticalStackView.addArrangedSubview(ticketPrice)
        verticalStackView.addArrangedSubview(movieRating)
        verticalStackView.addArrangedSubview(country)
        verticalStackView.addArrangedSubview(releaseDate)
    }
    
    func setupCardView() {
        scrollView.addSubview(cardView)
        cardView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cardView.layer.cornerRadius = 5
        cardView.clipsToBounds = true
        cardView.snp.makeConstraints { (make) in
            make.top.equalTo(viewContainer.snp.bottom).offset(30)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(scrollView.snp.height).multipliedBy(0.2)
        }
    }
    
    func setupDescriptionLabel() {
        cardView.addSubview(descriptionLabel)
        descriptionLabel.text = MovieDetailsConstants.descriptionTitle
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cardView.snp.top).offset(10)
            make.left.equalTo(cardView).offset(10)
            make.right.equalTo(view).offset(-20)
        }
    }
    
    func setupDescriptionView() {
        scrollView.addSubview(descriptionView)
        descriptionView.backgroundColor = .clear
        descriptionView.textColor = .darkGray
        descriptionView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionView.isEditable = false
        descriptionView.sizeToFit()
        descriptionView.isScrollEnabled = false
        descriptionView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(cardView).offset(5)
            make.right.equalTo(view).offset(-20)
        }
    }
    
    func setupCommentLabel() {
        scrollView.addSubview(commentLabel)
        commentLabel.textColor = .darkGray
        commentLabel.text = "Comment:"
        commentLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(cardView.snp.bottom).offset(30)
            make.height.equalTo(scrollView.snp.height).multipliedBy(0.04)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
    }
    
    func setupCommentTableView() {
        commentTableView.dataSource = self
        commentTableView.delegate = self
        scrollView.addSubview(commentTableView)
        commentTableView.snp.makeConstraints { (make) in
            make.top.equalTo(commentLabel.snp.bottom).offset(10)
            make.height.equalTo(250)
            make.width.equalTo(scrollView.snp.width)
        }
    }
    
    func setupCommentField() {
        scrollView.addSubview(commentField)
        commentField.backgroundColor = .clear
        commentField.textColor = .black
        commentField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        commentField.layer.borderWidth = 1
        commentField.layer.borderColor = UIColor.lightGray.cgColor
        commentField.snp.makeConstraints { (make) in
            make.top.equalTo(commentTableView.snp.bottom).offset(0)
            make.height.equalTo(scrollView.snp.height).multipliedBy(0.04)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
    }
    
    func setupAddCommentButton() {
        scrollView.addSubview(addCommentButton)
        addCommentButton.setTitle(MovieDetailsConstants.addCommentButtonTitle, for: .normal)
        addCommentButton.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 16)
        addCommentButton.backgroundColor = #colorLiteral(red: 0.03529411765, green: 0.1098039216, blue: 0.2980392157, alpha: 1)
        addCommentButton.tintColor = .white
        addCommentButton.layer.cornerRadius = 5
        addCommentButton.addTarget(self, action: #selector(handleAddComments), for: .touchUpInside)
        addCommentButton.snp.makeConstraints { (make) in
            make.top.equalTo(commentField.snp.bottom).offset(30)
            make.height.equalTo(scrollView.snp.height).multipliedBy(0.04)
            make.left.equalTo(view).offset(20)
            make.width.equalTo(view.snp.width).multipliedBy(0.4)
        }
    }
    
    @objc func handleAddComments() {
        if isUserLoggedIn() {
            addCommentButton.isEnabled = true
            print("comment is enabled")
            let comment = commentField.text
            let movieid = movie?.id
            let user = String()
            let userComment = CommentDataModel(comment: comment ?? String(), movieId: movieid ?? String(), user: user)
            commentField.text = ""
            movieDetailsInteractor?.postComment(userComment: userComment)
        } else {
            let alertController = UIAlertController(title: "Please Login", message: "Login to post comments", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: ValidationConstants.alertDismiss, style: .default))
            self.present(alertController, animated: true, completion: nil)
            print("comment is disabled")
        }
    }
    
    func fetchComments() {
        Database.database().reference().child("Comments").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let comments = CommentDataModelResponse()
                comments.setValuesForKeys(dictionary)
                if self.movie?.id == comments.movieId {
                    self.movieComments.insert(comments, at: 0)
                }
                self.commentTableView.reloadData()
            }
        }, withCancel: nil)
    }
}

extension MovieDetailsViewController: MovieDetailsDisplayLogic, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.numberOfLines = 0;
        cell.textLabel?.lineBreakMode = .byWordWrapping
        let item = movieComments[indexPath.row]
        cell.textLabel?.text = "\(item.user ?? String()):\n\(item.comment ?? String())"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 40
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 40
        }
    }
    
    
    func displaySuccessAlert(prompt: [CommentDataModelResponse]) {
        
    }
    
    func displayFailureAlert(prompt: String) {
        self.handleNetworkError(prompt: prompt)
    }
    
}
