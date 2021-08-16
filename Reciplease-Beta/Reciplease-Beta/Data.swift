//  Data.swift
//  WebScraper
//
//  Created by Baxter Robb on 2/06/21.
//
import Foundation

public class Data {
    
    public static var recipesUnderPrice: [Int] = []
    public static var Ingredients: [Prod.Food] = []
    public static var RecipeList: [Reci.Recipe] = []
    public static var RelationTable: [(rec: Int, ingr: Int)] = []
    public static var RecipeNum = 0
    public static var badUrlCount = 0
    public static var baseUrl = "https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page="
    static var URLList: [String] = []
    
    public static func setUrls() -> [String] {
        var urls: [String] = []
        var count = 2
        while (count <= 13) {
            urls.append("\(Data.baseUrl)\(count)")
            count+=1
        }
        return urls
    }
    
    public static func fillProds(){
        let URLList = setUrls()
        Ingredients = []
        RelationTable = []
        RecipeNum = 0
        
        for url in URLList{
            prodRequest.getProducts(from: url)
        }
        sleep(2)
        
        for i in 0..<RecipeList.count{
            let reci = RecipeList[i]
            for j in 0..<reci.Ingredients.count{
                let prodDesc = reci.Ingredients[j]
                for k in 0..<Ingredients.count{
                    if prodDesc.lowercased() == Ingredients[k].name.lowercased(){
                        RelationTable.append((RecipeNum, k))
                        break
                    }
                }
            }
            RecipeNum += 1
        }
    }
    
    // Needs reworking
    public static func addRecipe(n: String, method: String, description: String, Ing: [String],Quants: [Double],Serving: Int,Image: String,staples: [String],staplesQuant: [Int], staplesPPP: [Int]){
        let reci: Reci.Recipe = Reci.Recipe.init(name: n, method: method, description: description, Ingredients: Ing, Quants: Quants,Serving: Serving, Image: Image, staples: staples, staplesQuant: staplesQuant, staplesPPP: staplesPPP)
        
        RecipeList.append(reci)
        //RecipeNum += 1
        
    }
    
    //returns price of recipe for specified serving size (needs scaling)
    public static func priceRecipe(recNum: Int) -> Double{
        var price = 0.0
        var recInd = 1
        print(RelationTable.count)
        for i in 0..<RelationTable.count{
            print("PENIS")
            if(RelationTable[i].rec > recNum){
                return price
            }
            if(RelationTable[i].rec == recNum){
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
