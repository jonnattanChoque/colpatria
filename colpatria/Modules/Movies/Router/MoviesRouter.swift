//
//  MoviesRouter.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

class MoviesRouter: MoviesRouterProtocol {
    static func createModule(movie: String) -> MoviesViewController {
        let view = MoviesViewController()
        let presenter: MoviesPresenterProtocol & MoviesPresenterViewProtocol = MoviesPresenter()
        let interactor: MoviesInteractorProtocol = MoviesInteractor()
        let router: MoviesRouterProtocol = MoviesRouter()
        
        view.presenter = presenter
        view.queryMovie = movie
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
//    func pushToListScreen(navigationController: UINavigationController, result: MoviesModel) {
//        let listModule = ListRouter.createModule(result: result)
//        navigationController.pushViewController(listModule, animated: true)
//    }
}

