/**
//
//  item.swift
//  WebScraper
//
//  Created by Baxter Robb on 27/05/21.
//
 */
import Foundation

///Possibly should just collapse this and prod into one class.
///Contains method to GET request products from the countdown API
public class prodRequest{
    /**
    Function returns the products from a particular URL.

    - parameter input: url to request from
    - returns: void method
    - warning: need to add warnings

     # Notes: #
     1. Need to add better error handling
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
               // print(result.products.items[i])
            }
            //print(result.products)
        }
        catch{
            print("failed to convert: \(error.localizedDescription)")
            print("AT:")
            print(input)
        }

        guard let json = result else{
            return
        }
        
        //print(json.products)
        print("hey")
        Data.Ingredients.append(json.products.items[1])
        return
        
    })
    task.resume()
    

}
    
}



///Contains structs that emulate the structure of the JSON that is returned by the countdown API.
public class Prod{

///A list of the items
public struct Products: Codable{
    let products: Items
}

///Same as above.
///Looks redundant but required to match the JSON
public struct Items: Codable{
    let items: [Food]

}

/// Contains info on food items needed for recipe
public struct Food:Codable{
    let type: String
    let name: String
    let price: Price
    let unit: String
}
    
///planned to be used in the beta
struct Size: Codable{
    let cupPrice: Int
    let cupMeasure: String
    let packageType: String
    let volumesize: String
}
    
///planned to be used in the beta
struct Images: Codable{
    let small: String
    let big: String
}

///planned to be used in the beta
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

///provides data structure for recipes used in the app
public class Reci{
    public struct Recipe{
        let name: String
        let method: String
        let description: String
        let Ingredients: [String]
        let Quants: [Double]
        let Serving: Int
        let Image: String
    }
}
