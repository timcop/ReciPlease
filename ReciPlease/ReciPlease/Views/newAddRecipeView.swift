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
    @State private var showingImagePicker = false
    @State var inputImage: UIImage? = UIImage(named: "recipe_default")
    @State var image: Image? = Image("recipe_default")

    
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
                        Spacer()
    //                    .padding()
                        Rectangle()
                            .fill(Color.white)
                            .frame(width:screenWidth, height:300)
                    }
//                    .frame(minHeight: geometry.size.height + 500)
                    .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                        ImagePicker(image: self.$inputImage)
                    }
                }
//                .frame(height: geometry.size.height + 500)
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    ZStack{
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: screenWidth, height:100)
                            .offset(y:40)
                            
                        Button("Submit Recipe") {
                            currentRecipe.uiImage = inputImage!
                            recipeModel.recipes.append(currentRecipe)
                            self.presentation.wrappedValue.dismiss()
                        }
                        .buttonStyle(GrowingButton())
                        .offset(y:30)
                    }
                    Spacer()
                }
            }
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
