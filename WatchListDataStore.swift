//
//  WatchListDataStore.swift
//  Cart Crunch
//
//  Created by Gabe Jones on 4/27/23.
//

import Foundation

class DataStore {
    static let shared = DataStore()
    let userDefaults = UserDefaults.standard
    
    var watchlist: [Product] {
        get {
            if let data = userDefaults.data(forKey: "watchlist"),
               let watchlist = try? JSONDecoder().decode([Product].self, from: data) {
                return watchlist
            } else {
                return []
            }
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                userDefaults.set(data, forKey: "watchlist")
            }
        }
    }
}
