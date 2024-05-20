//
//  HomeProtocols.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import UIKit

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? {get set}
    var interactor: HomeInteractorProtocol? {get set}
    var router: HomeRouterProtocol? {get set}
    var responsePopular: MoviesModel? {get set}
    var responseTopRated: MoviesModel? {get set}
    func viewDidLoad()
    func showNextView(navigationController: UINavigationController, movie: String)
    func applyFilters(segmentSelected: Int, isAdultFilter: Bool, selectedLanguage: String, minVoteAverage: Double, maxVoteAverage: Double)
}

protocol HomeViewProtocol: AnyObject {
    func showErrorResults()
    func showSuccessResult()
    func updatePopular(data: [Movie])
    func updateTopRated(data: [Movie])
}

protocol HomeRouterProtocol: AnyObject {
    static func createModule()-> HomeViewController
    func pushToMovieScreen(navigationController: UINavigationController, movie: String)
}

protocol HomeInteractorProtocol: AnyObject {
    var presenter: HomePresenterViewProtocol? {get set}
    func getTopRated()
    func getPopular()
}

protocol HomePresenterViewProtocol: AnyObject {
    func homeFetchedSuccessPopular(results: MoviesModel)
    func homeFetchEmptyPopular()
    
    func homeFetchedSuccessTopRated(results: MoviesModel)
    func homeFetchEmptyTopRated()
    func homeFetchFailed()
}

