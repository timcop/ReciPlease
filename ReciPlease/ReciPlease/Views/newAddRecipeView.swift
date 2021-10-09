//
//  newAddRecipeView.swift
//  ReciPlease
//
//  Created by Tim Copland on 29/09/21.
//

import SwiftUI

//let screenSize: CGRect = UIScreen.main.bounds
//let screenWidth = screenSize.width
//let screenHeight = screenSize.height

struct newAddRecipeView: View {
    // Inherited
    @ObservedObject var currentRecipe: Recipe = Recipe()
    @EnvironmentObject var recipeModel: RecipeModel
    @Environment(\.presentationMode) var presentation
    
    @State var isIngredient = true
    @State var addingIngredient = false
//    @State var currentIngredient = Ingredient()
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
                                        .frame(width: 300, height:300)
                                        .scaledToFit()
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
                            // title
                            TextField("Recipe Name", text: $currentRecipe.name)
                                .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
                                .focused($isTextFieldFocused)
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
                                }.buttonStyle(GrowingButton())
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
                                }.buttonStyle(GrowingButton())
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
                            .frame(width:screenWidth, height:300)
                            .hidden()
                    }
                    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: self.$inputImage)
                    }
                }
            }
            .blur(radius: (addingIngredient || addingStep) ? 5 : 0)
            .allowsHitTesting(!(addingIngredient || addingStep))
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ZStack{
                        Rectangle()
                            .frame(width: screenWidth, height:100)
                            .offset(y:40)
                            .hidden()
                        if (!isTextFieldFocused) {
                            HStack {
                                Spacer()
                                Button("Cancel") {
                                    // work around, can't reinitialise currentIngredient how i wanted to
                                    currentRecipe.ingredients = []
                                    currentRecipe.name = ""
                                    currentRecipe.method = []
                                    currentRecipe.cookTime = "10 min"
                                    currentRecipe.numIngredients = "10 ingredients"
                                    currentRecipe.currentIngredient = Ingredient()
                                    self.presentation.wrappedValue.dismiss()
                                }
                                .buttonStyle(GrowingButton())
                                
                                Spacer()
                                
                                Button("Submit") {
                                    currentRecipe.uiImage = inputImage!
                                    recipeModel.recipes.append(currentRecipe)
                                    // save to memory
                                    recipeModel.storeRecList(recs: recipeModel.recipes)
                                    self.presentation.wrappedValue.dismiss()
                                }
                                .buttonStyle(GrowingButton())
                                .disabled(currentRecipe.ingredients.count < 1 || currentRecipe.name == "")
                                Spacer()
                            }
                            .offset(y:30)
                        }
                    }
                    Spacer()
                }
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

        }
        .environmentObject(currentRecipe)

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
