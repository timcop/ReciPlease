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
    @State private var showingImagePicker = false
    @State var inputImage: UIImage? = UIImage(named: "recipe_default")
    @State var image: Image? = Image("recipe_default")

    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    ZStack{
                    Rectangle()
                            .fill(Color.white)
                    if image != nil {
                        image?
                            .resizable()
                            .frame(width: 300, height:300)
                            .scaledToFit()
                            .cornerRadius(15)
                            
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                    
                    }.onTapGesture{
                        self.showingImagePicker=true
                    }
                    
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
                            currentRecipe.uiImage = inputImage!
                            recipeModel.recipes.append(currentRecipe)
                            self.presentation.wrappedValue.dismiss()
                        }
                        Spacer()
                    }.padding()
                }
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$inputImage)
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
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
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
