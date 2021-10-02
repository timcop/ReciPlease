//
//  EditIngredientView.swift
//  ReciPlease
//
//  Created by Ethan Fraser on 30/09/21.
//

import SwiftUI

struct EditIngredientView: View {
    
    @Binding var editingIngredient: Bool
    @State var isNewIngredient: Bool
    @State var currentRecipe: Recipe
    @Binding var currentIngredient: Ingredient
    @State var selectedUnit: Unit = Unit.each
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        ZStack{
            Color.black
                .onTapGesture {
                    currentIngredient = Ingredient()
                    withAnimation {
                        editingIngredient.toggle()
                    }
                }
                .ignoresSafeArea()
                .opacity(0.4)
            VStack(spacing: 0){
                Text("Item Details").padding(.top, 20)

                Form{
                    TextField("Name", text: $currentIngredient.name)

                    Picker(selection: $selectedUnit, label:Text("Unit")) {
                        Text("Each").tag(Unit.each)
                        Text("Grams").tag(Unit.g)
                        Text("Kg").tag(Unit.kg)
                        Text("mL").tag(Unit.ml)
                        Text("L").tag(Unit.l)
                        Text("Handfull").tag(Unit.handfull)
                        Text("Bunch").tag(Unit.bunch)
                    }
                
                    TextField("Quantity", text:$currentIngredient.quantity)

                }
                NavigationLink(destination: SearchProductsView(ingProd: $currentIngredient.product, searchText: $currentIngredient.name)) {
                   Text("Search product")
                }
                HStack {
                    Button("Cancel") {
                        currentIngredient = Ingredient()
                        withAnimation {
                            editingIngredient.toggle()
                        }
                    }.padding()
                    Button("Submit") {
                        if isNewIngredient {
                            currentRecipe.ingredients.append(currentIngredient)
                        } else {
                            let oldIngs = currentRecipe.ingredients
                            currentRecipe.ingredients = []
                            oldIngs.forEach {ing in
                                if ing.id == $currentIngredient.id {
                                    currentRecipe.ingredients.append(currentIngredient)
                                } else {
                                    currentRecipe.ingredients.append(ing)
                                }
                            }
                        }
                        currentIngredient = Ingredient()
                        withAnimation {
                            editingIngredient.toggle()
                        }
                    }.padding()
                }
            }.frame(width:350, height:310)
                .background(Color(.systemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                .shadow(color: .gray, radius: 5, x:-9, y: -9)
        }
    }
}

//struct EditIngredientView_Previews: PreviewProvider {
//    @State var editingIngredient = true
//    static var previews: some View {
//        EditIngredientView(editingIngredient: $editingIngredient,
//                           currentRecipe: Recipe(),
//                           currentIngredient: Ingredient())
//    }
//}
