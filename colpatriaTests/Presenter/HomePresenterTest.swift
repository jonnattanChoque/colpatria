//
//  HomePresenterTest.swift
//  colpatriaTests
//
//  Created by jonnattan Choque on 19/05/24.
//

import XCTest
@testable import colpatria

final class HomePresenterTest: XCTestCase {

    var presenter: HomePresenter!
    var mockView: MockHomeView!
    var mockRouter: MockHomeRouter!
    var mockInteractor: MockHomeInteractor!
    
    /**
        Configura el entorno necesario antes de cada prueba.

        - Prepara instancias simuladas para la vista, el interactor y el enrutador.
        - Configura el presentador con las instancias simuladas correspondientes.
    */
    override func setUp() {
        super.setUp()
        
        mockView = MockHomeView()
        mockInteractor = MockHomeInteractor()
        mockRouter = MockHomeRouter()
        
        presenter = HomePresenter()
        presenter.interactor = mockInteractor
        presenter.router = mockRouter
        presenter.view = mockView
    }

    /**
        Realiza la limpieza después de cada prueba.

        - Libera las instancias simuladas de la vista, el interactor, el enrutador y el presentador.
    */
    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        presenter = nil
        super.tearDown()
    }
    
    /**
        Verifica que al llamar al método `viewDidLoad` del presentador llame correctamente la búsqueda a través del interactor.
        - When: Se llama al método `Home` del presentador.
        - Then: Se verifica que se haya llamado al método `getTopRated` del interactor, indicando que se ha iniciado una búsqueda.
    */
    func testViewDidLoad() {
        
        // When
        presenter.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockInteractor.getTopRatedCalled)
    }

    /**
        Verifica que al llamar al método `showNextView` del presentador

        - Given: Se crea un controlador de navegación y un string de búsqueda.
        - When: Se llama al método `showNextView` del presentador con el controlador de navegación y el string de búsqueda.
        - Then: Se verifica que se haya llamado al método `createPush` del enrutador, indicando que se ha creado correctamente una nueva vista.
    */
    func testShowNextView() {
        // Given
        let movie = "Thor"
        let navigationController = UINavigationController()
        
        // When
        presenter.showNextView(navigationController: navigationController, movie: movie)
        
        // Then
        XCTAssertTrue(mockRouter.createPushCalled)
    }
    
    
    func testApplyFilters() {
        // Given
        let segmentSelected = 0
        let segmentSelectedOne = 1
        let isAdultFilter = false
        let selectedLanguage = "en"
        let minVoteAverage: Double = 0
        let maxVoteAverage: Double = 10
        
        // When
        presenter.applyFilters(segmentSelected: segmentSelected, isAdultFilter: isAdultFilter, selectedLanguage: selectedLanguage, minVoteAverage: minVoteAverage, maxVoteAverage: maxVoteAverage)
        
        // Then
        XCTAssertTrue(mockView.updatePopularCalled)
        
        
        // When
        presenter.applyFilters(segmentSelected: segmentSelectedOne, isAdultFilter: isAdultFilter, selectedLanguage: selectedLanguage, minVoteAverage: minVoteAverage, maxVoteAverage: maxVoteAverage)
        
        // Then
        XCTAssertTrue(mockView.updateTopRatedCalled)
    }


    /**
        Verifica que al llamar al método `homeFetchedSuccessTopRated` del presentador

        - Given: Se obtiene un modelo de búsqueda válido.
        - When: Se llama al método `homeFetchedSuccessTopRated` del presentador con el modelo de búsqueda.
        - Then: Then: Se verifica si el método `getPopular` del interactor fue llamado.
    */
    func testHomeFetchedSuccessTopRated() {
        // Given
        let response = MockData.shared.getListMovies()
        
        // When
        presenter.homeFetchedSuccessTopRated(results: response)
        
        // Then
        XCTAssertTrue(mockInteractor.getPopularCalled)
    }
    
    /**
        Verifica el método `homeFetchEmptyTopRated()`  del presentador cuando la búsqueda no devuelve resultados.

        - When: Llamamos al método `homeFetchEmptyTopRated()` del presentador para simular la situación en la que la búsqueda no devuelve resultados.
        - Then: Se verifica si el método `getPopular` del interactorfue llamado.
    */
    func testHomeFetchEmpty() {
        // Given
        presenter.responseTopRated = nil
        
        // When
        presenter.homeFetchEmptyTopRated()
        
        // Then
        XCTAssertTrue(mockInteractor.getPopularCalled)
    }
    
    /**
        Verifica que al llamar al método `homeFetchedSuccessPopular` del presentador

        - Given: Se obtiene un modelo de búsqueda válido.
        - When: Se llama al método `homeFetchedSuccessPopular` del presentador con el modelo de búsqueda.
        - Then: Then: Se verifica si el método `showSuccessResult` de la vista fue llamado.
    */
    func testHomeFetchedSuccessPopular() {
        // Given
        let response = MockData.shared.getListMovies()
        
        // When
        presenter.homeFetchedSuccessPopular(results: response)
        
        // Then
        XCTAssertTrue(mockView.resultSuccessCalled)
    }
    
    /**
        Verifica el método `homeFetchEmptyPopular()`  del presentador cuando la búsqueda no devuelve resultados.

        - When: Llamamos al método `homeFetchEmptyPopular()` del presentador para simular la situación en la que la búsqueda no devuelve resultados.
        - Then: Se verifica si el método `showSuccessResult` de la vista fue llamado.
    */
    func testHomeFetchEmptyPopular() {
        // Given
        presenter.responsePopular = nil
        
        // When
        presenter.homeFetchEmptyPopular()
        
        // Then
        XCTAssertTrue(mockView.resultSuccessCalled)
    }

    /**
        Verifica el método `homeFetchFailed()` del presentador cuando falla la búsqueda.

        - When:  Llamamos al método `homeFetchFailed()` del presentador para simular el fallo de la búsqueda.
        - Then: Se verifica si el método `showErrorResults` de la vista fue llamado, lo que indica que se mostró un mensaje de error al fallar la búsqueda.
    */
    func testHomeFetchFailed() {
        // When
        presenter.homeFetchFailed()
        
        // Then
        XCTAssertTrue(mockView.showErrorResultsCalled)
    }
}

