//
//  ContentView.swift
//  Reciplease-Beta
//
//  Created by Samuel Royal on 13/08/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var numCooking = ""
    @State var budget = ""
    @State var tap = false
    
    init(){
        Startup()
    }
    
    var body: some View {
        NavigationView{
                ZStack{
                    VStack{
                        Text("RECIPLEASE").font(Font.custom("BebasNeue-Regular",size: 50))
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        Text("You currently have " + String(Data.RecipeList.count) + " Recipe's stored").font(Font.custom("BebasNeue-Regular",size: 23))
                            .padding(15)
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        NavigationLink(destination: AddRecipeView()){
                            Buttons1.AddRecipeButton()
                            .scaledToFit()
                            .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                       
                        
                        Spacer()
                        
                        TextField("Number of people you are cooking for",text: $numCooking)
                            .keyboardType(.numberPad)
                            .onReceive(Just(numCooking)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.numCooking = filtered
                                    }
                            }
                            .padding(10)
                            .frame(width: UIScreen.main.bounds.width - 20)
                            .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style:
                            .continuous))
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                
                        TextField("Budget",text: $budget)
                            .keyboardType(.numberPad)
                            .onReceive(Just(budget)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.budget = filtered
                                    }
                            }
                            .padding(10)
                            .frame(width: UIScreen.main.bounds.width - 20)
                            .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            .clipShape(RoundedRectangle(cornerRadius: 16, style:
                            .continuous))
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        
                        Buttons1.RecipeFinderButton()
                            .padding(10)
                            Spacer()
                                .frame(height:100)
                        NavigationLink(destination: RecipeListView()){
                            Buttons1.BrowseRecipesButton()
                            .scaledToFit()
                            .padding()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .frame(height: UIScreen.main.bounds.height - 50,alignment: .top)
                    

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(#colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)))
                .edgesIgnoringSafeArea(.all)
        
        }.accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


func Startup(){
    Data.fillProds()
    sleep(3)
    Data.addRecipe(n: "Vegetable Lasagne", method: "To prepare the veggies: In a large skillet over medium heat, warm the olive oil. Once shimmering, add the carrots, bell pepper, zucchini, yellow onion, and salt. Cook, stirring every couple of minutes, until the veggies are golden on the edges, about 8 to 12 minutes. This is just random text please dont take this as what is going to go in our recipe app thank you verymcuh for your kind words _________________________________________________________________________________________________--________________________------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------_________________________________________________________________________________________________--________________________------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------_________________________________________________________________________________________________--________________________------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------_________________________________________________________________________________________________--________________________------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------_________________________________________________________________________________________________--________________________------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------",
                   description: "Lovely Vegetable Lasagne", Ing: ["meadows mushrooms shiitake","fresh produce rockmelon whole","taylor farms salad kit buffalo ranch with dressing"], Quants: [1,1,2], Serving: 4,Image: "Lasagne",staples: ["jeff, Cheese, penis"], staplesQuant: [1,2,1000], staplesPPP: [10,3,1])
}
