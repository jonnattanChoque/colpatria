//
//  MovieSearchView.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import UIKit

class MovieSearchView: UIView {
    private let cellId: String = "CellID"
    private let divider = 2.0
    private let marginHorizontal: CGFloat = 12
    private let marginVertical: CGFloat = 10
    private let heightMinus: CGFloat = 50
    private let heightPercent: CGFloat = 0.6
    private var model: [Movie] = []
    
    lazy var collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 15
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.register(MovieViewCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()
    
    init(movies: [Movie]? = []) {
        super.init(frame: .zero)
        self.model = movies ?? []
        setupViews()
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
}

extension MovieSearchView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
