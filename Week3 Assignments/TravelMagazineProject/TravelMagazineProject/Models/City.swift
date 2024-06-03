//
//  City.swift
//  TravelMagazineProject
//
//  Created by user on 5/29/24.
//

struct City {
    let city_name: String
    let city_english_name: String
    let city_explain: String
    let city_image: String
    let domestic_travel: Bool
    
    var cityHeaderText: String {
        return "\(city_name) | \(city_english_name)"
    }
    
    func containsSearchText(_ searchText: String) -> Bool {
        if city_name.localizedStandardContains(searchText)
            || city_english_name.localizedStandardContains(searchText)
            || city_explain.localizedStandardContains(searchText) {
            return true
        } else {
            return false
        }
    }
}
