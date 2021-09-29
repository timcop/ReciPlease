//
//  RecipeDetailView.swift
//  ProductTest
//
//  Created by Tim Copland on 27/09/21.
//

import SwiftUI

struct RecipeDetailView: View {
//    let recipe: Recipe
    @EnvironmentObject var recipeModel: RecipeModel
    @ObservedObject var selectedRecipe: Recipe
    @State var isIngredient = true
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .leading) {
                PictureView(imgName: selectedRecipe.imgName)
                Group {
                    // title
                    Text(selectedRecipe.name).font(.system(size: 22, weight: .bold))
                    
                    //info view
                    HStack(spacing: 32) {
                        HStack(spacing: 12) {
                            Image(systemName: "clock")
                                .foregroundColor(.green)
                            
                            Text(selectedRecipe.cookTime)
                            Image(systemName:"pencil")
                                .foregroundColor(.green)
                            Text(selectedRecipe.numIngredients)
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                // ingredient/step toggle view
                Toggle(isOn: $isIngredient, label: {})
                    .toggleStyle(IngredientMethodToggleStyle())
                
                if isIngredient {
                    // ingredient list
                    IngredientListView(ingredients: selectedRecipe.ingredients)
                } else {
                    MethodListView(method: selectedRecipe.method)
                    // steps list
                }
            }
        }
    }
}

struct IngredientMethodToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return
            VStack(alignment: .leading) {
                HStack {
                    Text("INGREDIENTS")
                        .font(.system(size:16, weight: configuration.isOn ? .bold : .regular))
                        .frame(width: 110)
                        .fixedSize()
                        .padding(4)
                        .padding(.leading, 12)
                        .onTapGesture {
                            withAnimation {
                                configuration.isOn = true
                            }
                        }
                    
                    Text("METHOD")
                        .font(.system(size:16, weight: configuration.isOn ? .regular : .bold))
                        .padding(4)
                        .onTapGesture {
                            withAnimation {
                                configuration.isOn = false
                            }
                        }
                }
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 3)
                    
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: configuration.isOn ? 110:70, height: 3)
                        .offset(x: configuration.isOn ? 16 : 140) // 0: 115
                    
                }
            }
    }
}

struct IngredientListView: View {
    var ingredients: [Ingredient]
    var body: some View {
        VStack {
            ForEach(ingredients) { ing in
                HStack{
                    Text(ing.name)
                        .padding(.horizontal)
                        .padding(.vertical, 4.0)
                    Spacer()
                }
                Divider()
            }
        }
    }
}

struct MethodListView: View {
    var method: [Step]
    var body: some View {
        ForEach(method) { step in
            Text(step.string)
                .padding(.horizontal)
                .padding(.vertical, 4.0)
        }
    }
}
//struct RecipeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            RecipeDetailView()
//        }
//    }
//}
