//
//  MockData.swift
//  colpatriaTests
//
//  Created by jonnattan Choque on 19/05/24.
//

import Foundation
import colpatria

class MockData {
    static var shared: MockData = {
        let instance = MockData()
        return instance
    }()
    
    private init() {}
    
    func getListMovies() -> MoviesModel {
        let jsonString = MockData.shared.getJsonList()
        let response = MoviesModel(JSONString: jsonString)
        return response!
    }
    
    func getMovie() -> Movie {
        let jsonString = MockData.shared.getJsonMovie()
        let response = Movie(JSONString: jsonString)
        return response!
    }
    
    private func getJsonMovie() -> String {
        return """
        {
          "adult": false,
          "backdrop_path": "/j3Z3XktmWB1VhsS8iXNcrR86PXi.jpg",
          "genre_ids": [
            878,
            28,
            12
          ],
          "id": 823464,
          "original_language": "en",
          "original_title": "Godzilla x Kong: The New Empire",
          "overview": "Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.",
          "popularity": 9778.73,
          "poster_path": "/tMefBSflR6PGQLv7WvFPpKLZkyk.jpg",
          "release_date": "2024-03-27",
          "title": "Godzilla x Kong: The New Empire",
          "video": false,
          "vote_average": 7.2,
          "vote_count": 1760
        }
        """
    }
    
    private func getJsonList() -> String {
        return """
        {
          "page": 1,
          "results": [
            {
              "adult": false,
              "backdrop_path": "/j3Z3XktmWB1VhsS8iXNcrR86PXi.jpg",
              "genre_ids": [
                878,
                28,
                12
              ],
              "id": 823464,
              "original_language": "en",
              "original_title": "Godzilla x Kong: The New Empire",
              "overview": "Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.",
              "popularity": 9778.73,
              "poster_path": "/tMefBSflR6PGQLv7WvFPpKLZkyk.jpg",
              "release_date": "2024-03-27",
              "title": "Godzilla x Kong: The New Empire",
              "video": false,
              "vote_average": 7.2,
              "vote_count": 1760
            },
            {
              "adult": false,
              "backdrop_path": "/fqv8v6AycXKsivp1T5yKtLbGXce.jpg",
              "genre_ids": [
                878,
                12,
                28
              ],
              "id": 653346,
              "original_language": "en",
              "original_title": "Kingdom of the Planet of the Apes",
              "overview": "Several generations in the future following Caesar's reign, apes are now the dominant species and live harmoniously while humans have been reduced to living in the shadows. As a new tyrannical ape leader builds his empire, one young ape undertakes a harrowing journey that will cause him to question all that he has known about the past and to make choices that will define a future for apes and humans alike.",
              "popularity": 2138.363,
              "poster_path": "/gKkl37BQuKTanygYQG1pyYgLVgf.jpg",
              "release_date": "2024-05-08",
              "title": "Kingdom of the Planet of the Apes",
              "video": false,
              "vote_average": 7.2,
              "vote_count": 432
            }
          ],
          "total_pages": 44232,
          "total_results": 884635
        }
        """
    }
}
