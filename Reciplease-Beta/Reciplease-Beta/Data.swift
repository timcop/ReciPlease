//  Data.swift
//  WebScraper
//
//  Created by Baxter Robb on 2/06/21.
//
import Foundation

/**
 Data storage and methods for updating/accessing stored data
 Contains storage for recipes, ingredient, and a relation table.
 */
public class Data {
    public static var recipesUnderPrice: [Int] = []
    public static var Ingredients: [Prod.Food] = []
    public static var RecipeList: [Reci.Recipe] = []
    public static var RelationTable: [(rec: Int, ingr: Int)] = []
    public static var RecipeNum = 0
    public static var badUrlCount = 0
    public static var baseUrl = "https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page="
    static var URLList: [String] = []
    
    /**
     Takes the base of the URL and appends the page numbers
     -Returns: a string array of completed URLs
     */
    public static func setUrls() -> [String] {
        var urls: [String] = []
        var count = 2
        while count <= 13 {
            urls.append("\(Data.baseUrl)\(count)")
            count+=1
        }
        return urls
    }
    
    /**
     'fillProds'  iterates through the URLs and fills the ingredients list with ingredients from countdown.
     Iterates through the list of recipes and updates the relation table.
     */
    public static func fillProds() {
        let URLList = setUrls()
        Ingredients = []
        RelationTable = []
        RecipeNum = 0
        
        for url in URLList {
            prodRequest.getProducts(from: url)
        }
        sleep(2)
        
        for i in 0..<RecipeList.count {
            let reci = RecipeList[i]
            for j in 0..<reci.Ingredients.count {
                let prodDesc = reci.Ingredients[j]
                for k in 0..<Ingredients.count {
                    if prodDesc.lowercased() == Ingredients[k].name.lowercased() {
                        RelationTable.append((RecipeNum, k))
                        break
                    }
                }
            }
            RecipeNum += 1
        }
    }
    
    /**
     'addRecipe' adds a recipe to the database
     Takes parameters required to fill recipe data structure
     Also has parameters for staples which are for final release
     */
    public static func addRecipe(n: String, method: String,
                                 description: String, Ing: [String],
                                 Quants: [Double],Serving: Int,
                                 Image: String,staples: [String],
                                 staplesQuant: [Int], staplesPPP: [Int]) {
        
        let reci: Reci.Recipe =
            Reci.Recipe.init(name: n, method: method,
                             description: description, Ingredients: Ing,
                             Quants: Quants,Serving: Serving, Image: Image,
                             staples: staples, staplesQuant: staplesQuant,
                             staplesPPP: staplesPPP)

        RecipeList.append(reci)
        storeRecList()
    }
    
    /**
     'priceRecipe' finds the price per serve of a given recipe
     -Parameter recNum: the position of the recipe in the recipe list
     -Returns: Price per serving
     */
    public static func priceRecipe(recNum: Int) -> Double {
        var price = 0.0
        var recInd = 1
        for i in 0..<RelationTable.count{
            if (RelationTable[i].rec > recNum) {
                return price
            }
            if (RelationTable[i].rec == recNum) {
                price += Ingredients[RelationTable[i].ingr].price.salePrice * RecipeList[recNum].Quants[recInd]
                recInd += 1
            }
        }
        for i in 0..<RecipeList[recNum].staplesPPP.count {
            price += Double(RecipeList[recNum].staplesPPP[i]*RecipeList[recNum].Serving)
        }
        print(price)
        return price
    }
    
    /**
     method to get the recipe list stored in files on device
     Gets the recipe list in JSON format and decodes into array of type Recipe
     */
    public static func getRecList() {
        let manager = FileManager.default
        
        guard let url  = manager.urls(for: .documentDirectory, in: .userDomainMask).first else{
            return
        }
        
        print(url.path)
        
        let recFolder = url.appendingPathComponent("Recipes")
        let recipeList = recFolder.appendingPathComponent("RecipeList.txt")
        
        do {
            let tempRecList = manager.contents(atPath: recipeList.path)
            let result = try JSONDecoder().decode([Reci.Recipe].self, from: tempRecList!)
            print(result)
            RecipeList = result
        }
        catch{
            print(error)
        }
    }
    
    /**
     stores the recipe list in a JSON format in files on device
     */
    public static func storeRecList() {
        
        let manager = FileManager.default
        
        guard let url  = manager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        
        print(url.path)
        
        let encoder = JSONEncoder()
        let recFolder = url.appendingPathComponent("Recipes")
        let recipeList = recFolder.appendingPathComponent("RecipeList.txt")
        
        do {
            let data = try encoder.encode(RecipeList)
            try manager.createDirectory(at: recFolder, withIntermediateDirectories: true, attributes: [:])
            manager.createFile(atPath: recipeList.path, contents: data, attributes: [:])
        }
        catch {
            print(error)
        }
    }
}

