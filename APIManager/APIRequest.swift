//
//  APIRequest.swift
//  APIManager
//
//  Created by Sanju on 29/12/23.
//




public protocol APIRequest {
    
    var apiEndPoint: String { get set }
    
    func getQueryParams() -> [String: String?]
    
    func getBaseURL() -> String?
    
    func getHTTPMethod() -> HttpMethod
    
    func getBody() -> [String: Any]
    
    func isAuthenticatedAPI() -> Bool
}


public extension APIRequest {
    
    var apiEndPoint: String {
        return ""
    }
    
    //TODO: Query params need to be dictionry
    // To make code simple for this project I have taken it as string
    func getQueryParams() -> [String: String?] {
        return [:]
    }
    
    func getBaseURL() -> String? {
        //Assumed we are using single base url
        //method can be configured if we have multiple url with enum
        // OR by overriding for different url(For special case)
        return "https://dummyjson.com"
    }
    
    func getHTTPMethod() -> HttpMethod {
        .get
    }
    
    func getBody() -> [String: Any] {
        Dictionary<String, Any>()
    }
    
    func isAuthenticatedAPI() -> Bool {
        true
    }
    
}
