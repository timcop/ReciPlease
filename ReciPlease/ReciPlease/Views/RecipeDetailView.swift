//
//  RecipeDetailView.swift
//  ProductTest
//
//  Created by Tim Copland on 27/09/21.
//

import SwiftUI

struct RecipeDetailView: View {
//    let recipe: Recipe
    @EnvironmentObject var recipeModel: RecipeModel
    @ObservedObject var selectedRecipe: Recipe
    @State var isIngredient = true
    @State var editingStep = false
    @State var isNewStep = false
    @State var currentStep = Step()
    @State var editingIngredient = false
    @State var isNewIngredient = false
    @State var currentIngredient = Ingredient()
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    PictureView(uiImage: (selectedRecipe.uiImage!))
                    Group {
                        // title
                        Text(selectedRecipe.name).font(.system(size: 22, weight: .bold))
                        
                        //info view
                        HStack(spacing: 32) {
                            HStack(spacing: 12) {
                                Image(systemName: "clock")
                                    .foregroundColor(.green)
                                
                                Text(selectedRecipe.cookTime)
                                Image(systemName:"pencil")
                                    .foregroundColor(.green)
                                Text(String(selectedRecipe.ingredients.count) + " ingredients")
                            }
                        }
                        .padding(.vertical)
                    }
                    .padding(.horizontal)
                    // ingredient/step toggle view
                    Toggle(isOn: $isIngredient, label: {})
                        .toggleStyle(IngredientMethodToggleStyle())
                    
                    if isIngredient {
                        // ingredient list
                        IngredientListView(recipe: selectedRecipe,
                                           ingredients: selectedRecipe.ingredients,
                                           isNewIngredient: $isNewIngredient,
                                           currentIngredient: $currentIngredient,
                                           editingIngredient: $editingIngredient)
                    } else {
                        MethodListView(recipe: selectedRecipe,
                                       method: selectedRecipe.method,
                                       isNewStep: $isNewStep,
                                       currentStep: $currentStep,
                                       editingStep: $editingStep)
                        // steps list
                    }
                }
            }
            if editingIngredient {
                EditIngredientView(editingIngredient:$editingIngredient,
                                   isNewIngredient: isNewIngredient,
                                   currentRecipe: selectedRecipe,
                                   currentIngredient: $currentIngredient)
            }
            if editingStep {
                EditStepView(editingStep:$editingStep,
                             isNewStep: isNewStep,
                             currentRecipe: selectedRecipe,
                             currentStep: $currentStep)
            }
        }
    }
    
}

struct IngredientMethodToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return
            VStack(alignment: .leading) {
                HStack {
                    Text("INGREDIENTS")
                        .font(.system(size:16, weight: configuration.isOn ? .bold : .regular))
                        .frame(width: 110)
                        .fixedSize()
                        .padding(4)
                        .padding(.leading, 12)
                        .onTapGesture {
                            withAnimation {
                                configuration.isOn = true
                            }
                        }
                    
                    Text("METHOD")
                        .font(.system(size:16, weight: configuration.isOn ? .regular : .bold))
                        .padding(4)
                        .onTapGesture {
                            withAnimation {
                                configuration.isOn = false
                            }
                        }
                }
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 3)
                    
                    Rectangle()
                        .fill(Color.green)
                        .frame(width: configuration.isOn ? 110:70, height: 3)
                        .offset(x: configuration.isOn ? 16 : 140) // 0: 115
                    
                }
            }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var isIngredient = true
    static var previews: some View {
        Group {
            RecipeDetailView(selectedRecipe: Recipe())
        }
    }
}
