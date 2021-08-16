//  Data.swift
//  WebScraper
//
//  Created by Baxter Robb on 2/06/21.
//
import Foundation

public class Data{
    
    public static var recipesUnderPrice: [Int] = []
    public static var Ingredients: [Prod.Food] = []
    public static var RecipeList: [Reci.Recipe] = []
    public static var RelationTable: [(rec: Int, ingr: Int)] = []
    public static var RecipeNum = 0
    static var URLList: [String] = ["https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=2","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=3","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=4","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=5","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=6","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=7","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=8","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=9","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=10","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=11","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=12","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=13","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=14"]
    
    init(){
        
    }
    
    //format looks like [[recipe number, missing ing num,...,missing ing num],[recip....]]
    public static func fillProds()-> [[Int]]{
        Ingredients = []
        RelationTable = []
        RecipeNum = 0
        
        var missing: [[Int]] = [[]]
        for url in URLList{
            prodRequest.getProducts(from: url)
        }
        sleep(2)
        
        
        
        print(RecipeList.count)
        for i in 0..<RecipeList.count{
            var missingForRec: [Int] = [i]
            var hasMissing: Bool = false
            let reci = RecipeList[i]
            print("penis")
            for j in 0..<reci.Ingredients.count{
                var found: Bool = false
                let prodDesc = reci.Ingredients[j]
                print("PENIS")
                for k in 0..<Ingredients.count{
                    print("p")
                    if prodDesc.lowercased() == Ingredients[k].name.lowercased(){
                        RelationTable.append((RecipeNum, k))
                        found = true
                        break
                    }
                    
                }
                if !found{
                    missingForRec.append(j)
                    hasMissing = true
                }
            }
            RecipeNum += 1
            
            if hasMissing{
                missing.append(missingForRec)
            }
            
            
        }
        return missing
                    
    }
    
    public static func addRecipe(n: String, method: String, description: String, Ing: [String],Quants: [Double],Serving: Int,Image: String,staples: [String],staplesQuant: [Int], staplesPPP: [Int]){
        let reci: Reci.Recipe = Reci.Recipe.init(name: n, method: method, description: description, Ingredients: Ing, Quants: Quants,Serving: Serving, Image: Image, staples: staples, staplesQuant: staplesQuant, staplesPPP: staplesPPP)
        
//        for prodDesc in reci.Ingredients{
//            print(Data.Ingredients.count)
//            print(prodDesc)
//            for i in 0..<Data.Ingredients.count{
//                if prodDesc.lowercased() == Data.Ingredients[i].name.lowercased(){
//
//                    RelationTable.append((RecipeNum, i))
//                    break
//                }
//            }
//        }
    
        RecipeList.append(reci)
        //RecipeNum += 1
        
    }
    
    //for lookinging up items when adding recipes
    public static func searchItem(input: String) -> [Int]{
        var out: [Int] = []
        for i in 0..<Ingredients.count{
            if (Ingredients[i].name.lowercased().contains(input.lowercased())){
                out.append(i)
            }
        }
        return out
    }
    
    //returns price of recipe for specified serving size (needs scaling)
    public static func priceRecipe(recNum: Int) -> Double{
        var price = 0.0
        var recInd = 0
        print(RelationTable.count)
        for i in 0..<RelationTable.count{
            print("PENIS")
            if(RelationTable[i].rec > recNum){
                return price
            }
            if(RelationTable[i].rec == recNum && recInd<2){
                price += Ingredients[RelationTable[i].ingr].price.salePrice * RecipeList[recNum].Quants[recInd]
                recInd += 1
            }
        }
        for i in 0..<RecipeList[recNum].staplesPPP.count{
            price += Double(RecipeList[recNum].staplesPPP[i]*RecipeList[recNum].Serving)
        }
        print(price)
        return price

    }
    
    public static func getRecList(){
        let manager = FileManager.default
        
        guard let url  = manager.urls(for: .documentDirectory, in: .userDomainMask).first else{
            return
        }
        
        print(url.path)
        print("HEEEYHEEEY")
        
        let recFolder = url.appendingPathComponent("Recipes")
        let recipeList = recFolder.appendingPathComponent("RecipeList.txt")
        
        do {
            let tempRecList = manager.contents(atPath: recipeList.path)
            let result = try JSONDecoder().decode([Reci.Recipe].self, from: tempRecList!)
            print(result)
            print("LDONEG")
            RecipeList = result
            
        }
        catch{
            print(error)
        }
    }
    
    public static func storeRecList(){
        
        let manager = FileManager.default
        
        guard let url  = manager.urls(for: .documentDirectory, in: .userDomainMask).first else{
            return
        }
        
        print(url.path)
        print("HEEEYHEEEY")
        
        let encoder = JSONEncoder()
        let recFolder = url.appendingPathComponent("Recipes")
        let recipeList = recFolder.appendingPathComponent("RecipeList.txt")
        
        do {
            
            let data = try encoder.encode(RecipeList)
            try manager.createDirectory(at: recFolder, withIntermediateDirectories: true, attributes: [:])
            try manager.createFile(atPath: recipeList.path, contents: data, attributes: [:])
            print("HEYEYEYEYEYE")
        }
        catch{
            print(error)
        }
    }
}
