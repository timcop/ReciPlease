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
    
    var body: some View {
        NavigationView{
                VStack{
                    VStack{
                        Text("RECIPLEASE").font(Font.custom("BebasNeue-Regular",size: 50))
                        Text("You currently have 24 Recipe's stored").font(Font.custom("BebasNeue-Regular",size: 23))
                            .padding(15)
                        NavigationLink(destination: AddRecipeView()){
                            AddRecipeButton()
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
                        
                        RecipeFinderButton()
                            .padding(10)
                            Spacer()
                                .frame(height:100)
                        BrowseRecipesButton()
                            .padding()
                    }
                    .frame(height: UIScreen.main.bounds.height - 50,alignment: .top)
                    

                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(#colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)))
                .edgesIgnoringSafeArea(.all)
        
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
