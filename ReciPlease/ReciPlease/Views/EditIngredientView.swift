//
//  EditIngredientView.swift
//  ReciPlease
//
//  Created by Ethan Fraser on 30/09/21.
//

import SwiftUI

struct EditIngredientView: View {
    
    @EnvironmentObject var currentRecipe: Recipe
    @Binding var editingIngredient: Bool
    @State var isNewIngredient: Bool
    @State var selectedUnit: Unit = Unit.each
    @Environment(\.presentationMode) var presentation

    
    var body: some View {
            
        
        ZStack{
            Color.white
                .onTapGesture {
                    currentRecipe.currentIngredient = Ingredient()
                    withAnimation {
                        editingIngredient.toggle()
                    }
                }
                .ignoresSafeArea()
                .opacity(0.01)
            VStack(spacing: 0){
                Text("Item Details").padding(.top, 20)
                
                Form{
                    TextField("Name", text: $currentRecipe.currentIngredient.name)
                        .accessibilityIdentifier("IngredientNameField")


                    Picker(selection: $currentRecipe.currentIngredient.unit, label:Text("Unit")) {
                        Text("Each").tag(Unit.each)
                        Text("Grams").tag(Unit.g)
                        Text("Kg").tag(Unit.kg)
                        Text("mL").tag(Unit.ml)
                        Text("L").tag(Unit.l)
                        Text("Cup").tag(Unit.cup)
                        Text("Tablespoon").tag(Unit.Tbsp)
                        Text("Teaspoon").tag(Unit.tsp)
                    }
                
                    TextField("Quantity", value:$currentRecipe.currentIngredient.quantity, format: .number)
                        .accessibilityLabel("IngredientQuantityField")

//                        .keyboardType(.numberPad)
                    
                        
               
                    VStack{
                if(currentRecipe.currentIngredient.product != nil){
                    Text(currentRecipe.currentIngredient.product!.name.capitalized)
                        .font(.headline).bold().italic()
                        .frame(alignment: .center)
                    
                    if (currentRecipe.currentIngredient.product!.priceDetails.isSpecial) {
                        Text("$\(currentRecipe.currentIngredient.product!.priceDetails.originalPrice, specifier: "%.2f")").strikethrough()
                        Text("$\(currentRecipe.currentIngredient.product!.priceDetails.salePrice, specifier: "%.2f")").foregroundColor(.red)
                        } else {
                            Text("$\(currentRecipe.currentIngredient.product!.priceDetails.originalPrice, specifier: "%.2f")")
                        }
                }
                    }
                }
                NavigationLink(destination: SearchProductsView(currentRecipe: currentRecipe, searchText: $currentRecipe.currentIngredient.name)) {
                   Text("Search product")
                }.buttonStyle(GrowingButton())
                .environmentObject(currentRecipe)
                HStack {
                    Button("Cancel") {
                        currentRecipe.currentIngredient = Ingredient()
                        withAnimation {
                            editingIngredient.toggle()
                        }
                    }
                    .accessibilityIdentifier("IngredientCancel")
                    .buttonStyle(GrowingButton())
                    .padding()
                    Button("Submit") {
//                        if(currentRecipe.currentIngredient.name != currentRecipe.currentIngredient.product?.name){
//                            currentRecipe.currentIngredient.product = nil
//                        }
                        if isNewIngredient {
                            currentRecipe.ingredients.append(currentRecipe.currentIngredient)
                        } else {
                            let oldIngs = currentRecipe.ingredients
                            currentRecipe.ingredients = []
                            oldIngs.forEach {ing in
                                if ing.id == $currentRecipe.currentIngredient.id {
                                    currentRecipe.ingredients.append(currentRecipe.currentIngredient)
                                } else {
                                    currentRecipe.ingredients.append(ing)
                                }
                            }
                        }
                        currentRecipe.currentIngredient = Ingredient()
                        withAnimation {
                            editingIngredient.toggle()
                        }
                    }
                    .accessibilityLabel("IngredientSubmitButton")
                    .buttonStyle(GrowingButton())
                    .disabled(currentRecipe.currentIngredient.name == "" || currentRecipe.currentIngredient.quantity == 0 || currentRecipe.currentIngredient.quantity == nil)
                    .padding()
                }
            }.frame(width:350, height:510)
                .background(Color(.systemGroupedBackground))
                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                .shadow(color: .gray, radius: 5, x:-9, y: -9)
        }
        .environmentObject(currentRecipe)
        .ignoresSafeArea(.keyboard)

    }
    

}


//struct EditIngredientView_Previews: PreviewProvider {
//    @State var editingIngredient = true
//    static var previews: some View {
//        EditIngredientView(currentRecipe: Recipe(), editingIngredient: $editingIngredient,
//                           isNewIngredient: Ingredient())
//    }
//}
