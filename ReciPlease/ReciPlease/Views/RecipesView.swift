//
//  RecipesView.swift
//  ProductTest
//
//  Created by Tim Copland on 23/09/21.
//

import SwiftUI

struct RecipesView: View {
    @EnvironmentObject var recipeModel: RecipeModel
    var body: some View {
        List(recipeModel.recipes) { recipe in
            NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                Text(recipe.name)
            }
        }
    }
}

//struct RecipesView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipesView()
//    }
//}
