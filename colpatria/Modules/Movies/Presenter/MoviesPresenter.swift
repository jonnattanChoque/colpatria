//
//  MoviesPresenter.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

class MoviesPresenter: MoviesPresenterProtocol {
    var view: MoviesViewProtocol?
    var interactor: MoviesInteractorProtocol?
    var router: MoviesRouterProtocol?
    var responseMovie: MoviesModel?
    
    func viewDidLoad() {
        guard let movie = view?.queryMovie else {
            view?.showEmptyQuery()
            return
        }
        interactor?.getMovies(movie: movie)
    }
}

extension MoviesPresenter: MoviesPresenterViewProtocol {
    func moviesFetchedSuccess(results: MoviesModel) {
        responseMovie = results
        self.view?.showSuccessResult()
    }
    
    func moviesFetchEmpty() {
        responseMovie = nil
        self.view?.showEmptyResults()
    }
    
    func moviesFetchFailed() {
        self.view?.showErrorResults()
    }
}

