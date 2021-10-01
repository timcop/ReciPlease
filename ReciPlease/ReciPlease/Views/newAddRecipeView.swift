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
    @State var addingStep = false
    @State var currentStep: Step = Step()
    @State var stepPlaceholder = "Preheat oven to 180ºC..."
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
                                withAnimation {
                                    addingIngredient.toggle()
                                }
                            }
                            Spacer()
                        }.padding(.top)
                        IngredientListView(ingredients: currentRecipe.ingredients)
                    } else {
                        // steps list
                        HStack {
                            Spacer()
                            Button("Add Step") {
                                withAnimation {
                                    addingStep.toggle()
                                }
                            }
                            Spacer()
                        }.padding(.top)
                        MethodListView(method: currentRecipe.method)
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

                ZStack{
                    Color.black
                        .onTapGesture {
                            currentIngredient = Ingredient()
                            withAnimation {
                                addingIngredient.toggle()
                            }
                        }
                        .ignoresSafeArea()
                        .opacity(0.4)
                    VStack(spacing: 0){
                        Text("Item Details").padding(.top, 20)

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
                        NavigationLink(destination: SearchProductsView(ingProd: $currentIngredient.product, searchText: $currentIngredient.name)) {
                           Text("Search product")
                        }
                        HStack {
                            Button("Cancel") {
                                currentIngredient = Ingredient()
                                withAnimation {
                                    addingIngredient.toggle()
                                }
                            }.padding()
                            Button("Submit") {
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
            
            if addingStep {
                ZStack {
                    Color.black
                        .onTapGesture {
                            currentIngredient = Ingredient()
                            withAnimation {
                                addingStep.toggle()
                            }
                        }
                        .ignoresSafeArea()
                        .opacity(0.4)
                    VStack(spacing: 20) {
                        Text("Step \(currentRecipe.method.count+1)").padding(.top, 20)
                        ZStack {
                        if currentStep.string.isEmpty {
                            TextEditor(text:$stepPlaceholder)
                                .font(.body)
                                .foregroundColor(.gray)
                                .cornerRadius(8)
                                .disabled(true)
                                .padding()
                            }
                            TextEditor(text: $currentStep.string)
                                .font(.body)
                                .opacity(currentStep.string.isEmpty ? 0.25 : 1)
                                .cornerRadius(8)
                                .padding()
                        }
                        HStack {
                            Button("Cancel") {
                                currentStep = Step()
                                withAnimation {
                                    addingStep.toggle()
                                }
                            }.padding()
                            Button("Submit") {
                                currentRecipe.method.append(currentStep)
                                currentStep = Step()
                                withAnimation {
                                    addingStep.toggle()
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
