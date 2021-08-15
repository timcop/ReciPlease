//
//  RecipeListView.swift
//  Reciplease-Beta
//
//  Created by Samuel Royal on 15/08/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var Title: String
    var description: String
    var method: String
    var ingredients: [String]
    @State var count = 0
    
    
    var body: some View{
            NavigationView{
                VStack{
                    ScrollView{
                    Spacer()
                        .frame(height: 100)
                    Text(Title).font(Font.custom("BebasNeue-Regular",size: 25))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        .padding(10)
                    Text(description).font(Font.custom("BebasNeue-Regular",size: 20))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    Text(returnArrayinStringForm(array: ingredients)).font(Font.custom("BebasNeue-Regular",size: 15))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        .frame(alignment: .leading)
                    Text(method).font(Font.custom("BebasNeue-Regular",size: 15))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(#colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)))
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct RecipeListView: View {
    var body: some View {
        List(Data.RecipeList.indices, id: \.self){ index in
            NavigationLink(destination: DetailView(Title: Data.RecipeList[index].name, description: Data.RecipeList[index].description, method: Data.RecipeList[index].method, ingredients: Data.RecipeList[index].Ingredients)){
                Text(Data.RecipeList[index].name).listRowBackground(Color(#colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)))
                Text("$" + String(Data.priceRecipe(recNum: index)) ).listRowBackground(Color(#colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)))
                }
            }
        
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}

func returnArrayinStringForm(array: [String]) ->String{
    var s = ""
    for i in 0..<array.count{
        s = s + array[i]+"\n"
    }
    return(s)
    
}
