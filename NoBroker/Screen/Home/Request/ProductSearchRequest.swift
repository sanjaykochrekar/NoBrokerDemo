//
//  ProductSearchRequest.swift
//  NoBroker
//
//  Created by Sanju on 30/12/23.
//

import APIManager



struct ProductSearchRequest: APIRequest {
    
    var apiEndPoint: String = "products/search"
    var search: String
    
    
    func getQueryParams() -> [String: String?] {
        [
            "q": search
        ]
    }
    
}
