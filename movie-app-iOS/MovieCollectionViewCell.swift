//
//  MovieCollectionViewCell.swift
//  movie-app-iOS
//
//  Created by Lima on 08/11/2020.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var viewContainer = UIView()
    var movieThumbNail = UIImageView()
    var movieDetails = UIStackView()
    var movieTitle = UILabel()
    var movieGenre = UILabel()
    var movieRatings = UILabel()
    var movieTicketPrice = UILabel()
    var movieCountry = UILabel()
    var movieReleaseDate = UILabel()
    var movieDescription = UILabel()
    
    func setupViewController() {
        addSubview(viewContainer)
        viewContainer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        viewContainer.layer.cornerRadius = 8
        viewContainer.clipsToBounds = true
        viewContainer.snp.makeConstraints { (make) in
            make.top.equalTo(50)
            make.left.equalTo(35)
            make.right.equalTo(-35)
            make.height.equalTo(180)
        }
    }
    
    func setupMovieThumbNail() {
        viewContainer.addSubview(movieThumbNail)
        movieThumbNail.contentMode = .scaleAspectFill
        movieThumbNail.clipsToBounds = true
        movieThumbNail.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(viewContainer).multipliedBy(0.4)
        }
    }
    
    func setupMovieDetails() {
        viewContainer.addSubview(movieDetails)
        movieDetails.addArrangedSubview(movieTitle)
        movieDetails.addArrangedSubview(movieGenre)
        movieDetails.addArrangedSubview(movieRatings)
        movieDetails.addArrangedSubview(movieTicketPrice)
        movieDetails.setCustomSpacing(10, after: movieTitle)
        movieDetails.setCustomSpacing(8, after: movieGenre)
        movieDetails.setCustomSpacing(25, after: movieRatings)
        movieDetails.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        movieDetails.axis = .vertical
        movieDetails.alignment = .top
        movieDetails.distribution = .fillEqually
        movieDetails.spacing = 10
        movieDetails.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
            make.width.equalTo(viewContainer).multipliedBy(0.56)
            make.height.equalTo(viewContainer).multipliedBy(0.80)
        }
    }
    
    func setupMovieTitle() {
        movieTitle.font = .systemFont(ofSize: 16, weight: .bold)
        movieTitle.text = movieCell?.title
        movieTitle.textColor = #colorLiteral(red: 0.1254901961, green: 0.1529411765, blue: 0.1960784314, alpha: 1)
        movieTitle.lineBreakMode = .byWordWrapping
        movieTitle.numberOfLines = 0
        movieTitle.snp.makeConstraints { (make) in
            make.top.equalTo(movieDetails).offset(25)
        }
    }
    
    func setupMovieGenre() {
        movieGenre.font = .systemFont(ofSize: 14, weight: .bold)
        movieGenre.text = movieCell?.genre
        movieGenre.textColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
        movieGenre.snp.makeConstraints { (make) in
        }
    }
    
    func setupMovieRatings() {
        movieRatings.font = .systemFont(ofSize: 14, weight: .bold)
        movieRatings.text = movieCell?.rating
        movieRatings.textColor = #colorLiteral(red: 0.7450980392, green: 0.7450980392, blue: 0.7450980392, alpha: 1)
        movieRatings.snp.makeConstraints { (make) in
        }
    }
    
    func setupMovieTicketPrice() {
        movieTicketPrice.font = .systemFont(ofSize: 16, weight: .bold)
        movieTicketPrice.text = movieCell?.ticketPrice
        movieTicketPrice.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        movieTicketPrice.snp.makeConstraints { (make) in
        }
    }
    
    func setupMovieCountry() {
        movieCountry.font = .systemFont(ofSize: 14, weight: .bold)
        movieCountry.text = movieCell?.country
        movieCountry.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        movieCountry.snp.makeConstraints { (make) in
        }
    }
    
    func setupmovieReleaseDate() {
        movieReleaseDate.font = .systemFont(ofSize: 14, weight: .bold)
        movieReleaseDate.text = movieCell?.releaseDate
        movieReleaseDate.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        movieReleaseDate.snp.makeConstraints { (make) in
        }
    }
    
    func setupmovieDescription() {
        movieDescription.font = .systemFont(ofSize: 14, weight: .bold)
        movieDescription.text = movieCell?.movieDescription
        movieDescription.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        movieDescription.snp.makeConstraints { (make) in
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutViews()
    }
    
    func layoutViews() {
        setupViewController()
        setupMovieThumbNail()
        setupMovieDetails()
        setupMovieTitle()
        setupMovieGenre()
        setupMovieRatings()
        setupMovieTicketPrice()
    }
    
    var movieCell: MovieDataModel? {
        didSet {
            guard let movieCell = movieCell else { return }
            movieThumbNail.image = UIImage(named: movieCell.image ?? "")
            movieTitle.text = movieCell.title
            movieGenre.text = movieCell.genre
            movieRatings.text = "Rated \(movieCell.rating ?? String())"
            movieTicketPrice.text = "₦ \(movieCell.ticketPrice ?? String())"
            movieCountry.text = movieCell.country
            movieReleaseDate.text = movieCell.releaseDate
            movieDescription.text = movieCell.movieDescription
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