/// Clase de mock para la vista de búsqueda, implementando el protocolo `HomeViewProtocol`.
class MockHomeView: HomeViewProtocol {
    /// Indica si el método `updatePopular()` fue llamado.
    var updatePopularCalled = false
    /// Indica si el método `updateTopRated()` fue llamado.
    var updateTopRatedCalled = false
    /// Indica si el método `showSuccessResult()` fue llamado.
    var resultSuccessCalled = false
    /// Indica si el método `showErrorResults()` fue llamado.
    var showErrorResultsCalled = false
    
    
    /**
        Realiza acciones después de que se obtienen los resultados exitosamente.
        
        Este método se llama cuando los resultados se cargan exitosamente en la vista de detalle.
    */
    func showSuccessResult() {
        resultSuccessCalled = true
    }
    
    func updatePopular(data: [Movie]) {
        updatePopularCalled = true
    }
    
    func updateTopRated(data: [Movie]) {
        updateTopRatedCalled = true
    }
    
    func showErrorResults() {
        showErrorResultsCalled = true
    }
}


/// Clase de mock para el enrutador de búsqueda, implementando el protocolo `HomeRouterProtocol`.
class MockHomeRouter: HomeRouterProtocol {
    
    /// Indica si el método `createModule()` fue llamado.
    var createModuleCalled = false
    /// Indica si el método `pushToMovieScreen(navigationController:result:)` fue llamado.
    var createPushCalled = false
    
    
    /**
        Método estático para crear un módulo de búsqueda.
        - Returns: Una instancia de `HomeViewController`
    */
    static func createModule() -> HomeViewController {
        MockHomeRouter().createModuleCalled = true
        return HomeViewController()
    }
    
    /**
     Método para navegar a la pantalla de lista.
     - Parameters:
        - navigationController: El controlador de navegación.
        - movie: El query de la búsqueda.
    */
    func pushToMovieScreen(navigationController: UINavigationController, movie: String) {
        createPushCalled = true
    }
}


/// Clase de mock para el interactor de búsqueda, implementando el protocolo `HomeInteractorProtocol`.
class MockHomeInteractor: HomeInteractorProtocol {
    /// La referencia al presentador de búsqueda.
    var presenter: (any HomePresenterViewProtocol)?
    
    /// Indica si el método `getTopRated` fue llamado.
    var getTopRatedCalled = false
    
    /// Indica si el método `getPopular` fue llamado.
    var getPopularCalled = false
    
    /**
        Método del interactor que simula una búsqueda de información.
        
        - Parameter
            - text: El texto de búsqueda.
    */
    func getTopRated() {
        getTopRatedCalled = true
    }
    
    func getPopular() {
        getPopularCalled = true
    }
}

