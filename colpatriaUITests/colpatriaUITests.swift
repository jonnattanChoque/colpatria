//
//  colpatriaUITests.swift
//  colpatriaUITests
//
//  Created by jonnattan Choque on 18/05/24.
//

import XCTest

final class colpatriaUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        // Configura tu aplicación para las pruebas de interfaz de usuario
        app = XCUIApplication()
        app.launch() // Inicia la aplicación
    }

    override func tearDownWithError() throws {
        // Limpia después de cada prueba
    }

    func testSearchSuccess() throws {
        // Asegúrate de que el UISearchBar tiene un identificador de accesibilidad configurado como "searchBar"
        let searchBar = app.searchFields.firstMatch
        XCTAssertTrue(searchBar.exists, "Search bar does not exist")

        // Escribe un texto en el UISearchBar
        searchBar.tap()
        searchBar.typeText("Sample Movie")
        
        // Toca el botón de buscar en el teclado
        app.keyboards.buttons["Search"].tap()  // O "Search" si tu teclado está en inglés
        
        // Verifica que la acción de búsqueda ha sido realizada
        // En este caso, necesitarías verificar algún cambio en la UI que ocurre después de la búsqueda
        // Por ejemplo, verificar si se navegó a la siguiente vista
        // Asumiendo que la siguiente vista tiene un identificador de accesibilidad "nextView"
        let nextView = app.otherElements["MoviesViewController"]
        XCTAssertTrue(app.otherElements["MoviesViewController"].exists, "Next view was not presented")
    }
    
    func testSegmentControlAction() {
        let segmentControl = app.segmentedControls["segmentControl"]
        XCTAssertTrue(segmentControl.exists, "Segmentcontrol no existe")
        
        let firstSegment = segmentControl.buttons.element(boundBy: 0)
        let secondSegment = segmentControl.buttons.element(boundBy: 1)
        
        XCTAssertTrue(firstSegment.exists, "Primer segmento no existe")
        XCTAssertTrue(secondSegment.exists, "Segundo segmento no existe")
        
        // Validando el segmento inicial
        XCTAssertTrue(firstSegment.isSelected, "Primer segmento no existe seleccionado por defecto")
        
        // Cambiar al segundo segmento
        secondSegment.tap()
        XCTAssertTrue(secondSegment.isSelected, "Se cambiará al segundo segmento")
        XCTAssertFalse(firstSegment.isSelected, "Primer segmento desaparecerá")
        
        // Cambiar de nuevo al primer segmento
        firstSegment.tap()
        XCTAssertTrue(firstSegment.isSelected, "Se cambiará al primer segmento")
        XCTAssertFalse(secondSegment.isSelected, "Segundo segmento desaparecerá")
    }
    
    func testFilterButtonTapped() {
        // Interactúa con el elemento del boton
        let filterButton = app.buttons.firstMatch
        XCTAssertTrue(filterButton.exists, "Botón de filtro no existe")
        
        filterButton.tap()
        
        // Verifica si sale el modal de filtro.
        XCTAssertTrue(app.otherElements["FilterView"].exists, "No existe esta vista")
    }
}
