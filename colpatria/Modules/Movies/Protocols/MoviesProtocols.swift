//
//  MoviesProtocols.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

protocol MoviesPresenterProtocol: AnyObject {
    var view: MoviesViewProtocol? {get set}
    var interactor: MoviesInteractorProtocol? {get set}
    var router: MoviesRouterProtocol? {get set}
    var responseMovie: MoviesModel? {get set}
    func viewDidLoad()
}

protocol MoviesViewProtocol: AnyObject {
    var queryMovie: String? {get set}
    func showErrorResults()
    func showEmptyResults()
    func showSuccessResult()
    func showEmptyQuery()
}

protocol MoviesRouterProtocol: AnyObject {
    static func createModule(movie: String)-> MoviesViewController
}

protocol MoviesInteractorProtocol: AnyObject {
    var presenter: MoviesPresenterViewProtocol? {get set}
    func getMovies(movie: String)
}

protocol MoviesPresenterViewProtocol: AnyObject {
    func moviesFetchedSuccess(results: MoviesModel)
    func moviesFetchEmpty()
    func moviesFetchFailed()
}
