//
//  RecipeDetailView.swift
//  ProductTest
//
//  Created by Tim Copland on 27/09/21.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    var body: some View {
        Text(recipe.name)
    }
}

//struct RecipeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeDetailView()
//    }
//}
