//
//  ProductsModel.swift
//  ProductTest
//
//  Created by Tim Copland on 22/09/21.
//

import Foundation

struct ProductsResponse:Decodable {
    let products: ProductRef
}

struct ProductRef:Decodable {
    let items: [Product]
}

struct Product:Identifiable, Decodable {
    let id = UUID()
    
    let type: String
    let name: String
    let barcode: String
    let brand: String
    let unit: String
    let img: Img
    let priceDetails: PriceDetails
    
    enum CodingKeys: String, CodingKey {
        case type
        case name
        case barcode
        case brand
        case unit
        case img = "images"
        case priceDetails = "price"
    }
}

struct Img:Decodable {
    let imageURL: String
    enum CodingKeys: String, CodingKey {
        case imageURL = "big"
    }
}

struct PriceDetails : Decodable {
    let originalPrice: Double
    let salePrice: Double
    let savePrice: Double
    let isSpecial: Bool
}

enum FetchError: Error {
    case badURL
    case badResponse
}

class ProductsModel {
    func getProducts(searchTerm: String) async throws -> [Product] {
        guard let url = URL(string: "https://shop.countdown.co.nz/api/v1/products?target=search&search='\(searchTerm)'") else {
            return []
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("OnlineShopping.WebApp", forHTTPHeaderField: "x-requested-with")
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {throw FetchError.badResponse}
        
        let maybeProductData = try JSONDecoder().decode(ProductsResponse.self, from: data)
        return maybeProductData.products.items
    }
}
