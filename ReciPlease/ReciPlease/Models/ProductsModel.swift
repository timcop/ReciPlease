//
//  ProductsModel.swift
//  ProductTest
//
//  Created by Tim Copland on 22/09/21.
//

import Foundation

struct FailableDecodable<Base : Codable> : Codable, Identifiable {
    let id = UUID()
    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}


struct ProductsResponse:Codable {
    let products: ProductRef
}

struct ProductRef:Codable {
    let items: [FailableDecodable<Product>]
}


/**
 Countdown product struct which conforms to the JSON format of retrieved countdown products.
 */
struct Product:Identifiable, Codable {
    let id = UUID()
    
    let type: String
    let name: String
    let barcode: String
    let brand: String
    let unit: String
    let img: Img
    let priceDetails: PriceDetails
    let sizeDetails: SizeDetails
    
    enum CodingKeys: String, CodingKey {
        case type
        case name
        case barcode
        case brand
        case unit
        case img = "images"
        case priceDetails = "price"
        case sizeDetails = "size"
    }
}
/**
 struct to deal with product images.
 */
struct Img:Codable {
    let imageURL: String
    enum CodingKeys: String, CodingKey {
        case imageURL = "big"
    }
}
/**
 Price details of product.
 */
struct PriceDetails : Codable {
    let originalPrice: Double
    let salePrice: Double
    let savePrice: Double
    let isSpecial: Bool
}

/**
 Size details of product.
 */
struct SizeDetails : Codable {
    let cupPrice: Double?
    let cupMeasure: String?
    let volumeSize: String?
    let packageType: String?
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
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw FetchError.badResponse
            }
            
            let maybeProductData = try JSONDecoder().decode(ProductsResponse.self, from: data)
            let filtered = maybeProductData.products.items
                .compactMap{$0.base}
                
            return filtered
        } catch {
            return []
        }

    }
}

