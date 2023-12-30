//
//  ProductListRequest.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//

import APIManager


struct ProductListRequest: APIRequest {
    var apiEndPoint: String = "products"
    
    let pageLimit: Int = 20
    var lastId: Int
    
    
    func getQueryParams() -> [String : String?] {
        [
            "limit": "\(pageLimit)",
            "skip": "\(lastId)"
        ]
    }

}
