//
//  item.swift
//  WebScraper
//
//  Created by Baxter Robb on 27/05/21.
//
import Foundation

/**
 Contains method to scrape products from the Countdown API
 */
public class prodRequest{
    public static var badUrl = false
    /**
     'getProducts' scrapes from the Countdown API'
     -Parameter input: the URL to scrape products from
     */
    public static func getProducts(from input: String) {
    
        guard let url = URL(string: input) else {return}
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.setValue("OnlineShopping.WebApp", forHTTPHeaderField: "x-requested-with")
        
    
        let task = URLSession.shared.dataTask(with: request, completionHandler: {data,repsonse,error in
            
            guard let data = data, error == nil else{
                print("something went wrong")
                return
            }
            
            var result: Prod.Products?
            do{
                let result = try JSONDecoder().decode(Prod.Products.self, from: data)
                for i in 0..<result.products.items.count{
                    Data.Ingredients.append(result.products.items[i])
                }
            }
            catch{
                print("failed to convert: \(error.localizedDescription)")
                print("AT:")
                print(input)
                badUrl = true
            }

            return
            
        })
        task.resume()
        
        
    }
    
}

/**
 Data structure for an ingredient
 Emulates the structure of the JSON for a product used by the Countdown API
 */
public class Prod{
    
    
    public struct Products: Codable{
        let products: Items
    }
    
    public struct Items: Codable{
        let items: [Food]
        
    }
    
    public struct Food:Codable{
        let type: String
        let name: String
        let price: Price
        let unit: String
    }
    struct Size: Codable{
        let cupPrice: Int
        let cupMeasure: String
        let packageType: String
        let volumesize: String
    }
    struct Images: Codable{
        let small: String
        let big: String
    }
    struct Quantity: Codable{
        let min: Int
        let max: Int
        let increment: Int
        let value: Int
        let quantity: Int
    }
    struct Price: Codable{
        let salePrice: Double
        
    }
    
}

/**
 Data Stucture for a recipe
 */
public class Reci: Codable{
    
    
    public struct Recipe: Codable,Hashable{
        let name: String
        let method: String
        let description: String
        let Ingredients: [String]
        let Quants: [Double]
        let Serving: Int
        let Image: String
        let staples: [String]
        let staplesQuant: [Int]
        let staplesPPP: [Int]
    }
}
