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
    var quantity: Double?
    var product: Product?
    
}
                
class Recipe: ObservableObject, Identifiable, Codable {
    @Published var id: UUID
    @Published var name: String
    @Published var method: [Step]
    @Published var ingredients: [Ingredient]
//    @Published var uiImage : SomeImage?
    @Published var uiImage: UIImage
    @Published var cookTime: String
    @Published var servings: String
    @Published var currentIngredient: Ingredient
    
//    init(uiImage:UIImage) {
//            self.uiImage = uiImage
//        }
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case method
        case ingredients
        case uiImage
        case cookTime
        case servings
        case currentIngredient
        case scale
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        method = try container.decode([Step].self, forKey: .method)
        ingredients = try container.decode([Ingredient].self, forKey: .ingredients)
//        uiImage = try container.decode(SomeImage.self, forKey: .uiImage)
        let scale = try container.decode(CGFloat.self, forKey: .scale)
        let uiImage = try container.decode(UIImage.self, forKey: .uiImage)
        self.uiImage = UIImage(data:uiImage.pngData()!, scale:scale)!
        cookTime = try container.decode(String.self, forKey: .cookTime)
        servings = try container.decode(String.self, forKey: .servings)
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
        try container.encode(servings, forKey: .servings)
        try container.encode(currentIngredient, forKey: .currentIngredient)
        try container.encode(self.uiImage, forKey: .uiImage)
        try container.encode(self.uiImage.scale, forKey: .scale)
    }
    
    init(){
        self.id = UUID()
        self.name = ""
        self.method = []
        self.ingredients = []
        self.cookTime = ""
        self.servings = ""
        self.currentIngredient = Ingredient()
//        self.uiImage = SomeImage(photo: UIImage(named: "donut")!)
        self.uiImage = UIImage(named: "recipe_default")!
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
//        self.recipes[0].name = "A yummy donut"
//        self.recipes[0].uiImage = SomeImage(photo: UIImage(named: "donut")!)
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

//struct Image: Codable {
//    let image:UIImage
//    init(image:UIImage) {
//        self.image = image
//    }
//    enum CodingKeys: CodingKey {
//        case image
//        case scale
//    }
//    public init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let scale = try container.decode(CGFloat.self, forKey: .scale)
//        let image = try container.decode(UIImage.self, forKey: .image)
//        self.image = UIImage(data:image.pngData()!, scale:scale)!
//    }
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.image, forKey: .image)
//        try container.encode(self.image.scale, forKey: .scale)
//    }
//}

extension KeyedEncodingContainer {
    mutating func encode(_ value: UIImage, forKey key: Key) throws {
        guard let data = value.pngData() else {
            throw EncodingError.invalidValue(
                value,
                EncodingError.Context(codingPath: [key],
                debugDescription: "Failed convert UIImage to data")
            )
        }
        try encode(data, forKey: key)
    }
}

extension KeyedDecodingContainer {
    func decode(_ type: UIImage.Type, forKey key: Key) throws -> UIImage {
        let imageData = try decode(Data.self, forKey: key)
        if let image = UIImage(data: imageData) {
            return image
        } else {
            throw DecodingError.dataCorrupted(
                DecodingError.Context(codingPath: [key],
                debugDescription: "Failed load UIImage from decoded data")
            )
        }
    }
}
