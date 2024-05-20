//
//  MoviesViewController.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import PureLayout

class MoviesViewController: UIViewController {
    weak var presenter: MoviesPresenterProtocol?
    var queryMovie: String?
    private var carouselView: MovieSearchView?
    private let cellId: String = "CellID"
    private let heightMinus: CGFloat = 50
    private let heightPercent: CGFloat = 0.6
    private let marginHorizontal: CGFloat = 12
    private let marginTop: CGFloat = 10
    private let carouselHeight: CGFloat = 580
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    lazy var mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: FontSize.big.rawValue)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Home.EmptyTitle
        label.font = UIFont.boldSystemFont(ofSize: FontSize.big.rawValue)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        view.accessibilityIdentifier = "MoviesViewController"
        self.view.showBlurLoader()
        presenter?.viewDidLoad()
    }
    
    private func setupEmpty() {
        self.view.addSubview(emptyLabel)
        emptyLabel.autoCenterInSuperview()
    }
    
    private func addViews() {
        titleLabel.text = Strings.Movie.Title.appending(queryMovie ?? "")
        carouselView = MovieSearchView(movies: presenter?.responseMovie?.results)
        
        view.addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(carouselView ?? UIView())
    }
    
    private func configureConstrain() {
        mainView.autoPinEdge(toSuperviewEdge: .top)
        mainView.autoPinEdge(toSuperviewEdge: .right)
        mainView.autoPinEdge(toSuperviewEdge: .left)
        mainView.autoPinEdge(toSuperviewEdge: .bottom)
        
        titleLabel.autoPinEdge(toSuperviewMargin: .top)
        titleLabel.autoPinEdge(toSuperviewMargin: .leading)
        titleLabel.autoPinEdge(toSuperviewMargin: .trailing)
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        carouselView?.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: marginTop)
        carouselView?.autoPinEdge(toSuperviewMargin: .leading)
        carouselView?.autoPinEdge(toSuperviewMargin: .trailing)
        carouselView?.autoPinEdge(toSuperviewEdge: .bottom, withInset: marginHorizontal)
    }
}

extension MoviesViewController: MoviesViewProtocol {
    func showEmptyResults() {
        self.view.removeBluerLoader()
        setupEmpty()
    }
    
    func showSuccessResult() {
        self.view.removeBluerLoader()
        addViews()
        configureConstrain()
    }
    
    func showErrorResults() {
        self.view.removeBluerLoader()
        let alert = Alerts.shared.simple(title: Strings.Home.AlertErrorMessage, message: Strings.Home.AlertErrorMessage)
        present(alert, animated: true)
    }
    
    func showEmptyQuery() {
        let alert = Alerts.shared.simple(title: Strings.Home.AlertEmptyTitle, message: Strings.Home.AlertEmptyMessage)
        present(alert, animated: true)
    }
}
