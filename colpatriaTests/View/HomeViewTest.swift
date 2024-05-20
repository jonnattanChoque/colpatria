//
//  HomeViewTest.swift
//  colpatriaTests
//
//  Created by jonnattan Choque on 19/05/24.
//

import XCTest
@testable import colpatria

final class HomeViewTest: XCTestCase {

    var homeViewController: HomeViewController!
    var mockPresenter: MockHomePresenter!
    var mockFilterView: MockFilterView!
    var mockPopularView: MockContentView!
    var mockTopRatedView: MockContentView!
    
    /**
        Configura el entorno necesario antes de cada prueba.

        - Prepara instancia simulada para el presenter
        - Configura la vista con la instancia simulada correspondiente
        - Se fuerza la carga de la vista para activar el ciclo de vida de la vista y configurar las interacciones..
    */
    override func setUp() {
        super.setUp()
        mockPresenter = MockHomePresenter()
        mockFilterView = MockFilterView()
        mockPopularView = MockContentView()
        mockTopRatedView = MockContentView()
        
        homeViewController = HomeViewController()
        homeViewController.presenter = mockPresenter
        homeViewController.filterView = mockFilterView
        homeViewController.popularView = mockPopularView
        homeViewController.topRatedView = mockTopRatedView
        
        _ = homeViewController.view
    }
    
    /**
        Realiza la limpieza después de cada prueba.

        - Libera las instancias simuladas de la vista y el presentador.
    */
    override func tearDown() {
        homeViewController = nil
        mockPresenter = nil
        mockFilterView = nil
        mockPopularView = nil
        mockTopRatedView = nil
        super.tearDown()
    }
    
    func testDidUpdateAdultFilter() {
        homeViewController.didUpdateAdultFilter(isAdult: true)
        XCTAssertTrue(homeViewController.isAdultFilter)
    }
    
    func testDidUpdateLanguageFilter() {
        let language = "en"
        homeViewController.didUpdateLanguageFilter(selectedLanguage: language)
        XCTAssertEqual(homeViewController.selectedLanguage, language)
    }
    
    func testDidUpdateVoteAverageFilter() {
        let minVote: Float = 3.0
        let maxVote: Float = 7.5
        homeViewController.didUpdateVoteAverageFilter(minVoteAverage: minVote, maxVoteAverage: maxVote)
        XCTAssertEqual(homeViewController.minVoteAverage, Double(minVote))
        XCTAssertEqual(homeViewController.maxVoteAverage, Double(maxVote))
    }
    
    func testDidCancelFilter() {
        homeViewController.didCancelFilter()
        XCTAssertFalse(mockFilterView.isAddedToSuperview)
    }
    
    func testDidApplyFilter() {
        homeViewController.didApplyFilter()
        XCTAssertFalse(mockFilterView.isAddedToSuperview)
        XCTAssertTrue(mockPresenter.didCallApplyFilter)
    }
    
    func testDidRemoveFilter() {
        let jsonResponse = MockData.shared.getListMovies()
        homeViewController.presenter?.responsePopular = jsonResponse
        homeViewController.presenter?.responseTopRated = jsonResponse
        
        homeViewController.segmentSelected = 0
        homeViewController.didRemoveFilter()
        XCTAssertFalse(mockFilterView.isAddedToSuperview)
        XCTAssertTrue(mockPopularView.isContentUpdated)
        
        homeViewController.segmentSelected = 1
        homeViewController.didRemoveFilter()
        XCTAssertTrue(mockTopRatedView.isContentUpdated)
    }
    
    func testUpdatePopular() {
        // Prepare
        let testData: [Movie] = [MockData.shared.getMovie()]
        
        // Act
        homeViewController.updatePopular(data: testData)
        
        // Assert
        XCTAssertTrue(mockPopularView.isContentUpdated)
    }
    
    func testUpdateTopRated() {
        // Prepare
        let testData: [Movie] = [MockData.shared.getMovie()]
        
        // Act
        homeViewController.updateTopRated(data: testData)
        
        // Assert
        XCTAssertTrue(mockTopRatedView.isContentUpdated)
    }
}

/// Clase de mock para el presentador del módulo de búsqueda. Implementa el protocolo  `SearchPresenterProtocol`..
class MockHomePresenter: HomePresenterProtocol {
    /// Referencia simulada del objeto para el Popular
    var responsePopular: MoviesModel?
    
    /// Referencia simulada del objeto para el topRated
    var responseTopRated: MoviesModel?
    
    /// Referencia simulada a la vista del módulo de home.
    var view: (any HomeViewProtocol)?
    
    /// Referencia simulada al interactor del módulo de home.
    var interactor: (any HomeInteractorProtocol)?
    
    /// Referencia simulada al enrutador del módulo de home.
    var router: (any HomeRouterProtocol)?
    
    /// Indicador booleano que registra si se llamó al método de home.
    var didCallViewDidLoad = false
    
    /// Indicador booleano que registra si se llamó al método para mostrar la siguiente vista.
    var didCallShowNext = false
    
    /// Indicador booleano que registra si se llamó al método para mostrar la siguiente vista.
    var didCallApplyFilter = false
    
    /**
        Método simulado para realizar la búsqueda de películas.
    */
    func viewDidLoad() {
        didCallViewDidLoad = true
    }
    
    /**
        Método simulado para mostrar la siguiente vista.
     
        - Parameter 
            - navigationController: El controlador de navegación.
            - movie: la película que se va a buscar
    */
    func showNextView(navigationController: UINavigationController, movie: String) {
        didCallShowNext = true
    }
    
    /**
        Método simulado para realizar filtros.
     
        - Parameter
            - segmentSelected: Popular o topRated.
            - isAdultFilter: Booleano
            - selectedLanguage: Idiomar  del filtro.
            - minVoteAverage: Mínima votación  del filtro
            - maxVoteAverage: Máxima votación  del filtro
    */
    func applyFilters(segmentSelected: Int, isAdultFilter: Bool, selectedLanguage: String, minVoteAverage: Double, maxVoteAverage: Double) {
        didCallApplyFilter = true
    }
}

class MockFilterView: FilterView {
    var isAddedToSuperview = true
    
    override func removeFromSuperview() {
        isAddedToSuperview = false
    }
    
    // Otros métodos necesarios...
}

class MockContentView: MoviesView {
    var isContentUpdated = false
    
    override func updateContent(newData: [Movie]) {
        isContentUpdated = true
    }
}

class MockAlertController: UIAlertController {
    // Mock implementation if needed
}
