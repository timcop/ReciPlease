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
    @StateObject var selectedRecipe: Recipe
    @State var isIngredient = true
    @State var editingStep = false
    @State var isNewStep = false
    @State var currentStep = Step()
    @State var editingIngredient = false
    @State var isNewIngredient = false
    @State var currentIngredient = Ingredient()
    @State var editingRecipe = false
    @State var showingDeleteConfirmation = false
    
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
                            IngredientListView(currentRecipe: selectedRecipe,
                                               isNewIngredient: $isNewIngredient,
                                               editingIngredient: $editingIngredient,
                                               editingRecipe: $editingRecipe)
                        } else {
                            MethodListView(currentRecipe: selectedRecipe,
                                           isNewStep: $isNewStep,
                                           currentStep: $currentStep,
                                           editingStep: $editingStep,
                                           editingRecipe: $editingRecipe)
                            // steps list
                        }
                    }
                    if (editingRecipe) {
                        Spacer(minLength: 30)
                        if isIngredient {
                            Button("Add ingredient") {
                                isNewIngredient = true
                                withAnimation {
                                    editingIngredient.toggle()
                                }
                            }.buttonStyle(GrowingButton())
                        } else {
                            Button("Add Step") {
                                isNewStep = true
                                withAnimation {
                                    editingStep.toggle()
                                }
                            }.buttonStyle(GrowingButton())
                        }
                    }

                }
                //.blur(radius: showingDeleteConfirmation ? 5 : 0)
                .navigationBarItems(trailing:
                    HStack {
                        if (editingRecipe) {
                            Button(action: {
                                showingDeleteConfirmation.toggle()
                            }) {
                                Text("Delete")
                                    .foregroundColor(Color.red)
                            }
                        }
                        Button(action: {
                            editingRecipe.toggle()
                        }) {
                            Text(editingRecipe ? "Done" : "Edit")
                        }
                    }
                )
                if editingIngredient {
                    EditIngredientView(editingIngredient:$editingIngredient,
                                       isNewIngredient: isNewIngredient)
                }
                if editingStep {
                    EditStepView(editingStep:$editingStep,
                                 isNewStep: isNewStep,
                                 currentStep: $currentStep)
                }
                if showingDeleteConfirmation {
                    Color.black
                        .onTapGesture {
                            withAnimation {
                                showingDeleteConfirmation.toggle()
                            }
                        }
                        .ignoresSafeArea()
                        .opacity(0.4)
                    ZStack {
                        
                        VStack {
                            Spacer()
                            Text("Are you sure you want\nto delete this recipe?")
                                .font(.headline)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                            Spacer()
                            HStack {
                                Spacer()
                                Button(action: {
                                    showingDeleteConfirmation.toggle()
                                }) {
                                    Text("Cancel")
                                }
                                Spacer()
                                Button(action: {
                                    if let index = $recipeModel.recipes.firstIndex(where: {$0.id == selectedRecipe.id}) {
                                        recipeModel.recipes.remove(at: index)
                                    }
                                }) {
                                    Text("Delete")
                                        .foregroundColor(.red)
                                }
                                Spacer()
                            }
                            .padding(.bottom, 20)
                        }
                    }
                    .frame(width:300, height:210)
                    .background(Color(.systemGroupedBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                    .shadow(color: .gray, radius: 5, x:-9, y: -9)
                }
            }.environmentObject(selectedRecipe)    }
    
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
                        .offset(x: configuration.isOn ? 16 : 140) 
                    
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
