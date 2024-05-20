//
//  MovieViewCell.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import UIKit

class MovieViewCell: UICollectionViewCell {
    private let places: Int = 1
    private let radius: CGFloat = 16
    private let marginHorizontal: CGFloat = 8
    private let marginButton: CGFloat = 8
    private let scoreSize: CGSize = CGSize(width: 50, height: 50)
    private let scoreButtonMargin: CGFloat = 120
    private let heightPercent: CGFloat = 0.75
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addDesign()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: FontSize.big.rawValue)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: FontSize.medium.rawValue)
        label.textColor = .darkGray
        return label
    }()
    
    let scoreView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen.withAlphaComponent(0.7)
        view.layer.cornerRadius = 25
        return view
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: FontSize.small.rawValue)
        label.textColor = .white
        return label
    }()
    
    public func setup(model: Movie) {
        let average = model.voteAverage.rounded(toPlaces: places)
        titleLabel.text = model.title
        dateLabel.text = model.releaseDate.formatDate()
        scoreLabel.text = String(average)
        
        ImageDownloader.downloadImage(Constants.imagePath.appending(model.posterPath)) {
          image, urlString in
             if let imageObject = image {
                DispatchQueue.main.async {
                    self.imageView.image = imageObject
                }
             }
        }
    }
    
    private func addDesign() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = radius
        contentView.dropShadow(scale: true)
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(scoreView)
        scoreView.addSubview(scoreLabel)
        
        imageView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .bottom)
        imageView.autoSetDimension(.height, toSize: frame.height * heightPercent)
        
        scoreView.autoPinEdge(toSuperviewEdge: .left, withInset: marginHorizontal)
        scoreView.autoPinEdge(toSuperviewEdge: .bottom, withInset: scoreButtonMargin)
        scoreView.autoSetDimensions(to: scoreSize)
        
        scoreLabel.autoCenterInSuperview()
        
        titleLabel.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: marginButton)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: marginHorizontal)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: marginHorizontal)
        
        dateLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: marginButton)
        dateLabel.autoPinEdge(toSuperviewEdge: .left, withInset: marginHorizontal)
        dateLabel.autoPinEdge(toSuperviewEdge: .right, withInset: marginHorizontal)
        dateLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: marginButton)
    }
}
