//
//  Strings.swift
//  colpatria
//
//  Created by jonnattan Choque on 18/05/24.
//

import Foundation

struct Strings {
    struct General {
        struct Alert {
            static var button: String = "General.Alert.button".localized()
        }
    }
    
    struct Home {
        static var EmptyTitle: String = "Home.EmptyTitle".localized()
        static var AlertErrorTitle: String = "Home.AlertError.title".localized()
        static var AlertErrorMessage: String = "Home.AlertError.message".localized()
        static var AlertEmptyTitle: String = "Home.AlertEmpty.title".localized()
        static var AlertEmptyMessage: String = "Home.AlertEmpty.message".localized()
        static var FilterShow: String = "Home.Filter".localized()
        static var Search: String = "Home.Search".localized()
        
        struct Filter {
            static var title: String = "Home.Filter.title".localized()
            static var Adult: String = "Home.Filter.adult".localized()
            static var Languague: String = "Home.Filter.languague".localized()
            static var Average: String = "Home.Filter.average".localized()
            static var Min: String = "Home.Filter.min".localized()
            static var Max: String = "Home.Filter.max".localized()
            static var Apply: String = "Home.Filter.apply".localized()
            static var Cancel: String = "Home.Filter.cancel".localized()
            static var Remove: String = "Home.Filter.remove".localized()
        }
    }
    
    struct Movie {
        static var Title: String = "Movie.Title".localized()
    }
}
