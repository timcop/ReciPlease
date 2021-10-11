//
//  newAddRecipeView.swift
//  ReciPlease
//
//  Created by Tim Copland on 29/09/21.
//

import SwiftUI

/** newAddRecipeView creates a View for which to add recipes.
 Lets users: Enter an image by calling ImagePicker, enter an ingredient/step
 by calling EditIngredientView and EditStepView respectively, displays the
 current ingredients and steps by calling IngredientListView and MethodListView respectively.
 
 Features a toggleView ToolbarToggleStyle() at the bottom of the screen to switch between
 ingredient and method.
 
 */
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
    @State var inputImage: UIImage? = UIImage(named: "LogoNoWords")
    @State var image: Image? = Image("LogoNoWords")
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
                            // Tappable shows ImagePicker
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .opacity(0.7)
                                .onTapGesture(){
                                    self.showingImagePicker=true
                                }
//                        .onTapGesture{
//                            self.showingImagePicker=true
                        }
                        
                        Group {
                            VStack {
                                
                                // title field
                                TextField("Recipe Name", text: $currentRecipe.name)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .font(.system(size: 22, weight: .bold))
                                    .padding()
                                    .focused($isTextFieldFocused)
                                    .accessibilityLabel("RecipeNameField")
                                
                                // timer and servings fields
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
                        // Some more wiggle room at bottom of scroll view
                        Rectangle()
                            .fill(Color.white)
                            .frame(width:screenWidth, height:100)
                            .hidden()
                    }
                    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: self.$inputImage)
                    }
                }
                // navigation buttons
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(
                    leading:
                        // Cancel button removes currentRecipe and navigates back to ContentView
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
                        // Submit button appends the currentRecipe to recipeModel.recipes
                        Button("Submit") {
                            currentRecipe.uiImage = inputImage!
                            recipeModel.recipes.append(currentRecipe)
                            self.presentation.wrappedValue.dismiss()
                        }
                        .accessibilityLabel("SubmitRecipe")
                        // Must meet these conditions before submitting
                        .disabled(currentRecipe.ingredients.count < 1
                                  || currentRecipe.cookTime == ""
                                  || currentRecipe.servings == ""
                                  || currentRecipe.name == ""
                                  || addingStep
                                  || addingIngredient
                                 )
                    )
            }
            .blur(radius: (addingIngredient || addingStep) ? 5 : 0) // blur background if addingIngredient/step
            .allowsHitTesting(!(addingIngredient || addingStep))
            
            // EditIngredientView()
            if addingIngredient {
                EditIngredientView(editingIngredient: $addingIngredient,
                                   isNewIngredient: isNewIngredient)
                    .environmentObject(currentRecipe)

            }
            
            // EditStepView()
            if addingStep {
                EditStepView(editingStep: $addingStep,
                             isNewStep: isNewStep,
                             currentStep: $currentStep)
            }
            // Toggle ingredient/steps
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
