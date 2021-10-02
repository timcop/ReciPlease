//
//  AddRecipeView.swift
//  ProductTest
//
//  Created by Tim Copland on 23/09/21.
//
//import SwiftUI
//
//let screenSize: CGRect = UIScreen.main.bounds
//let screenWidth = screenSize.width
//let screenHeight = screenSize.height
//
//struct PictureView: View {
//    var imgName: String
//    var body: some View {
//
//        Image(imgName)
//            .resizable()
//            .aspectRatio(contentMode: .fit)
//            .frame(width: screenWidth, height: screenWidth)
//    }
//}
//
//struct AddRecipeView: View {
//    @ObservedObject var currentRecipe: Recipe = Recipe()
//    @EnvironmentObject var recipeModel: RecipeModel
//    @Environment(\.presentationMode) var presentation
//
//
//    var body: some View {
//        ScrollView {
//            PictureView(imgName: "stirFry")
//
//            VStack() {
//                Text("Add Recipe").font(.largeTitle)
//    //                .offset(y: -50)
//                TextField("Recipe Name", text: $currentRecipe.name)
//                    .textFieldStyle(RoundedBorderTextFieldStyle()).padding()
//                Text("Ingredients").font(.headline)
//
//
//                NavigationLink(destination: AddIngredientView(ingredients: $currentRecipe.ingredients)) {
//                    Text("Add an ingredient")
//                        .padding(.all)
//                }
//                ForEach(currentRecipe.ingredients) { ing in
//                    VStack {
//                        HStack {
//                            Text(ing.name).font(.title3).bold().italic()
//                        }
//                        HStack {
//                            Text("Quantity: " + ing.quantity).font(.body)
//                            Text("Unit: " + ing.unit.rawValue).font(.body)
//                        }
//                        if let prod = ing.product {
//                            Text(prod.name)
//                        }
//                        Divider()
//                    }
//                }
//                Spacer()
//                Button("Submit") {
//                    recipeModel.recipes.append(currentRecipe)
//                    self.presentation.wrappedValue.dismiss()
//
//                }
//            }
//        }
//    }
//
//}
//
//
//struct AddRecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRecipeView()
//            .padding()
//.previewInterfaceOrientation(.portrait)
//    }
//}
