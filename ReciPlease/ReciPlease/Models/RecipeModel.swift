//
//  RecipeModel.swift
//  ProductTest
//
//  Created by Tim Copland on 23/09/21.
//

import Foundation
import UIKit


enum Unit: String, CaseIterable, Identifiable, Codable {
    case each
    case g
    case kg
    case ml
    case l
    case cup
    case Tbsp
    case tsp
    
    var id: String {self.rawValue}
}

struct Ingredient: Identifiable, Codable {
    var id = UUID()
    
    var name:String = ""
    var unit: Unit = .each
    var quantity:String = ""
    var product: Product?
    
}
                
class Recipe: ObservableObject, Identifiable, Codable {
    var id: UUID
    @Published var name: String
    @Published var method: [Step]
    @Published var ingredients: [Ingredient]
    @Published var uiImage : UIImage?
    @Published var cookTime: String 
    @Published var numIngredients: String
    @Published var currentIngredient: Ingredient
    
    init(){
        self.id = UUID()
        self.name = ""
        self.method = []
        self.ingredients = []
        self.cookTime = "10 Min"
        self.numIngredients = "10 Ingredients"
        self.currentIngredient = Ingredient()
    }
}

struct Step: Identifiable, Codable{
    var id: UUID
    var string: String
    
    init(){
        self.string = ""
        self.id = UUID()
    }
}

class RecipeModel: ObservableObject, Codable {
    @Published var recipes: [Recipe]
    @Published var selectedRecipe: Recipe
    
    init() {
        self.recipes = [Recipe()]
        self.selectedRecipe = Recipe()
        self.recipes[0].name = "A yummy donut"
        self.recipes[0].uiImage = UIImage(named: "donut")
    }
    
    public static func getRecList(){
            let manager = FileManager.default
            
            guard let url  = manager.urls(for: .documentDirectory, in: .userDomainMask).first else{
                return
            }
            
            print(url.path)
            
            let recFolder = url.appendingPathComponent("Recipes")
            let recipeList = recFolder.appendingPathComponent("RecipeList.txt")
            
            do {
                let tempRecList = manager.contents(atPath: recipeList.path)
                let result = try JSONDecoder().decode([Recipe].self, from: tempRecList!)
                recipes = result
                
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
            
            let encoder = JSONEncoder()
            let recFolder = url.appendingPathComponent("Recipes")
            let recipeList = recFolder.appendingPathComponent("RecipeList.txt")
            
            do {
                
                let data = try encoder.encode(self.recipes)
                try manager.createDirectory(at: recFolder, withIntermediateDirectories: true, attributes: [:])
                try manager.createFile(atPath: recipeList.path, contents: data, attributes: [:])
            }
            catch{
                print(error)
            }
        }
    
}





