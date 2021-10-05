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

                VStack {
                    HStack {
                        Group {
                            Text(ingredient.quantity)
                                .padding(.leading)
    //                            .padding(.vertical, 4.0)
                            if (ingredient.unit.id != "each") {
                                Text(ingredient.unit.id)
                            }
                            Text(ingredient.name)
                                .padding(.vertical, 3.0)
//                                .padding(.horizontal)
//                                .font(Font.body.weight(.bold))
                        }.font(Font.body.weight(.bold))
                        Spacer()
                    }
                    if (ingredient.product != nil) {

                        HStack{
                            Text("-")
                            if (ingredient.product?.sizeDetails.cupPrice != nil && ingredient.product?.sizeDetails.cupPrice != 0.0) {
                                Text(String(format: "$%.2f", ingredient.product?.sizeDetails.cupPrice ?? ""))
                            } else {
                                Text(String(format: "$%.2f", ingredient.product?.priceDetails.salePrice ?? ""))
                            }
                            Text("/")
                            if (ingredient.product?.sizeDetails.cupMeasure != nil) {
                                Text(ingredient.product?.sizeDetails.cupMeasure ?? "")
                                
                            } else {
                                Text(ingredient.product?.sizeDetails.volumeSize ?? "")
                            }
                            Spacer()

                        }
                    }
//
//                    AsyncImageHack(url: URL(string: (ingredient.product?.img.imageURL) ?? "photo")) { phase in
//                        switch phase {
//                        case .empty:
//                            ProgressView()
//                        case .success(let image):
//                            image.resizable()
//                                .interpolation(.none)
//                                .scaledToFit()
//                                .frame(width: 80, height: 80)
//                                .padding(.horizontal)
//                        case .failure:
//                            Image(systemName: "photo")
//                                .padding(.horizontal)
//                        @unknown default:
//                            EmptyView()
//                        }
//                    }
                }
//                }.onTapGesture {
//                    isNewIngredient = false
//                    currentRecipe.currentIngredient = ingredient
//                    editingIngredient.toggle()
//                }
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
