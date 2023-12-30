//
//  ProductModel.swift
//  NoBroker
//
//  Created by Sanju on 29/12/23.
//



// MARK: - ProductResponseModel
struct ProductResponseModel: Decodable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}



// MARK: - Product
struct Product: Decodable, ListCellData {
    var identifier: String = "ProductTVCell"
    
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
    
    
    enum CodingKeys: CodingKey {
        case id
        case title
        case description
        case price
        case discountPercentage
        case rating
        case stock
        case brand
        case category
        case thumbnail
        case images
    }
}
