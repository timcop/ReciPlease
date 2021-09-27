//
//  AddIngredientView.swift
//  ProductTest
//
//  Created by Tim Copland on 27/09/21.
//

import SwiftUI


struct AddIngredientView: View {
    
    @Binding var ingredients: [Ingredient]
    @State var newIngredient: Ingredient = Ingredient()
    @State var name: String = ""
    @State var quantity:String = ""
    @State private var selectedUnit = Unit.each
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Add Ingredient").font(.largeTitle)
            Form {
                Section(header: Text("DETAILS")) {
                    TextField("Name", text: $newIngredient.name)
                    
                    Picker(selection: $selectedUnit, label:Text("Unit")) {
                        Text("Each").tag(Unit.each)
                        Text("Grams").tag(Unit.g)
                        Text("Kg").tag(Unit.kg)
                        Text("mL").tag(Unit.ml)
                        Text("L").tag(Unit.l)
                        Text("Handfull").tag(Unit.handfull)
                        Text("Bunch").tag(Unit.bunch)
                    }
                    TextField("Quantity", text:$newIngredient.quantity)
                }
            }
        
            NavigationLink(destination: SearchProductsView(ingProd: $newIngredient.product, searchText: $newIngredient.name)) {
                Text("Search product")
            }
            Spacer()

            Form {
                Section {
                    Button("Submit") {
                        newIngredient.unit = selectedUnit
                        ingredients.append(newIngredient)
                        
                        self.presentation.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}

//struct AddIngredientView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddIngredientView()
//    }
//}
