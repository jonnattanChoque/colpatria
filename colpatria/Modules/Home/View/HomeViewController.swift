//
//  HomeViewController.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import UIKit
import PureLayout

class HomeViewController: UIViewController {
    weak var presenter: HomePresenterProtocol?
    let searchController = UISearchController(searchResultsController: nil)
    var isAdultFilter: Bool = false
    var selectedLanguage: String = "en"
    var minVoteAverage: Double = 0
    var maxVoteAverage: Double = 10
    var segmentSelected = 0
    var popularView: MoviesView?
    var topRatedView: MoviesView?
    var filterView = FilterView()
    private let items = ["Popular", "Top"]
    private let topMargin: CGFloat = 20
    private let duration = 0.3
    private let marginButtonHorizontal: CGFloat = 50
    
    private lazy var segmented: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.frame = CGRect(x: 35, y: 200, width: 250, height: 50)
        segmentedControl.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.accessibilityIdentifier = "segmentControl"
        return segmentedControl
    }()
    
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.setTitle(Strings.Home.FilterShow, for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.accessibilityIdentifier = "filterButton"
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchController()
        self.view.backgroundColor = .white
        self.view.showBlurLoader()
        presenter?.viewDidLoad()
    }
    
    private func addSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Strings.Home.Search
        searchController.searchBar.accessibilityIdentifier = "searchBar"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func addViews() {
        self.view.addSubview(segmented)
        segmented.autoPinEdge(toSuperviewMargin: .top)
        segmented.autoPinEdge(toSuperviewMargin: .left)
        segmented.autoPinEdge(toSuperviewMargin: .right)
        
        self.view.addSubview(filterButton)
        filterButton.autoPinEdge(.top, to: .bottom, of: segmented, withOffset: topMargin)
        filterButton.autoPinEdge(toSuperviewEdge: .leading, withInset: marginButtonHorizontal)
        filterButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: marginButtonHorizontal)
        
        popularView = MoviesView(model: presenter?.responsePopular?.results)
        topRatedView = MoviesView(model: presenter?.responseTopRated?.results)
        
        guard let firstView = popularView, let secondView = topRatedView else { return }
        self.view.addSubview(firstView)
        self.view.addSubview(secondView)
        
        firstView.autoPinEdge(.top, to: .bottom, of: filterButton)
        firstView.autoPinEdge(toSuperviewEdge: .leading)
        firstView.autoPinEdge(toSuperviewEdge: .trailing)
        firstView.autoPinEdge(toSuperviewEdge: .bottom)
        
        secondView.autoPinEdge(.top, to: .bottom, of: filterButton, withOffset: topMargin)
        secondView.autoPinEdge(toSuperviewEdge: .leading)
        secondView.autoPinEdge(toSuperviewEdge: .trailing)
        secondView.autoPinEdge(toSuperviewEdge: .bottom)
        
        firstView.isHidden = false
        secondView.isHidden = true
    }
    
    private func presentFilterModal() {
        filterView.delegate = self
        filterView.addToWindow()
    }
    
    @objc func segmentAction(_ sender: UISegmentedControl) {
        guard let firstView = popularView, let secondView = topRatedView else { return }
        segmentSelected = sender.selectedSegmentIndex
        let fromView = sender.selectedSegmentIndex == .zero ? secondView : firstView
        let toView = sender.selectedSegmentIndex == .zero ? firstView : secondView
        
        UIView.transition(from: fromView, to: toView, duration: duration, options: [.transitionCrossDissolve, .showHideTransitionViews], completion: nil)
    }
    
    @objc func filterButtonTapped(_ sender: UIButton) {
        presentFilterModal()
    }
}

extension HomeViewController: FilterViewDelegate {
    func didUpdateAdultFilter(isAdult: Bool) {
        self.isAdultFilter = isAdult
    }
    
    func didUpdateLanguageFilter(selectedLanguage: String) {
        self.selectedLanguage = selectedLanguage
    }
    
    func didUpdateVoteAverageFilter(minVoteAverage: Float, maxVoteAverage: Float) {
        self.minVoteAverage = Double(minVoteAverage)
        self.maxVoteAverage = Double(maxVoteAverage)
    }
    
    func didCancelFilter() {
        filterView.removeFromSuperview()
    }
    
    func didApplyFilter() {
        filterView.removeFromSuperview()
        presenter?.applyFilters(segmentSelected: segmentSelected, isAdultFilter: isAdultFilter, selectedLanguage: selectedLanguage, minVoteAverage: minVoteAverage, maxVoteAverage: maxVoteAverage)
    }
    
    func didRemoveFilter() {
        filterView.removeFromSuperview()
        if(segmentSelected == .zero) {
            guard let data = presenter?.responsePopular?.results else { return }
            popularView?.updateContent(newData: data)
        } else {
            guard let data = presenter?.responseTopRated?.results else { return }
            topRatedView?.updateContent(newData: data)
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let navigation = navigationController else { return }
        presenter?.showNextView(navigationController: navigation, movie: searchBar.text ?? "")
        searchBar.text = ""
    }
}

extension HomeViewController: HomeViewProtocol {
    func showErrorResults() {
        self.view.removeBluerLoader()
        let alert = Alerts.shared.simple(title: Strings.Home.AlertErrorTitle, message: Strings.Home.AlertErrorMessage)
        self.present(alert, animated: true)
    }
    
    func showSuccessResult() {
        self.view.removeBluerLoader()
        addViews()
    }
    
    func updatePopular(data: [Movie]) {
        popularView?.updateContent(newData: data)
    }
    
    func updateTopRated(data: [Movie]) {
        topRatedView?.updateContent(newData: data)
    }
}
