//
//  HomePresenter.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import UIKit

class HomePresenter: HomePresenterProtocol {
    var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var router: HomeRouterProtocol?
    var responsePopular: MoviesModel?
    var responseTopRated: MoviesModel?
    
    func viewDidLoad() {
        interactor?.getTopRated()
    }
    
    func applyFilters(segmentSelected: Int, isAdultFilter: Bool, selectedLanguage: String, minVoteAverage: Double, maxVoteAverage: Double) {
        var data = [Movie]()
        if(segmentSelected == .zero) {
            data = self.responsePopular?.results ?? []
        } else {
            data = self.responseTopRated?.results ?? []
        }
        
        let newData = data.filter { movie in
            let matchesAdult = movie.adult == isAdultFilter
            let matchesLanguage = movie.originalLanguage == selectedLanguage
            let matchesVoteAverage = movie.voteAverage >= minVoteAverage && movie.voteAverage <= maxVoteAverage
            return matchesAdult && matchesLanguage && matchesVoteAverage
        }
        
        if(segmentSelected == .zero) {
            view?.updatePopular(data: newData)
        } else {
            view?.updateTopRated(data: newData)
        }
    }
    
    func showNextView(navigationController: UINavigationController, movie: String) {
        self.router?.pushToMovieScreen(navigationController: navigationController, movie: movie)
    }
}

extension HomePresenter: HomePresenterViewProtocol {
    func homeFetchedSuccessTopRated(results: MoviesModel) {
        responseTopRated = results
        self.interactor?.getPopular()
    }
    
    func homeFetchEmptyTopRated() {
        responseTopRated = nil
        self.interactor?.getPopular()
    }
    
    func homeFetchedSuccessPopular(results: MoviesModel) {
        responsePopular = results
        self.view?.showSuccessResult()
    }
    
    func homeFetchEmptyPopular() {
        responsePopular = nil
        self.view?.showSuccessResult()
    }
    
    func homeFetchFailed() {
        self.view?.showErrorResults()
    }
}

