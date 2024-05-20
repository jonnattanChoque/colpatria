//
//  HomeInteractorTest.swift
//  colpatriaTests
//
//  Created by jonnattan Choque on 19/05/24.
//

import XCTest
import Alamofire
@testable import colpatria

class HomeInteractorTest: XCTestCase {
    
    var interactor: HomeInteractor!
    var mockPresenter: MockPresenter!
    
    /**
        Configura el entorno necesario antes de cada prueba.

        - Prepara la instancia simulada para el presenter.
        - Configura el interactor con la instancias simulada correspondiente.
    */
    override func setUp() {
        super.setUp()
        mockPresenter = MockPresenter()
        
        interactor = HomeInteractor()
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
        Verifica si el método `getPopular`fallo al consultar la respuesta

        - Given:
            - Definimos  la URL del detalle, así como el JSON de respuesta.
            - Convertimos la cadena JSON en datos para usarla como respuesta simulada.
            - Configuramos la respuesta simulada con un código de estado 200 y los datos JSON.
        - When: Llamamos al método `getPopular()` del interactor.
        - Then: Después de un segundo (para permitir que se complete la solicitud), verificamos si el método `homeFetchedSuccessPopular(results:)` del presenter fue llamado.
    */
    func testHomePopularSuccess() {
        // Given
        let url = URL(string: Constants.endpointPopular)!
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
        interactor.getPopular()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.mockPresenter.didCallFetchedPopularSuccess)
        }
    }
    
    /**
        Verifica si el método `getPopular`fallo al consultar la respuesta

         - Given:
             - Definimos una URL de detalle, así como un JSON de respuesta con un ID vacío.
             - Convertimos la cadena JSON en datos para usarla como respuesta simulada.
             - Configuramos la respuesta simulada con un código de estado 200 y los datos JSON.
         - When: Llamamos al método `getPopular()` del interactor.
         - Then: Después de un segundo (para permitir que se complete la solicitud), verificamos si el método `homeFetchEmptyPopular` del presenter fue llamado.
    */
    func testHomePopularEmpty() {
        // Given
        let url = URL(string: Constants.endpointPopular)!
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
        interactor.getPopular()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.mockPresenter.didCallFetchPopularEmpty)
        }
    }
    
    /**
        Verifica si el método `getPopular`fallo al consultar la respuesta

         - Given:
             - Definimos una URL de detalle, así como una respuesta simulada con un código de estado 500 (error del servidor).
             - Configuramos la respuesta simulada con un código de estado 500 y sin datos.
         - When: Llamamos al método `getPopular()` del interactor.
         - Then: Después de un segundo (para permitir que se complete la solicitud), verificamos si el método `HomeFetchFailed` del presenter fue llamado.
    */
    func testHomePopularFailure() {
        // Given
        let url = URL(string: Constants.endpointPopular)!
        let response = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)!
        MockURLProtocol.mockResponse = (response, Data())
        
        // When
        interactor.getPopular()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.mockPresenter.didCallFetchFailed)
        }
    }
    
    /**
        Verifica si el método `getTopRated`fallo al consultar la respuesta

        - Given:
            - Definimos  la URL del detalle, así como el JSON de respuesta.
            - Convertimos la cadena JSON en datos para usarla como respuesta simulada.
            - Configuramos la respuesta simulada con un código de estado 200 y los datos JSON.
        - When: Llamamos al método `getTopRated()` del interactor.
        - Then: Después de un segundo (para permitir que se complete la solicitud), verificamos si el método `homeFetchedSuccessTopRated(results:)` del presenter fue llamado.
    */
    func testHomeTopSuccess() {
        // Given
        let url = URL(string: Constants.endpointTopRated)!
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
        interactor.getTopRated()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.mockPresenter.didCallFetchedPopularSuccess)
        }
    }
    
    /**
        Verifica si el método `getTopRated`fallo al consultar la respuesta.

         - Given:
             - Definimos una URL de detalle, así como un JSON de respuesta con un ID vacío.
             - Convertimos la cadena JSON en datos para usarla como respuesta simulada.
             - Configuramos la respuesta simulada con un código de estado 200 y los datos JSON.
         - When: Llamamos al método `getTopRated()` del interactor.
         - Then: Después de un segundo (para permitir que se complete la solicitud), verificamos si el método `homeFetchEmptyTopRated` del presenter fue llamado.
    */
    func testHomeTopEmpty() {
        // Given
        let url = URL(string: Constants.endpointTopRated)!
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
        interactor.getTopRated()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.mockPresenter.didCallFetchPopularEmpty)
        }
    }
    
    /**
        Verifica si el método `getTopRated`fallo al consultar la respuesta

         - Given:
             - Definimos una URL de detalle, así como una respuesta simulada con un código de estado 500 (error del servidor).
             - Configuramos la respuesta simulada con un código de estado 500 y sin datos.
         - When: Llamamos al método `getTopRated()` del interactor.
         - Then: Después de un segundo (para permitir que se complete la solicitud), verificamos si el método `homeFetchFailed` del presenter fue llamado.
    */
    func testHomeTopFailure() {
        // Given
        let url = URL(string: Constants.endpointPopular)!
        let response = HTTPURLResponse(url: url, statusCode: 500, httpVersion: nil, headerFields: nil)!
        MockURLProtocol.mockResponse = (response, Data())
        
        // When
        interactor.getTopRated()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(self.mockPresenter.didCallFetchFailed)
        }
    }
}

/// Clase de mock para el presenter de detalle, implementando el protocolo `HomePresenterViewProtocol`.
class MockPresenter: HomePresenterViewProtocol {
    /// Indica si el método `homeFetchedSuccessPopular(results:)` fue llamado.
    var didCallFetchedPopularSuccess = false
    
    /// Indica si el método `homeFetchEmptyPopular()` fue llamado.
    var didCallFetchPopularEmpty = false
    
    /// Indica si el método `homeFetchedSuccessTopRated(results:)` fue llamado.
    var didCallFetchedTopSuccess = false
    
    /// Indica si el método `homeFetchEmptyTopRated()` fue llamado.
    var didCallFetchTopEmpty = false
    
    /// Indica si el método `HomeFetchFailed()` fue llamado.
    var didCallFetchFailed = false
    
    /**
        Simula el método del presenter que se llama cuando se obtienen las películas Popular exitosamente.
        - Parameters:
            - results: El modelo del detalle obtenido.
    */
    func homeFetchedSuccessPopular(results: MoviesModel) {
        didCallFetchedPopularSuccess = true
    }
    
    /// Simula el método del presenter que se llama cuando no se encontraron resultados
    func homeFetchEmptyPopular() {
        didCallFetchPopularEmpty = true
    }
    
    /**
        Simula el método del presenter que se llama cuando se obtienen las películas Top exitosamente.
        - Parameters:
            - results: El modelo del detalle obtenido.
    */
    func homeFetchedSuccessTopRated(results: MoviesModel) {
        didCallFetchedTopSuccess = true
    }
    
    /// Simula el método del presenter que se llama cuando no se encontraron resultados.
    func homeFetchEmptyTopRated() {
        didCallFetchTopEmpty = true
    }
    
    /// Simula el método del presenter que se llama cuando la obtención de películas falló.
    func homeFetchFailed() {
        didCallFetchFailed = true
    }
}
