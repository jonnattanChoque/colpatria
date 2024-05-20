//
//  MoviesInteractor.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

class MoviesInteractor: MoviesInteractorProtocol {
    var presenter: MoviesPresenterViewProtocol?
    private let status: Int = 200
    
    private let headers = [
        "accept": "application/json",
        "Authorization": "Bearer ".appending(Constants.apiKey)
    ]
    
    func getMovies(movie: String) {
        let queryItems: Parameters = [
            "query": movie,
            "page": "1"
        ]
        let url = Constants.endpointSearch
        
        Alamofire.request(url, parameters: queryItems, headers: headers).responseObject { (response: DataResponse<MoviesModel>) in
            if(response.response?.statusCode == self.status) {
                let results = response.result.value
                if(results?.results.count == .zero) {
                    self.presenter?.moviesFetchEmpty()
                } else {
                    guard let results = results else {
                        self.presenter?.moviesFetchEmpty()
                        return
                    }
                    self.presenter?.moviesFetchedSuccess(results: results)
                }
            } else {
                self.presenter?.moviesFetchFailed()
            }
        }
    }
}
