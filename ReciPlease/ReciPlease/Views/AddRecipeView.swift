//
//  AddRecipeView.swift
//  ProductTest
//
//  Created by Tim Copland on 23/09/21.
//

import SwiftUI

let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

struct PictureView: View {
    var body: some View {
        Image("recipe_default")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: screenWidth, height: screenWidth)
//                    .offset(y:-100)
    }
}

struct AddRecipeView: View {
    @ObservedObject var currentRecipe: Recipe = Recipe()
    @EnvironmentObject var recipeModel: RecipeModel
    @Environment(\.presentationMode) var presentation
    

    var body: some View {
//        ScrollView {
        VStack(spacing: 20) {
//                PictureView()
            Text("Add Recipe").font(.largeTitle)
//                .offset(y: -50)

            Form {
                Section(header: Text("Recipe Name")) {
                    TextField("Recipe Name", text: $currentRecipe.name)
                }
            }
            
            NavigationLink(destination: AddIngredientView(ingredients: $currentRecipe.ingredients)) {
                Text("Add an ingredient")
                    .padding(.all)
            }
            
            List(currentRecipe.ingredients) { ing in
                VStack {
                    HStack {
                        Text(ing.name).font(.title3).bold().italic()
//                            Spacer()
                    }
                    HStack {
                        Text("Quantity: " + ing.quantity).font(.body)
                        Text("Unit: " + ing.unit.rawValue).font(.body)
//                            Spacer()
                    }
                    if let prod = ing.product {
                        Text(prod.name)
                    }
                }
            }
        }
        
        Spacer()
        Button("Submit") {
            recipeModel.recipes.append(currentRecipe)
            self.presentation.wrappedValue.dismiss()

        }
//        }
    }

}


struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
            .padding()
.previewInterfaceOrientation(.portrait)
    }
}
