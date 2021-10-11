//
//  IngredientListView.swift
//  ReciPlease
//
//  Created by Ethan Fraser on 30/09/21.
//

import SwiftUI

/** This is the view for displaying the ingredient information.
 Displays the name and quantity of the ingredient in a list, as well as
 the product it's linked to if it has been linked
 */
struct IngredientListView: View {
    @StateObject var currentRecipe: Recipe
    @Binding var isNewIngredient: Bool
    @Binding var editingIngredient: Bool
    @Binding var editingRecipe: Bool
    
    var body: some View {
        VStack{
            ForEach(currentRecipe.ingredients) { ingredient in

                VStack {
                    HStack {
                        Group {
//                            Text(ingredient.quantity!)
                            if (floor(ingredient.quantity!) == ingredient.quantity!) {
                                Text(String(format: "• %ld", Int(ingredient.quantity!)))
                                    .padding(.leading)
                            } else {
                                Text(String(format: "• %.2f", ingredient.quantity!))
                                    .padding(.leading)
                            }
//                            Text(String(format: (floor(ingredient.quantity!) == ingredient.quantity!) ? "• %ld" : "• %.2f" , (floor(ingredient.quantity!) == ingredient.quantity!) ? Int(exactly: ingredient.quantity!) : ingredient.quantity!)
//                                       )
//                                .padding(.leading)
 
                            Text(ingredient.unit)

                            Text(ingredient.name)
                                .padding(.vertical, 3.0)
                        }
                        .font(Font.body.weight(.bold))
                        Spacer()
                        if (editingRecipe) {
                            HStack {
                                Image(systemName:"pencil")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(Color.orange)
                                    .padding(.trailing, 18)
                                    .onTapGesture {
                                        isNewIngredient = false
                                        currentRecipe.currentIngredient = ingredient
                                        editingIngredient.toggle()
                                    }
                                Image(systemName:"xmark")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .foregroundColor(Color.orange)
                                    .onTapGesture {
                                        if let index = currentRecipe.ingredients.firstIndex(where: {$0.id == ingredient.id}) {
                                            currentRecipe.ingredients.remove(at: index)
                                        }
                                    }
                            }.padding(.trailing)
                        }
                    }
                    if (ingredient.product != nil) {

                        HStack{
                            Group {
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
                            }
                            .font(.system(size: 15))
                            Spacer()
                        }
                        .padding(.leading, 20)
                    }
                }
                Divider()
                    .hidden()
            }
        }
    }
}
