//
//  MovieModel.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

public class MoviesModel: Mappable {
    var page: Int = 0
    var results: [Movie] = []
    var totalPages: Int = 0
    var totalResults: Int = 0
    
    required public init?(map: Map) {
        
    }

    public func mapping(map: Map) {
        self.page           <- map["page"]
        self.results        <- map["results"]
        self.totalPages     <- map["total_pages"]
        self.totalResults   <- map["total_results"]
    }
}

// MARK: - Result
public class Movie: Mappable {
    var adult: Bool = false
    var backdropPath: String = ""
    var genreIDS: [Int] = []
    var id: Int = 0
    var originalLanguage = ""
    var originalTitle = ""
    var overview: String = ""
    var popularity: Double = 0
    var posterPath = ""
    var releaseDate = ""
    var title: String = ""
    var video: Bool = false
    var voteAverage: Double = 0
    var voteCount: Int = 0
    
    required public init?(map: Map) {
        
    }

    public func mapping(map: Map) {
        self.adult              <- map["adult"]
        self.backdropPath       <- map["backdrop_path"]
        self.genreIDS           <- map["genre_ids"]
        self.originalLanguage   <- map["original_language"]
        self.originalTitle      <- map["original_title"]
        self.overview           <- map["overview"]
        self.popularity         <- map["popularity"]
        self.posterPath         <- map["poster_path"]
        self.releaseDate        <- map["release_date"]
        self.title              <- map["title"]
        self.video              <- map["video"]
        self.voteAverage        <- map["vote_average"]
        self.voteCount          <- map["vote_count"]
    }
}

