//
//  APIManager.swift
//  APIManager
//
//  Created by Sanju on 29/12/23.
//

import Foundation



open class APIManager {
    
    public static let shared: APIManager = APIManager()
    
    var baseURL: String?
    var token: String?
    
    /// Generic function for making HTTP API calls
    /// - Parameters:
    ///   - request: Request model with request parametes
    ///   - model: Decodable model of the json response
    /// - Returns: Decoded response and error object
    public func fetch<T: Decodable>(request: APIRequest, model: T.Type) async -> (T?, Error?) {
        guard let urlRequest = getURLRequest(request: request) else {
            let error = APIError.invalidURL
            return (nil, error)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            let resp = try mapResponse(response: (data, response))
            let decoder = JSONDecoder()
            let decodeData = try decoder.decode(model, from: resp)
            return (decodeData, nil)
        } catch {
            return (nil, error)
        }
    }
    
    
    
    func getURLRequest(request: APIRequest) -> URLRequest? {
        guard let url = getURL(request: request) else { return nil }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = request.getHTTPMethod().rawValue
        
        if request.getHTTPMethod() != .get {
            let bodyData = try? JSONSerialization.data(withJSONObject: request.getBody())
            urlRequest.httpBody = bodyData
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        if let token, request.isAuthenticatedAPI() {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return urlRequest
    }
    
    
    func getURL(request: APIRequest) -> URL? {
        
        guard let baseURL: String = request.getBaseURL() ?? baseURL else {
            return nil
        }
        
        let endPoint: String = request.apiEndPoint
        
        let baseUrlString = "\(baseURL)/\(endPoint)"
        
        var url = URLComponents(string: baseUrlString)
        
        var queryItemList: [URLQueryItem] = []
        
        for (key, value) in request.getQueryParams() {
            queryItemList.append(URLQueryItem(name: key, value: value))
        }
        url?.queryItems = queryItemList
        
        return url?.url
    }
    
    func mapResponse(response: (data: Data, response: URLResponse)) throws -> Data {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            return response.data
        }
        
        switch httpResponse.statusCode {
        case 200..<300:
            return response.data
        case 400:
            throw APIError.badRequest
        case 401:
            throw APIError.unauthorized
        case 402:
            throw APIError.paymentRequired
        case 403:
            throw APIError.forbidden
        case 404:
            throw APIError.notFound
        case 413:
            throw APIError.requestEntityTooLarge
        case 422:
            throw APIError.unprocessableEntity
        default:
            throw APIError.http(httpResponse: httpResponse, data: response.data)
        }
    }
    
    public func setToken(token: String?) {
        self.token = token
    }
    
    public func clearToken() {
        self.token = nil
    }
}
