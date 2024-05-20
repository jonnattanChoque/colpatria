//
//  MoviesInteractorTest.swift
//  colpatriaTests
//
//  Created by jonnattan Choque on 19/05/24.
//

import XCTest
import Alamofire
@testable import colpatria

class MoviesInteractorTest: XCTestCase {
    
    var interactor: MoviesInteractor!
    var mockPresenter: MockMoviesPresenter!
    
    /**
        Configura el entorno necesario antes de cada prueba.

        - Prepara la instancia simulada para el presenter.
        - Configura el interactor con la instancias simulada correspondiente.
    */
    override func setUp() {
        super.setUp()
        mockPresenter = MockMoviesPresenter()
        
        interactor = MoviesInteractor()
        interactor.presenter = mockPresenter
    }
    
    /**
        Realiza la limpieza después de cada prueba.

        - Libera las instancias simuladas del interactor y el presentador.
    */
    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    /**
        Verifica si el método `getMovies` es un caso exitoso de obtención del detalle

        - Given:
            - Definimos un query  la URL del detalle, así como el JSON de respuesta.
            - Convertimos la cadena JSON en datos para usarla como respuesta simulada.
            - Configuramos la respuesta simulada con un código de estado 200 y los datos JSON.
        - When: Llamamos al método `getMovies(movie:)` del interactor con el query dado.
        - Then: Después de un segundo (para permitir que se complete la solicitud), verificamos si el método `moviesFetchedSuccess(results:)` del presenter fue llamado.
    */
    func testMoviesInfoSuccess() {
        // Given
        let query = "Thor"
        let url = URL(string: Constants.endpointSearch)!
        let jsonString = """
            {
                "id": "123",
                // Otras propiedades del modelo de detalle aquí...
            }
        """
        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("No se pudo convertir la cadena JSON en datos")
            return
        }
        
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        MockURLProtocol.mockResponse = (response, jsonData)
        
        // When
        interactor.getMovies(movie: query)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.mockPresenter.didCallMoviesFetchedSuccess)
        }
    }
    
    /**
        Verifica si el método `getMovies`no se encontro el detalle.

         - Given:
             - Definimos un query son resultados y una URL de detalle, así como un JSON de respuesta.
             - Convertimos la cadena JSON en datos para usarla como respuesta simulada.
             - Configuramos la respuesta simulada con un código de estado 200 y los datos JSON.
         - When: Llamamos al método `getMovies(movie:)` del interactor con el query dado.
         - Then: Después de un segundo (para permitir que se complete la solicitud), verificamos si el método `moviesFetchEmpty` del presenter fue llamado.
    */
    func testMoviesInfoEmpty() {
        // Given
        let query = "sample movie"
        let url = URL(string: Constants.endpointSearch)!
        let jsonString = """
            {
                "id": ""
            }
        """
        guard let jsonData = jsonString.data(using: .utf8) else {
            XCTFail("No se pudo convertir la cadena JSON en datos")
            return
        }
        let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
        MockURLProtocol.mockResponse = (response, jsonData)
        
        // When
        interactor.getMovies(movie: query)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.mockPresenter.didCallMoviesFetchEmpty)
        }
    }
    
    /**
        Verifica si el método `getMovies`fallo al consultar el detalle

         - Given:
             - Definimos un query  y una URL de detalle, así como una respuesta simulada con un código de estado 500 (error del servidor).
             - Configuramos la respuesta simulada con un código de estado 500 y sin datos.
         - When: Llamamos al método `getMovies(movie:)` del interactor con el query dado.
         - Then: Después de un segundo (para permitir que se complete la solicitud), verificamos si el método `moviesFetchFailed` del presenter fue llamado.
    */
    func testMoviesInfoFailure() {
        // Given
        // Preparación:
        let query = "Thor"
        let url = URL(string: Constants.endpointSearch)!
        let response = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)!
        MockURLProtocol.mockResponse = (response, Data())
        
        // When
        interactor.getMovies(movie: query)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.mockPresenter.didCallMoviesFetchFailed)
        }
    }

}

/// Clase de mock para el presenter de detalle, implementando el protocolo `MoviesPresenterViewProtocol`.
class MockMoviesPresenter: MoviesPresenterViewProtocol {
    /// Indica si el método `MoviesFetchedSuccess(results:seller:)` fue llamado.
    var didCallMoviesFetchedSuccess = false
    
    /// Indica si el método `MoviesFetchEmpty()` fue llamado.
    var didCallMoviesFetchEmpty = false
    
    /// Indica si el método `MoviesFetchFailed()` fue llamado.
    var didCallMoviesFetchFailed = false
    
    /**
        Simula el método del presenter que se llama cuando se obtienen detalles exitosamente.
        - Parameters:
            - results: El modelo del response obtenido.
    */
    func moviesFetchedSuccess(results: MoviesModel) {
        didCallMoviesFetchedSuccess = true
    }
    
    /// Simula el método del presenter que se llama cuando no se encontraron detalles.
    func moviesFetchEmpty() {
        didCallMoviesFetchEmpty = true
    }
    
    /// Simula el método del presenter que se llama cuando la obtención de detalles falló.
    func moviesFetchFailed() {
        didCallMoviesFetchFailed = true
    }
}

