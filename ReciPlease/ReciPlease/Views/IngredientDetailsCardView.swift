//
//  IngredientDetailsCardView.swift
//  ReciPlease
//
//  Created by Tim Copland on 29/09/21.
//
//
//import SwiftUI
//
//struct IngredientDetailsCardView: View {
//    @State var currentIngredient: Ingredient = Ingredient()
//    @State var selectedUnit = Unit.each
//    var body: some View {
//        ZStack{
//            VStack {
//                Form{
//                    Text("Item Details")
//                    TextField("Name", text: $currentIngredient.name)
//
//                    Picker(selection: $selectedUnit, label:Text("Unit")) {
//                        Text("Each").tag(Unit.each)
//                        Text("Grams").tag(Unit.g)
//                        Text("Kg").tag(Unit.kg)
//                        Text("mL").tag(Unit.ml)
//                        Text("L").tag(Unit.l)
//                        Text("Handfull").tag(Unit.handfull)
//                        Text("Bunch").tag(Unit.bunch)
//                    }
//                
//                    TextField("Quantity", text:$currentIngredient.quantity)
//
//                }
//                HStack {
//                    NavigationLink(destination: SearchProductsView(ingProd: $currentIngredient.product, searchText: $currentIngredient.name)) {
//                       Text("Search product")
//                    }.padding()
//                    Button("SUBMIT") {
//                        currentRecipe.ingredients.append(currentIngredient)
//                        currentIngredient = Ingredient()
//                        withAnimation {
//                            addingIngredient.toggle()
//                        }
//                    }.padding()
//                }
//            }.frame(width:350, height:360)
//                .background(Color(.systemGroupedBackground))
//                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
//                .shadow(color: .gray, radius: 5, x:-9, y: -9)
//        }
//    }
//}
//
//struct IngredientDetailsCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        IngredientDetailsCardView()
//    }
//}
