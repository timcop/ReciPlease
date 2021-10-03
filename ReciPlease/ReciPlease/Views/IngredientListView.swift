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
                    VStack(alignment: .leading){
                        Text(ingredient.quantity + " " + ingredient.unit.id + " of: ")
                            .padding(.horizontal)
                            .font(Font.body.weight(.bold))
                        Text(ingredient.name)
                            .padding(.horizontal)
                            .padding(.vertical, 2.0)
                    }
                    Spacer()
                    if(currentRecipe.ingredients.product!=nil){
                    AsyncImageHack(url: URL(string: (ingredient.product?.img.imageURL)!)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    }else{
                        Image(systemName: "photo")
                    }
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
