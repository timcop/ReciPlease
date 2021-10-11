//
//  ContentView.swift
//  ProductTest
//
//  Created by Tim Copland on 22/09/21.
//

import SwiftUI

/** ContentView is the root view of the View heirarchy.
 Features a horizontal scrolling list of recipes with a search bar,
 a random button which takes you to a random RecipeDetailView()
 and a "Add recipe" button which navigates to "newAddRecipeView()"
 
 */
struct ContentView: View {
    @EnvironmentObject var recipeModel:RecipeModel
    @State var searchText: String = ""
    @State var searching = false
    @State var randomRecipeIdx: Int = 0
    @State var loadedRecipes: [Recipe] = []
    
    var body: some View {
        NavigationView {
            VStack {
                if recipeModel.recipes.count < 1 {
                    // No recipes
                    Spacer()
                    Text("It's looking empty in here...")
                        .padding(.bottom, 8)
                        .font(.callout)
                        .foregroundColor(.gray)
                    Text("Add a recipe!")
                        .font(.callout)
                        .foregroundColor(.gray)
                } else {
                    // Search bar
                    SearchBar(searchText: $searchText, searching: $searching)
                                .toolbar {
                                    if searching {
                                        Button("Cancel") {
                                            searchText = ""
                                            withAnimation {
                                                searching = false
                                                UIApplication.shared.dismissKeyboard()
                                            }
                                        }
                                    }
                                }
                    // Recipe Scroll view
                    RecipeCardScrollView(searchText: $searchText)
                }
                Spacer()
                // Buttons
                HStack {
                    Spacer()
                    
                    // Random recipe
                    NavigationLink(destination: RandomRecipeView(recipes: recipeModel.recipes, idx: randomRecipeIdx)) {
                        Text("Random recipe")
                            .onAppear() {
                                if recipeModel.recipes.count < 1 {
                                    return
                                }
                                randomRecipeIdx = Int.random(in: 0..<recipeModel.recipes.count)
                            }
                            .accessibilityIdentifier("RandomButton")
                    }
                    .buttonStyle(GrowingButton())
                    .disabled(recipeModel.recipes.count < 1)
                    
                    Spacer()
                    
                    // Add recipe button
                    NavigationLink(destination: newAddRecipeView()) {
                        Text("Add a recipe")
                            .accessibilityLabel("AddRecipe")
                    }.buttonStyle(GrowingButton())
                    
                    Spacer()
                }.offset(y:-20)
            }
            .navigationTitle("ReciPlease")
            .ignoresSafeArea(.keyboard)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(recipeModel)
    }
}

/** Navigates to RecipeDetailView with a random recipe.
 */
struct RandomRecipeView: View {
    var recipes: [Recipe]
    var idx: Int
    var body: some View {
        RecipeDetailView(selectedRecipe: recipes[idx])
    }
}

/** Shows the recipes in a horizontal scrolling list with searchText
 to filter out recipes if desired. Tapping on a recipe will take you to the RecipeDetailView() of that
 recipe.
 */
struct RecipeCardScrollView: View {
    @Binding var searchText: String
    @EnvironmentObject var recipeModel: RecipeModel
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 50) {
                ForEach(recipeModel.recipes.filter {$0.name.contains(searchText) || searchText.isEmpty}) { recipe in
                    GeometryReader { geometry in
                        NavigationLink(destination: RecipeDetailView(selectedRecipe: recipe)) {
                            ZStack {
                                Image(uiImage: recipe.uiImage)
                                    .RecipeCardImageModifier()
                                Text(recipe.name)
                                    .modifier(RecipeCardTextViewModifier())
                            }
                        }
                        .accessibilityAddTraits(.isButton)
                        .accessibilityIdentifier("Recipe")
                        .rotation3DEffect(Angle(degrees:
                            Double(geometry.frame(in: .global).minX - 40) / -10
                               ), axis: (x: 0, y: 100.0, z: 0))
                    }
                    .frame(width:230, height: 350)
                }
                Rectangle()
                    .frame(width:30, height:350)
                    .hidden()
                    
            }
            .padding(40)
        }
        .environmentObject(recipeModel)
        .frame(height:100)
        .offset(y:180)
        .gesture(DragGesture()
                     .onChanged({ _ in
                         UIApplication.shared.dismissKeyboard()
                     })
         )
    }
}

/** Modifies the text box found in RecipeCardScrollView()  */
struct RecipeCardTextViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.white)
            .frame(width: 250, height: 40)
            .background(Color.black)
            .clipShape(Rectangle())
            .cornerRadius(15)
            .offset(y:120)
    }
}

/** Modfies the image in RecipeCardScrollView() */
extension Image {
    func RecipeCardImageModifier() -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width:300, height:300)
            .cornerRadius(15)
            .clipped()
            .shadow(color: .gray, radius: 5, x:0, y: 3)
    }
}

/** Growing button ButtonStyle */
struct GrowingButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(isEnabled ? Color.orange: Color.gray)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

extension UIApplication {
      func dismissKeyboard() {
          sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
      }
  }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(Recipe())
                .previewInterfaceOrientation(.portrait)
        }
    }
}
