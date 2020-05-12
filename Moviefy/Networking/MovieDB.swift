//
//  MovieDB.swift
//  Moviefy2
//
//  Created by Nicholas Kearns on 4/29/20.
//  Copyright © 2020 Adriana González Martínez. All rights reserved.
//

import Foundation

struct MovieDB { // logic specific to the TMDB API
    
    public static let baseImageURL = URL(string: "https://image.tmdb.org/t/p/w500")!

    
    
    public static let baseURL = URL(string: "https://api.themoviedb.org/3/")!
    public static var api: APIClient = {
        let configuration = URLSessionConfiguration.default
        let apiKey = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyYjIyZjFjNmVjOTQyYWM0ZWI1ZWY3ZmJhOGZlMWMzMyIsInN1YiI6IjVlYTlmYTY3ZTRjOWViMDAxZGUyYWQxNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.y6qRklC0sIpn7iiB6Ndqayq2iuXethK5Rejm3Ts66Zc"
        configuration.httpAdditionalHeaders = [
            "Authorization": "Bearer \(apiKey)"
        ]
        return APIClient(configuration: configuration)
    }()
}
