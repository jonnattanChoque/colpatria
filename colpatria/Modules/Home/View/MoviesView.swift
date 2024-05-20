//
//  MoviesView.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import UIKit

class MoviesView: UIView {
    private let cellId: String = "CellID"
    private let divider = 2.0
    private let marginHorizontal: CGFloat = 12
    private let marginVertical: CGFloat = 10
    private let heightMinus: CGFloat = 50
    private let heightPercent: CGFloat = 0.6
    var model: [Movie] = []
    
    lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.register(MovieViewCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: FontSize.big.rawValue)
        label.text = Strings.Home.EmptyTitle
        return label
    }()
    
    init(model: [Movie]? = []) {
        super.init(frame: .zero)
        
        if let movies = model {
            self.model = movies
            setupViews()
        } else {
            setupEmpty()
        }
    }
    
    func updateContent(newData: [Movie] = []) {
        collectionview.removeFromSuperview()
        emptyLabel.removeFromSuperview()
        
        if newData.count > .zero {
            self.model = newData
            
            setupViews()
            collectionview.reloadData()
        } else {
            setupEmpty()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(collectionview)
        
        collectionview.autoPinEdge(toSuperviewEdge: .top, withInset: marginVertical)
        collectionview.autoPinEdge(toSuperviewEdge: .left, withInset: marginHorizontal)
        collectionview.autoPinEdge(toSuperviewEdge: .right, withInset: marginHorizontal)
        collectionview.autoPinEdge(toSuperviewEdge: .bottom, withInset: marginVertical)
    }
    
    func setupEmpty() {
        addSubview(emptyLabel)
        emptyLabel.autoCenterInSuperview()
    }
}

extension MoviesView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieViewCell
        let model = model[indexPath.row]
        cell.setup(model: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height - heightMinus
        let width = height * heightPercent
        return CGSize(width: width, height: height)
    }
}
