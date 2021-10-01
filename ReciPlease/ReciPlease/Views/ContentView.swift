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
    @State var searching = false
    
    var body: some View {
        NavigationView {
            VStack {
             
//                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 50) {
                        ForEach(recipeModel.recipes.filter {$0.name.contains(searchText) || searchText.isEmpty}) { recipe in
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
                .offset(y:140)
//                .searchable(text: $searchText, placement: .sidebar)
                Spacer()
                HStack {
                    Spacer()
                    NavigationLink(destination: newAddRecipeView()) {
                        Text("Add a recipe!").padding()
                    }
                    Spacer()
                }.offset(y:-20)

            }
            .navigationTitle("ReciPlease")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(recipeModel)
    }
}

struct HomeRecipeCardView: View {
    @State var recipe: Recipe
    var body: some View {
        ZStack {
            Image(uiImage: recipe.uiImage!)
                .resizable()
                .cornerRadius(15)
                .frame(width:300, height:300)
                .shadow(color: .gray, radius: 5, x:0, y: 3)
//            Rectangle()
//                .frame(width:250, height:40)
//                .cornerRadius(30)
            Text(recipe.name)
                .foregroundColor(Color.white)
                .frame(width: 250, height: 40)
                .background(Color.black)
                .clipShape(Rectangle())
                .cornerRadius(15)
                .offset(y:120)
  

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
