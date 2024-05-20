//
//  Constants.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import Foundation

struct Constants {
    static var apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyMGJjNDkxNDkzYmY3MmExOThkMTM0ZDc0ZTNiMzIwMiIsInN1YiI6IjVlYmMyZTMwNjE0YzZkMDAxZThmNjQwYSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Rt5kvlzONoasSmOFVJZmeBGB6BMuyJkRgOpR9G_82O8"
    static var isNew = "new"
    static var endpointTopRated = "https://api.themoviedb.org/3/movie/top_rated"
    static var endpointPopular = "https://api.themoviedb.org/3/movie/popular"
    static var endpointSearch = "https://api.themoviedb.org/3/search/movie"
    static var imagePath = "https://image.tmdb.org/t/p/w220_and_h330_face"
}

enum FontSize: CGFloat {
    case small = 15
    case medium = 20
    case big = 30
}
