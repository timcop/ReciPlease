//
//  RecipeModel.swift
//  ProductTest
//
//  Created by Tim Copland on 23/09/21.
//

import Foundation


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
}

struct Step: Identifiable {
    var id = UUID()
    var string: String = ""
}

class RecipeModel: ObservableObject {
    @Published var recipes: [Recipe]
    
    init() {
        self.recipes = []
    }
}
