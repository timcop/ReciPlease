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
    @State var searchText: String = ""
    var body: some View {
        NavigationView {
            VStack {
                Text("Home Screen").font(.largeTitle)
                TextField("Test", text: $test).padding()
                Text(test)
                
                HStack {
                    NavigationLink(destination: newAddRecipeView()) {
                        Text("Add a recipe!").padding()
                    }
                    Spacer()
                    NavigationLink(destination: RecipesView()) {
                        Text("View Recipes").padding()
                    }
                }
//                List(recipeModel.recipes) { recipe in
//                    NavigationLink(destination: RecipeDetailView(selectedRecipe: recipe)) {
//                        Text(recipe.name)
//                    }
//                    .simultaneousGesture(TapGesture().onEnded {
//                        recipeModel.selectedRecipe = recipe
//                    })
//                  }
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 50) {
                        ForEach(recipeModel.recipes) { recipe in
                            GeometryReader { geometry in
                                NavigationLink(destination: RecipeDetailView(selectedRecipe: recipe)) {
                                    HomeRecipeCardView(recipe: recipe)
                                }
                                .rotation3DEffect(Angle(degrees:
                                    Double(geometry.frame(in: .global).minX) / -20
                                       ), axis: (x: 0, y: 10.0, z: 0))
                            }
                            .frame(width:246, height: 350)
                        }
                    }
                    .padding()
                }
                .frame(height:100)
                .searchable(text: $searchText)
                Spacer()

            }
            Divider()
        }
        .environmentObject(recipeModel)
    }
}

struct HomeRecipeCardView: View {
    @State var recipe: Recipe
    var body: some View {
        ZStack {
            Image(recipe.imgName)
                .resizable()
                .cornerRadius(15)
                .frame(width:300, height:300)
                .shadow(color: .gray, radius: 5, x:0, y: 3)
//            Text(label)
        }
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
