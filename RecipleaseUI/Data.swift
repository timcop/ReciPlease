//  Data.swift
//  WebScraper
//
//  Created by Baxter Robb on 2/06/21.
//
import Foundation

public class Data{
    
    ///For a particular request, will store the indexes of all recipes under budget
    public static var recipesUnderPrice: [Int] = []
    public static var Ingredients: [Prod.Food] = []
    public static var RecipeList: [Reci.Recipe] = []
    ///Allows each recipe to reference ingredients from Ingredients array without need for duplication
    public static var RelationTable: [(rec: Int, ingr: Int)] = []
    public static var RecipeNum = 0
    ///really ugly, will pretty this up for the beta
    static var URLList: [String] = ["https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=2","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=3","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=4","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=5","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=6","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=7","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=8","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=9","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=10","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=11","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=12","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=13","https://shop.countdown.co.nz/api/v1/products?dasFilter=Department%3B%3Bfruit-veg%3Bfalse&target=browse&page=14"]
    
    ///need to remove
    init(){
        
    }
    
    ///iterates through the listed URLs to fill up the ingredients
    public static func fillProds(){
        for url in URLList{
            prodRequest.getProducts(from: url)
        }
                    
    }
    
    /**
    Simple method adds a recipe with given inputs

     # Notes: #
     1. Parameters self explanatory
     2.Need to work out how images are to be uploaded once user inputted recipes available in the beta
    */
    public static func addRecipe(n: String, method: String, description: String, Ing: [String],Quants: [Double],Serving: Int,Image: String){
        let reci: Reci.Recipe = Reci.Recipe.init(name: n, method: method, description: description, Ingredients: Ing, Quants: Quants,Serving: Serving, Image: Image)
        
        for prodDesc in reci.Ingredients{
            print("lookingG")
            print(prodDesc)
            print(Data.Ingredients)
            for i in 0..<Ingredients.count{
         
                if prodDesc == Ingredients[i].name{
                    
                    RelationTable.append((RecipeNum, i))
                   
                }
            }
        }
        
        RecipeList.append(reci)
        RecipeNum += 1
        
    }
    /**
    Method searchs through ingredients array to calculate the price of a recipe.

    - parameter recNum: index in recipeList of the recipe.
    - returns: price

     # Notes: #
     1. Currently assumes all ingredients are available, need to add error handling for this
    */
    public static func priceRecipe(recNum: Int) -> Double{
        var price = 0.0
        var recInd = 0
        for i in 0..<RelationTable.count{
            print("")
            if(RelationTable[i].rec > recNum){
                return price
            }
            if(RelationTable[i].rec == recNum && recInd<2){
                price += Ingredients[RelationTable[i].ingr].price.salePrice * RecipeList[recNum].Quants[recInd]
                recInd += 1
            }
        }
        return price

    }
}
