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
        
        print(data)
        var result: Prod.Products?
        do{
            let result = try JSONDecoder().decode(Prod.Products.self, from: data)
            for i in 0..<result.products.items.count{
                Data.Ingredients.append(result.products.items[i])
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
    /*
    let barcode: String
    let variety: String
    let brand: String
    let slug: String
    let sku: String
    let unit: String
 */
    /*
    let selectedPurchasingUnit: Bool
    let images: Images
    let quantity: Quantity
    let eachUnitQuantity: Int
    let averageWeightPerUnit: Double
    let size: Size
    let hasShopperNotes: Bool
    let productTag:Int
    let subsAllowed: Bool
    let supportsBothEachAndKgPricing: Bool
    let adId: Int
 */
    
    
    /*"images": {
        "small": "https://static.countdown.co.nz/assets/product-images/small/9421026690722.jpg",
        "big": "https://static.countdown.co.nz/assets/product-images/big/9421026690722.jpg"
    },
    "quantity": {
        "min": 1,
        "max": 100,
        "increment": 1,
        "value": null,
        "quantityInOrder": null
    },
    "eachUnitQuantity": null,
    "averageWeightPerUnit": null,
    "size": {
        "cupPrice": 37,
        "cupMeasure": "1KG",
        "packageType": "bagged",
        "volumeSize": "100g"
    },
    "hasShopperNotes": null,
    "productTag": null,
    "subsAllowed": false,
    "supportsBothEachAndKgPricing": false,
    "adId": null
 */
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
    //let originalPrice: Double
    let salePrice: Double
    //let savePrice: Double
    /*
    let hasBonusPoints: String
    let isClubPrice: String
    let isSpecial: String
    let isNew: String
    let canShowOriginalPrice: String
    let discount: String
    let total: String
    let isTargetedOffer: String
    let averagePricePerSingleUnit: String
 */
}

}

public class Reci{
    public struct Recipe{
        let method: String
        let description: String
        let Ingredients: [String]
        let Quants: [Double]
        let Serving: Int
    }
}
