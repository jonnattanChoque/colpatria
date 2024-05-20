//
//  HomeRouter.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import Foundation
import UIKit

class HomeRouter: HomeRouterProtocol {
    static func createModule() -> HomeViewController {
        let view = HomeViewController()
        let presenter: HomePresenterProtocol & HomePresenterViewProtocol = HomePresenter()
        let interactor: HomeInteractorProtocol = HomeInteractor()
        let router: HomeRouterProtocol = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToMovieScreen(navigationController: UINavigationController, movie: String) {
        let module = MoviesRouter.createModule(movie: movie)
        navigationController.pushViewController(module, animated: true)
    }
}
