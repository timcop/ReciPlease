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
    @State var isNewIngredient = true
    @State var addingStep = false
    @State var currentStep = Step()
    @State var isNewStep = true
    @State var editingRecipe = true
    @State private var showingImagePicker = false
    @State var inputImage: UIImage? = UIImage(named: "recipe_default")
    @State var image: Image? = Image("recipe_default")
    @FocusState private var isTextFieldFocused: Bool


    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: true) {
                    VStack(alignment: .leading) {
                        ZStack{
                            HStack{
                                Spacer()
                                if image != nil {
                                    image?
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 300, height:300)
                                        .cornerRadius(15)
                                        .clipped()
                                        
                                } else {
                                    Text("Tap to select a picture")
                                        .foregroundColor(.white)
                                        .font(.headline)
                                }
                                Spacer()
                            }
                            
                        }.onTapGesture{
                            self.showingImagePicker=true
                        }
                        
                        Group {
                            VStack {
                                // title
                                TextField("Recipe Name", text: $currentRecipe.name)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .font(.system(size: 22, weight: .bold))
                                    .padding()
                                    .focused($isTextFieldFocused)
                                    .accessibilityLabel("RecipeNameField")

                                HStack {
                                    Spacer()
                                    Image(systemName: "timer")
                                        .foregroundColor(.green)
                                    TextField("30 Mins", text: $currentRecipe.cookTime)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .focused($isTextFieldFocused)
                                        .accessibilityLabel("RecipeTimeField")

                                    Spacer()
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.green)
                                    TextField("4 Servings", text: $currentRecipe.servings)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .focused($isTextFieldFocused)
                                        .accessibilityLabel("RecipeServingsField")

                                    Spacer()
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        
                        
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
                                .buttonStyle(GrowingButton())
                                .accessibilityLabel("AddIngredient")
                                Spacer()
                            }.padding(.top)
                            IngredientListView( currentRecipe: currentRecipe,
                                               isNewIngredient: $isNewIngredient,
                                               editingIngredient: $addingIngredient,
                                               editingRecipe: $editingRecipe)
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
                                .buttonStyle(GrowingButton())
                                .accessibilityLabel("AddStep")
                                Spacer()
                            }.padding(.top)
                            MethodListView(currentRecipe: currentRecipe,
                                           isNewStep: $isNewStep,
                                           currentStep: $currentStep,
                                           editingStep: $addingStep,
                                           editingRecipe: $editingRecipe)
                        }
                        Spacer()
                        Rectangle()
                            .fill(Color.white)
                            .frame(width:screenWidth, height:100)
                            .hidden()
                    }
                    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: self.$inputImage)
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading:
                        Button(action: {
                            currentRecipe.ingredients = []
                            currentRecipe.name = ""
                            currentRecipe.method = []
                            currentRecipe.cookTime = ""
                            currentRecipe.servings = ""
                            currentRecipe.currentIngredient = Ingredient()
                            self.presentation.wrappedValue.dismiss()
                        }) {
                            Text("Cancel")
                                .accessibilityLabel("CancelRecipe")
                                .foregroundColor(.red)
                        },
                    
                    trailing:
                        Button("Submit") {
                            currentRecipe.uiImage = inputImage!
                            recipeModel.recipes.append(currentRecipe)
                            self.presentation.wrappedValue.dismiss()
                        }
                        .accessibilityLabel("SubmitRecipe")
                        .disabled(currentRecipe.ingredients.count < 1
                                  || currentRecipe.cookTime == ""
                                  || currentRecipe.servings == ""
                                  || currentRecipe.name == ""
                                  || addingStep
                                  || addingIngredient
                                 )
                    )
            }
            .blur(radius: (addingIngredient || addingStep) ? 5 : 0)
            .allowsHitTesting(!(addingIngredient || addingStep))

            if addingIngredient {
                EditIngredientView(editingIngredient: $addingIngredient,
                                   isNewIngredient: isNewIngredient)
                    .environmentObject(currentRecipe)

            }
            
            if addingStep {
                EditStepView(editingStep: $addingStep,
                             isNewStep: isNewStep,
                             currentStep: $currentStep)
            }
            Toggle(isOn: $isIngredient, label: {})
                .toggleStyle(ToolbarToggleStyle())
        }
        .environmentObject(currentRecipe)

    }
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct newAddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        newAddRecipeView()
    }
}
