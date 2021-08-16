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
    @State private var isLoading = false

    var count = 0
    
    init() {
    UITableView.appearance().backgroundColor = #colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)
    UITableViewCell.appearance().backgroundColor = #colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)
    }
    
    var body: some View {
        NavigationView {
                ZStack {
                    VStack {
                        Text("RECIPLEASE").font(Font.custom("BebasNeue-Regular",size: 50))
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                            Text("You currently have " + String(Data.RecipeList.count) + " Recipe's stored").font(Font.custom("BebasNeue-Regular",size: 23))
                            .padding(15)
                            .foregroundColor(Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        NavigationLink(destination: AddRecipeView()) {
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
                        
                        if Data.RecipeList.count > 0 {
                            let i = Int.random(in: 0..<Data.RecipeList.count)
                            NavigationLink(destination: DetailView(Title: Data.RecipeList[i].name,
                                                                   description: Data.RecipeList[i].description,
                                                                   method: Data.RecipeList[i].method,
                                                                   ingredients: Data.RecipeList[i].Ingredients)){
                                Buttons1.RecipeFinderButton()
                                    .padding(10)
                            }
                        } else {
                            Buttons1.RecipeFinderButton()
                                .padding(10)
                        }
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
                    if isLoading{
                                   LoadingView()
                    }
                }
                .onAppear{ self.webScrape()}
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(#colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)))
                .edgesIgnoringSafeArea(.all)
        }.accentColor(.black)
    }
    
    func webScrape() {
        isLoading = true
        Data.fillProds()
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.isLoading=false
        }
    }
}


struct LoadingView: View {
    @State private var isLoading = false
    var body: some View {
        ZStack {
            Text("Cooking up your Recipes")
                .font(.system(.body, design: .rounded))
                .bold()
                .offset(x: 0, y: -25)
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color(.systemGray5), lineWidth: 3)
                .frame(width: 250, height: 3)
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color.orange, lineWidth: 3)
                .frame(width: 30, height: 3)
                .offset(x: isLoading ? 110 : -110, y: 0)
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
        }
        .onAppear() {
            self.isLoading = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
    }
}








