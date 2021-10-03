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
                        Text(String(ingredient.product?.sizeDetail.cupPrice) + " per " + ingredient.product?.sizeDetail.cupMeasure)
                    }
                    Spacer()
                    AsyncImageHack(url: URL(string: (ingredient.product?.img.imageURL) ?? "photo")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .padding(.horizontal)
                        case .failure:
                            Image(systemName: "photo")
                                .padding(.horizontal)
                        @unknown default:
                            EmptyView()
                        }
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
