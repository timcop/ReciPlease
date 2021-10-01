//
//  RecipeListView.swift
//  Reciplease-Beta
//
//  Created by Samuel Royal on 15/08/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import SwiftUI
/**
 Individual detail view for each of the recipes. This navigated to the browse recipes, and also with the random finder button
 */

struct DetailView: View {
    var title: String
    var description: String
    var method: String
    var ingredients: [String]
    var quantities: [Double]
    @State var count = 0
    var body: some View {
            NavigationView {
                VStack {
                    ScrollView {
                    Spacer()
                        .frame(height: 30)
                        Text(title).font(Font.custom("BebasNeue-Regular",size: 40))
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                            .padding(5)
                        Text(description).font(Font.custom("BebasNeue-Regular",size: 27))
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        Text("Ingredients").font(Font.custom("BebasNeue-Regular",size: 23))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                            .padding(10)
                        HStack{
                            
                            Text(returnDoubleArrayinStringForm(array: quantities))
                                .font(Font.custom("BebasNeue-Regular",size: 20))
                            Text(returnArrayinStringForm(array: ingredients))
                                .font(Font.custom("BebasNeue-Regular",size: 20))
                        }
                        .frame(width:UIScreen.main.bounds.width-20,alignment: .leading)
                        Text("Method").font(Font.custom("BebasNeue-Regular",size: 23))
                                                   .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                                                       .padding(10)
                        Text(method).font(Font.custom("BebasNeue-Regular",size: 23))
                            .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        
                        
                    }
                        
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(#colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)))
                .edgesIgnoringSafeArea(.all)
            }
                .frame(alignment: .top)
        }
    }
}

struct RecipeListView: View {
    var body: some View {
        List(Data.RecipeList.indices, id: \.self){ index in
            NavigationLink(destination: DetailView(title: Data.RecipeList[index].name, description: Data.RecipeList[index].description, method: Data.RecipeList[index].method, ingredients: Data.RecipeList[index].Ingredients, quantities: Data.RecipeList[index].Quants)){
                Text(Data.RecipeList[index].name).listRowBackground(Color(#colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)))
                Text("$" + String(Data.priceRecipe(recNum: index))).listRowBackground(Color(#colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)))
                }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
/**
 Returns an array of strings in a single line seperated string.
 */

func returnArrayinStringForm(array: [String]) ->String{
    var str = ""
    for i in 1..<array.count{
        str = str + array[i]+"\n"
    }
    return(str)
}
func returnDoubleArrayinStringForm(array: [Double]) ->String{
    var str = ""
    for i in 1..<array.count{
        str = str + String(array[i])+"\n"
    }
    return(str)
    
}
