//
//  ContentView.swift
//  ProductTest
//
//  Created by Tim Copland on 22/09/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var recipeModel = RecipeModel()
    @State var test: String = ""
    var body: some View {
        NavigationView {
            VStack {
                Text("Home Screen").font(.largeTitle)
                TextField("Test", text: $test).padding()
                Text(test)
                
                HStack {
                    NavigationLink(destination: AddRecipeView()) {
                        Text("Add a recipe!").padding()
                    }
                    Spacer()
                    NavigationLink(destination: RecipesView()) {
                        Text("View Recipes").padding()
                    }
                }
                List(recipeModel.recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(selectedRecipe: recipe)) {
                        Text(recipe.name)
                    }
//                    .simultaneousGesture(TapGesture().onEnded {
//                        recipeModel.selectedRecipe = recipe
//                    })
                }
                Spacer()

            }
        }
        .environmentObject(recipeModel)
    }
}
                
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(Recipe())
        }
    }
}
