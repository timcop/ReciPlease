//
//  RecipeModel.swift
//  ProductTest
//
//  Created by Tim Copland on 23/09/21.
//

import Foundation
import UIKit
import SwiftUI

//
//enum Unit: String, CaseIterable, Identifiable {
//    case each
//    case g
//    case kg
//    case ml
//    case l
//    case cup
//    case Tbsp
//    case tsp
//
//    var id: String {self.rawValue}
//}
//
//struct Ingredient: Identifiable {
//    var id = UUID()
//
//    var name:String = ""
//    var unit: Unit = .each
//    var quantity:String = ""
//    var product: Product?
//
//}
//
//class Recipe: ObservableObject, Identifiable {
//    let id = UUID()
//    @Published var name: String = ""
//    @Published var method: [Step] = []
//    @Published var ingredients: [Ingredient] = []
//    @Published var uiImage : SomeImage?
//    @Published var cookTime: String = "10 min"
//    @Published var numIngredients: String = "10 ingredients"
//    @Published var currentIngredient = Ingredient()
//}
//
//struct Step: Codable, Identifiable {
//    var id = UUID()
//    var string: String = ""
//}
//
//class RecipeModel: ObservableObject {
//    @Published var recipes: [Recipe]
//    @Published var selectedRecipe: Recipe
//
//    init() {
//        self.recipes = [Recipe()]
//        self.selectedRecipe = Recipe()
//        self.recipes[0].name = "A yummy donut"
//        self.recipes[0].uiImage = SomeImage(photo: UIImage(named: "donut")!)
//    }
//}
public struct SomeImage: Codable {

    public var photo: Data

    public init(photo: UIImage) {
        self.photo = photo.pngData()!
    }
}


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
    @Published var id: UUID
    @Published var name: String
    @Published var method: [Step]
    @Published var ingredients: [Ingredient]
    @Published var uiImage : SomeImage?
    @Published var cookTime: String
    @Published var numIngredients: String
    @Published var currentIngredient: Ingredient
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case method
        case ingredients
        case uiImage
        case cookTime
        case numIngredients
        case currentIngredient
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        method = try container.decode([Step].self, forKey: .method)
        ingredients = try container.decode([Ingredient].self, forKey: .ingredients)
        uiImage = try container.decode(SomeImage.self, forKey: .uiImage)
        cookTime = try container.decode(String.self, forKey: .cookTime)
        numIngredients = try container.decode(String.self, forKey: .numIngredients)
        currentIngredient = try container.decode(Ingredient.self, forKey: .currentIngredient)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(method, forKey: .method)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(uiImage, forKey: .uiImage)
        try container.encode(cookTime, forKey: .cookTime)
        try container.encode(numIngredients, forKey: .numIngredients)
        try container.encode(currentIngredient, forKey: .currentIngredient)
    }
    
    init(){
        self.id = UUID()
        self.name = ""
        self.method = []
        self.ingredients = []
        self.cookTime = "10 Min"
        self.numIngredients = "10 Ingredients"
        self.currentIngredient = Ingredient()
        self.uiImage = SomeImage(photo: UIImage(named: "donut")!)
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
        self.recipes[0].uiImage = SomeImage(photo: UIImage(named: "donut")!)
    }
    
    enum CodingKeys: String, CodingKey {
        case recipes
        case selectedRecipe
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        recipes = try container.decode([Recipe].self, forKey: .recipes)
        selectedRecipe = try container.decode(Recipe.self, forKey: .selectedRecipe)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(recipes, forKey: .recipes)
        try container.encode(selectedRecipe, forKey: .selectedRecipe)
    }
    
    public func getRecList() -> [Recipe]{
            let manager = FileManager.default
            
            guard let url  = manager.urls(for: .documentDirectory, in: .userDomainMask).first else{
                return []
            }
            
            print(url.path)
            
            let recFolder = url.appendingPathComponent("Recipes")
            let recipeList = recFolder.appendingPathComponent("RecipeList.txt")
            
            let tempRecList = manager.contents(atPath: recipeList.path)
            if tempRecList != nil {
                if let result = try? JSONDecoder().decode([Recipe].self, from: tempRecList!) {
                    return result
                }
            } 
        return []
        }
    
    public func storeRecList(recs: [Recipe]){
            
            let manager = FileManager.default
            
            guard let url  = manager.urls(for: .documentDirectory, in: .userDomainMask).first else{
                return
            }
            
            print(url.path)
            
            let encoder = JSONEncoder()
            let recFolder = url.appendingPathComponent("Recipes")
            let recipeList = recFolder.appendingPathComponent("RecipeList.txt")
            
            do {
                let data = try encoder.encode(recs)
                try manager.createDirectory(at: recFolder, withIntermediateDirectories: true, attributes: [:])
                try manager.createFile(atPath: recipeList.path, contents: data, attributes: [:])
            }
            catch{
//                print(error)
            }
        }
}
