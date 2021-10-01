//
//  RecipeModel.swift
//  ProductTest
//
//  Created by Tim Copland on 23/09/21.
//

import Foundation
import UIKit


enum Unit: String, CaseIterable, Identifiable {
    case each
    case g
    case kg
    case ml
    case l
    case handfull
    case bunch
    
    var id: String {self.rawValue}
}

struct Ingredient: Identifiable {
    var id = UUID()
    
    var name:String = ""
    var unit: Unit = .each
    var quantity:String = ""
    var product: Product?
    
}
                
class Recipe: ObservableObject, Identifiable {
    let id = UUID()
    @Published var name: String = ""
    @Published var method: [Step] = []
    @Published var ingredients: [Ingredient] = []
    @Published var uiImage : UIImage?
    @Published var cookTime: String = "10 min"
    @Published var numIngredients: String = "10 ingredients"
}

struct Step: Codable, Identifiable {
    var id = UUID()
    var string: String = ""
}

class RecipeModel: ObservableObject {
    @Published var recipes: [Recipe]
    @Published var selectedRecipe: Recipe
    
    init() {
        self.recipes = [Recipe()]
        self.selectedRecipe = Recipe()
        self.recipes[0].name = "A yummy donut"
        self.recipes[0].uiImage = UIImage(named: "donut")
    }
}
