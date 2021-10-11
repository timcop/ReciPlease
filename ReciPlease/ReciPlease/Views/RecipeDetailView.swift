//
//  RecipeDetailView.swift
//  ProductTest
//
//  Created by Tim Copland on 27/09/21.
//

import SwiftUI

/** Displays a detailed view of the current recipe.
 Features an edit button where the user is able to change the fields for their recipe.
 Ingredients are displayed with IngredientListView, method is displayed with MethodListView.
 Features a toggle style at the bottom for toggling between ingredients/method.
 */
struct RecipeDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var recipeModel: RecipeModel
    @ObservedObject var currentRecipe: Recipe = Recipe()
    @StateObject var selectedRecipe: Recipe
    @State var isIngredient = true
    @State var editingStep = false
    @State var isNewStep = false
    @State var currentStep = Step()
    @State var editingIngredient = false
    @State var isNewIngredient = false
    @State var currentIngredient = Ingredient()
    @State var editingRecipe = false
    @State var newRecipeName = ""
    @State var showingDeleteConfirmation = false
    @State private var showingImagePicker = false
    @State var inputImage: UIImage? = UIImage(named: "defaultImage")
    
    var body: some View {
            ZStack {
                ScrollView(.vertical, showsIndicators: true) {
                    // Picture
                    if (!editingRecipe) {
                        PictureView(uiImage: selectedRecipe.uiImage)
                    } else {
                        ZStack {
                            VStack() {
                                PictureView(uiImage: selectedRecipe.uiImage)
                            }.sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                                ImagePicker(image: self.$inputImage)
                            }
                            Image(systemName: "pencil.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .opacity(0.7)
                                .onTapGesture(){
                                    self.showingImagePicker=true
                                }
                                .allowsHitTesting(!showingDeleteConfirmation)
                        }
                    }
                    
                    // Recipe name, time and servings fields
                    VStack(alignment: .leading){
                        Group {
                            // title
                            if (editingRecipe) {
                                TextField("Recipe Name", text: $newRecipeName, onCommit: {
                                    if newRecipeName.count < 1 {
                                        newRecipeName = selectedRecipe.name
                                    }
                                    selectedRecipe.name = newRecipeName
                                })
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .font(.system(size: 22, weight: .bold))
                                    .padding()
                                HStack {
                                    Spacer()
                                    Image(systemName: "clock.fill")
                                        .foregroundColor(.orange)
                                    TextField("30 Mins", text: $selectedRecipe.cookTime)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    Spacer()
                                    Image(systemName: "person.circle.fill")
                                        .foregroundColor(.orange)
                                    TextField("4 Servings", text: $selectedRecipe.servings)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    Spacer()
                                }
                            } else {
                                Text(selectedRecipe.name)
                                    .font(.system(size: 22, weight: .bold))
                                HStack {
                                    Image(systemName: "clock.fill")
                                        .foregroundColor(.orange)
                                    Text(selectedRecipe.cookTime)
                                    Image(systemName:"person.circle.fill")
                                        .foregroundColor(.orange)
                                    Text(selectedRecipe.servings)
                                }
                                .padding(.vertical)
                            }
                        }
                        .padding(.horizontal)
                        // ingredient/step toggle view
                        
                        
                        if isIngredient {
                            // ingredient list
                            IngredientListView(currentRecipe: selectedRecipe,
                                               isNewIngredient: $isNewIngredient,
                                               editingIngredient: $editingIngredient,
                                               editingRecipe: $editingRecipe)
                        } else {
                            // method list
                            MethodListView(currentRecipe: selectedRecipe,
                                           isNewStep: $isNewStep,
                                           currentStep: $currentStep,
                                           editingStep: $editingStep,
                                           editingRecipe: $editingRecipe)
                        }
                    }
                    
                    if (editingRecipe) {
                        Spacer(minLength: 30)
                        if isIngredient {
                            // add ingredient button
                            Button("Add ingredient") {
                                isNewIngredient = true
                                withAnimation {
                                    editingIngredient.toggle()
                                }
                            }
                            .buttonStyle(GrowingButton())
                            .allowsHitTesting(!showingDeleteConfirmation)
                        } else {
                            // add step button
                            Button("Add Step") {
                                isNewStep = true
                                withAnimation {
                                    editingStep.toggle()
                                }
                            }
                            .buttonStyle(GrowingButton())
                            .allowsHitTesting(!showingDeleteConfirmation)
                        }
                    }
                    Rectangle()
                        .fill(Color.white)
                        .frame(width:screenWidth, height:100)
                        .hidden()
                }
                .blur(radius: showingDeleteConfirmation ? 5 : 0)
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
                            if (!editingRecipe) {

                                selectedRecipe.name = newRecipeName
                            } else {
                                newRecipeName = selectedRecipe.name
                            }
                        }) {
                            Text(editingRecipe ? "Done" : "Edit")
                        }
                    }
                )
                
                
                if editingIngredient {
                    // editIngredientView
                    EditIngredientView(editingIngredient:$editingIngredient,
                                       isNewIngredient: isNewIngredient)
                        .allowsHitTesting(!showingDeleteConfirmation)

                }
                
                
                if editingStep {
                    //editStepView
                    EditStepView(editingStep:$editingStep,
                                 isNewStep: isNewStep,
                                 currentStep: $currentStep)
                        .allowsHitTesting(!showingDeleteConfirmation)

                }
                
                
                if showingDeleteConfirmation {
                    Color.white
                        .onTapGesture {
                            withAnimation {
                                showingDeleteConfirmation.toggle()
                            }
                        }
                        .ignoresSafeArea()
                        .opacity(0.01)
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

                Toggle(isOn: $isIngredient, label: {})
                    .toggleStyle(ToolbarToggleStyle())
                    .allowsHitTesting(!showingDeleteConfirmation)

            }.environmentObject(selectedRecipe)
    }
    
    
    /** When an image is selected, this selected
     image is loaded into the slected recipes image field.*/
    func loadImage() {
        guard let inputImage = inputImage else { return }
        if (inputImage != UIImage(named: "defaultImage")) {
            selectedRecipe.uiImage = inputImage
        }
    }
}



