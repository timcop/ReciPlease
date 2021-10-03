//
//  IngredientListView.swift
//  ReciPlease
//
//  Created by Ethan Fraser on 30/09/21.
//

import SwiftUI

struct IngredientListView: View {
    @StateObject var currentRecipe: Recipe
//    var ingredients: [Ingredient]
    @Binding var isNewIngredient: Bool
//    @Binding var currentIngredient: Ingredient
    @Binding var editingIngredient: Bool
    var body: some View {
        VStack{
            ForEach(currentRecipe.ingredients) { ingredient in
                HStack{
                    Text(ingredient.name)
                        .padding(.horizontal)
                        .padding(.vertical, 4.0)
                    Spacer()
                }.onTapGesture {
                    isNewIngredient = false
                    currentRecipe.currentIngredient = ingredient
                    editingIngredient.toggle()
                }
                Divider()
            }
        }
    }
}

//struct IngredientListView_Previews: PreviewProvider {
//    static var previews: some View {
//        IngredientListView(ingredients: [])
//    }
//}
