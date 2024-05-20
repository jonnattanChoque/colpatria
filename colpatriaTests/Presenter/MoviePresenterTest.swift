//
//  MoviePresenterTest.swift
//  colpatriaTests
//
//  Created by jonnattan Choque on 19/05/24.
//

import XCTest
@testable import colpatria

final class MoviePresenterTest: XCTestCase {

    var presenter: MoviesPresenter!
    var mockView: MockMoviesView!
    var mockRouter: MockMoviesRouter!
    var mockInteractor: MockMoviesInteractor!
    
    /**
        Configura el entorno necesario antes de cada prueba.

        - Prepara instancias simuladas para la vista, el interactor y el enrutador.
        - Configura el presentador con las instancias simuladas correspondientes.
    */
    override func setUp() {
        super.setUp()
        
        mockView = MockMoviesView()
        mockInteractor = MockMoviesInteractor()
        mockRouter = MockMoviesRouter()
        
        presenter = MoviesPresenter()
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
        Verifica si el método `viewDidLoad` del presentador realiza la solicitud de detalles al interactor.

        - Dado: Un identificador de detalle.
        - Cuando: Se llama al método `viewDidLoad` del presentador.
        - Entonces: Se verifica que se haya llamado al método `getMovies` del interactor.
    */
    func testViewDidLoad() {
        // Given
        let query = "Thor"
        presenter.view?.queryMovie = query
        
        // When
        presenter.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockInteractor.responseMoviesCalled)
    }
    
    /**
        Verifica si el método `viewDidLoad` del presentador retorna por falta de query.

        - Dado: Un identificador de detalle.
        - Cuando: Se llama al método `viewDidLoad` del presentador.
        - Entonces: Se verifica que se haya llamado al método `getMovies` del interactor.
    */
    func testViewDidLoadEmpty() {
        // When
        presenter.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockView.emptyQueryCalled)
    }

    /**
        Verifica si el método `moviesFetchedSuccess` del presentador maneja correctamente la respuesta exitosa de películas.

        - Given: Un modelo de detalle y un modelo de vendedor.
        - When: Se llama al método `moviesFetchedSuccess` del presentador con los modelos de movies.
        - Then: Se verifica que se haya llamado al método `showSuccessResult` de la vista.
    */
    func testMoviesFetchedSuccess() {
        // Given
        let response = MockData.shared.getListMovies()
        
        // When
        presenter.moviesFetchedSuccess(results: response)
        
        // Then
        XCTAssertTrue(mockView.resultSuccessCalled)
    }

    /**
        Verifica si el método `moviesFetchFailed` del presentador maneja correctamente la falla en la obtención de películas.

        - When: Se llama al método `moviesFetchFailed` del presentador.
        - Then: Se verifica que se haya llamado al método `showErrorResults` de la vista.
    */
    func testMoviesFetchFailed() {
        // When
        presenter.moviesFetchFailed()
        
        // Then
        XCTAssertTrue(mockView.showErrorResultsCalled)
    }

    /**
        Verifica si el método `moviesFetchEmpty` del presentador maneja correctamente la respuesta vacía al obtener detalles.

        - When: Se llama al método `moviesFetchEmpty` del presentador.
        - Then: Se verifica que se haya llamado al método `showEmptyResults` de la vista.
    */
    func testMoviesFetchEmpty() {
        // When
        presenter.moviesFetchEmpty()
        
        // Then
        XCTAssertTrue(mockView.showEmptyResultsCalled)
    }
}

/// Clase de mock para la vista de búsqueda, implementando el protocolo `MoviesViewProtocol`.
class MockMoviesView: MoviesViewProtocol {
    var queryMovie: String?
    
    /// Indica si el método `showEmptyResults()` fue llamado.
    var showEmptyResultsCalled = false
    
    /// Indica si el método `showErrorResults()` fue llamado.
    var showErrorResultsCalled = false
    
    /// Indica si el método `resultSuccess()` fue llamado.
    var resultSuccessCalled = false
    
    /// Indica si el método `resultSuccess()` fue llamado.
    var emptyQueryCalled = false
    
    /**
        Muestra un mensaje de resultados vacíos.
        
        Este método se llama cuando no hay resultados que mostrar en la vista de detalle.
    */
    func showEmptyResults() {
        showEmptyResultsCalled = true
    }
    
    /**
        Muestra un mensaje de error.
        
        Este método se llama cuando ocurre un error al cargar los datos en la vista de detalle.
    */
    func showErrorResults() {
        showErrorResultsCalled = true
    }
    
    /**
        Realiza acciones después de que se obtienen los resultados exitosamente.
        
        Este método se llama cuando los resultados se cargan exitosamente en la vista de detalle.
    */
    func showSuccessResult() {
        resultSuccessCalled = true
    }
    
    /**
        Realiza acciones al al no encontrar el query de búsqueda.
        
        Este método se llama se carga el View Controller.
    */
    func showEmptyQuery() {
        emptyQueryCalled = true
    }
}

/// Clase de mock para el enrutador de detalle, implementando el protocolo `MoviesRouterProtocol`.
class MockMoviesRouter: MoviesRouterProtocol {
    /// Indica si el método `createModule(movie:)` fue llamado.
    var createModuleCalled = false
    
    /**
        Método estático para crear un módulo de búsqueda.
        - Parameter
            - id: El identificador del detalle.
        - Returns: Una instancia de `MoviesViewController`
    */
    static func createModule(movie: String) -> MoviesViewController {
        MockMoviesRouter().createModuleCalled = true
        return MoviesViewController()
    }
}


/// Clase de mock para el interactor de detalle, implementando el protocolo `MoviesInteractorProtocol`.
class MockMoviesInteractor: MoviesInteractorProtocol {
    /// El presentador asociado al interactor simulado.
    var presenter: (any MoviesPresenterViewProtocol)?
    
    /// Indica si el método `MoviesInfo(id:)` fue llamado.
    var responseMoviesCalled = false
    
    /**
        Recupera la información del detalle.
        
        - Parameter
            - movie: El identificador del búsqueda.
    */
    func getMovies(movie: String) {
        responseMoviesCalled = true
    }
}

