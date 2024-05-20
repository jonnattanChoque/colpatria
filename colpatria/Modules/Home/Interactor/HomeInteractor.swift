//
//  HomeInteractor.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

class HomeInteractor: HomeInteractorProtocol {
    var presenter: HomePresenterViewProtocol?
    private let status: Int = 200
    
    private let headers = [
        "accept": "application/json",
        "Authorization": "Bearer ".appending(Constants.apiKey)
    ]
    
    func getTopRated() {
        let url = Constants.endpointTopRated
        Alamofire.request(url, headers: headers).responseObject { (response: DataResponse<MoviesModel>) in
            if(response.response?.statusCode == self.status) {
                let results = response.result.value
                if(results?.results.count == .zero) {
                    self.presenter?.homeFetchEmptyTopRated()
                } else {
                    guard let results = results else {
                        self.presenter?.homeFetchEmptyTopRated()
                        return
                    }
                    self.presenter?.homeFetchedSuccessTopRated(results: results)
                }
            } else {
                self.presenter?.homeFetchFailed()
            }
        }
    }
    
    func getPopular() {
        let url = Constants.endpointPopular
        Alamofire.request(url, headers: headers).responseObject { (response: DataResponse<MoviesModel>) in
            if(response.response?.statusCode == self.status) {
                let results = response.result.value
                if(results?.results.count == .zero) {
                    self.presenter?.homeFetchEmptyPopular()
                } else {
                    guard let results = results else {
                        self.presenter?.homeFetchEmptyPopular()
                        return
                    }
                    self.presenter?.homeFetchedSuccessPopular(results: results)
                }
            } else {
                self.presenter?.homeFetchFailed()
            }
        }
    }
}
