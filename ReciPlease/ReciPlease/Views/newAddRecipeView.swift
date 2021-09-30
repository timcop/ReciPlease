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
    @State var currentIngredient = Ingredient()
    @State var isNewIngredient = true
    @State var addingStep = false
    @State var currentStep = Step()
    @State var isNewStep = true

    
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
                                isNewIngredient = true
                                withAnimation {
                                    addingIngredient.toggle()
                                }
                            }
                            Spacer()
                        }.padding(.top)
                        IngredientListView(recipe: currentRecipe,
                                           ingredients: currentRecipe.ingredients,
                                           isNewIngredient: $isNewIngredient,
                                           currentIngredient: $currentIngredient,
                                           editingIngredient: $addingIngredient)
                    } else {
                        // steps list
                        HStack {
                            Spacer()
                            Button("Add Step") {
                                isNewStep = true
                                withAnimation {
                                    addingStep.toggle()
                                }
                            }
                            Spacer()
                        }.padding(.top)
                        MethodListView(recipe: currentRecipe,
                                       method: currentRecipe.method,
                                       isNewStep: $isNewStep,
                                       currentStep: $currentStep,
                                       editingStep: $addingStep)
                    }
                    HStack {
                        Spacer()
                        Button("Submit Recipe") {
                            recipeModel.recipes.append(currentRecipe)
                            self.presentation.wrappedValue.dismiss()
                        }
                        Spacer()
                    }.padding()
                }
            }
            if addingIngredient {
                EditIngredientView(editingIngredient: $addingIngredient,
                                   isNewIngredient: isNewIngredient,
                                   currentRecipe: currentRecipe,
                                   currentIngredient: $currentIngredient)
            }
            
            if addingStep {
                EditStepView(editingStep: $addingStep,
                             isNewStep: isNewStep,
                             currentRecipe: currentRecipe,
                             currentStep: $currentStep)
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
