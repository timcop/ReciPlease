//
//  item.swift
//  WebScraper
//
//  Created by Baxter Robb on 27/05/21.
//
import Foundation

public class prodRequest{

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
        //Data.Ingredients.append(json.products.items[1])
        return
        
    })
    task.resume()
    

}
    
}

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

/*
public class List: Codable{
    public struct RecList: Codable{
        var recipelist: [Reci.Recipe]
    }
    init() {
        RecList.init(recipelist: [])
    }
}
 */