/** Has two buttons for ingredients and method.
 When either is pressed a horizontal bar moves below the button showing it's active,
 the parent view listens to $isIngredient and displays either the IngredientListView or MethodListView
 depending on it's value.
 */
struct ToolbarToggleStyle: ToggleStyle {
    @Environment(\.colorScheme) var colorScheme

    func makeBody(configuration: Configuration) -> some View {
        return
            VStack{
                Spacer()
                ZStack {
                    Rectangle()
                        .fill((colorScheme == .dark) ? Color.black : Color.white)
                        .frame(width: screenWidth, height: 105)
                        .offset(y:10)
                    VStack{
                        HStack {
                            Spacer()
                            VStack{
                                Image("ingredients")
                                    .resizable()
                                    .frame(width:30, height:30)

                                Text("Ingredients")
                                    .font(.system(size: 12, weight: configuration.isOn ? .bold : .regular))
                            }
                            .padding()
                            .onTapGesture {
                                withAnimation {
                                    configuration.isOn = true
                                }
                            }
                            .accessibilityAddTraits(.isButton)
                            .accessibilityIdentifier("IngredientToggle")
                            Spacer()
                            VStack{
                                Image(systemName: "list.bullet")
                                    .resizable()
                                    .frame(width:23, height:23)

                                Text("Method")
                                    .font(.system(size: 12, weight: configuration.isOn ? .regular : .bold))
                            }
                            .padding()
                            .offset(y:4)
                            .onTapGesture {
                                withAnimation {
                                    configuration.isOn = false
                                }
                            }
                            .accessibilityAddTraits(.isButton)
                            .accessibilityIdentifier("MethodToggle")
                            Spacer()

                        }
                        .offset(y:-10)
                        Rectangle()
                            .fill(Color.orange)
                            .frame(width: 110, height: 3)
                            .offset(x: configuration.isOn ? -(screenWidth)/5.2 : screenWidth/4.8, y:-25)
                    }
                }
            }
            .edgesIgnoringSafeArea([.bottom])
    }
}



struct RecipeDetailView_Previews: PreviewProvider {
    @State static var isIngredient = true
    static var previews: some View {
        Group {
            RecipeDetailView(selectedRecipe: Recipe()).environmentObject(RecipeModel())
        }
    }
}
