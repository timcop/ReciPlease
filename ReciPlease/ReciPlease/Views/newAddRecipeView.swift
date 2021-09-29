//
//  newAddRecipeView.swift
//  ReciPlease
//
//  Created by Tim Copland on 29/09/21.
//

import SwiftUI

struct newAddRecipeView: View {
    // Inherited
    @ObservedObject var currentRecipe: Recipe = Recipe()
    @EnvironmentObject var recipeModel: RecipeModel
    @Environment(\.presentationMode) var presentation
    
    @State var isIngredient = true
    @State var addingIngredient = false
    @State var selectedUnit = Unit.each
    @State var currentIngredient: Ingredient = Ingredient()

    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    Group {
                        // title
                        TextField("Recipe Name", text: $currentRecipe.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                    }
                    .padding(.horizontal)
                    
                    // ingredient/step toggle view
                    Toggle(isOn: $isIngredient, label: {})
                        .toggleStyle(IngredientMethodToggleStyle())
                    
                    if isIngredient {
                        // ingredient list
                        HStack {
                            Spacer()
                            Button("Add ingredient") {
                                withAnimation {
                                    addingIngredient.toggle()
                                }
                            }
                            Spacer()
                        }.padding(.top)
                        IngredientListView(ingredients: currentRecipe.ingredients)
                    } else {
                        HStack {
                            Spacer()
                            Button("Add Step") {
                            //action
                            }
                            Spacer()
                        }.padding(.top)
                        MethodListView(method: currentRecipe.method)
                        // steps list
                    }
                }
            }
            if addingIngredient {

                ZStack{
                    Color.black
                        .ignoresSafeArea()
                        .opacity(0.4)
                    VStack {
                        Text("Item Details").padding()

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
                        HStack {
                            NavigationLink(destination: SearchProductsView(ingProd: $currentIngredient.product, searchText: $currentIngredient.name)) {
                               Text("Search product")
                            }.padding()
                            Button("SUBMIT") {
                                currentRecipe.ingredients.append(currentIngredient)
                                currentIngredient = Ingredient()
                                withAnimation {
                                    addingIngredient.toggle()
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
    }
}


struct addIngredientCard: View {
    var body: some View {
        VStack{
            Rectangle()
                .fill(Color.black)
                .frame(width: 200, height: 200)
                .transition(.opacity)
                .offset(y: 200)
                .zIndex(2)
        }.background(Color.gray)
    }
}

struct newAddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        newAddRecipeView()
    }
}
