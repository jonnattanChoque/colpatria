//
//  Json.swift
//  colpatria
//
//  Created by jonnattan Choque on 19/05/24.
//

import Foundation

class Json {

    static var shared: Json = {
        let instance = Json()
        return instance
    }()
    
    private init() {}

    func read() -> [Language]? {
        let fileName = "languages"
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let languages = try decoder.decode([Language].self, from: data)
                return languages
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

struct Language: Codable {
    let iso6391: String
    let englishName: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case englishName = "english_name"
        case name
    }
}
