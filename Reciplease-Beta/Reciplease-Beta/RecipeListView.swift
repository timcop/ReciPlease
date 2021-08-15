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
    
    var body: some View{
            NavigationView{
                VStack{
                    ScrollView{
                    Spacer()
                        .frame(height: 300)
                    Text(Title).font(Font.custom("BebasNeue-Regular",size: 15))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    Text(description).font(Font.custom("BebasNeue-Regular",size: 15))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    Text(returnArrayinStringForm(array: ingredients)).font(Font.custom("BebasNeue-Regular",size: 15))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
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
        List(Data.RecipeList, id: \.self){ item in
            NavigationLink(destination: DetailView(Title: item.name, description: item.description, method: item.method, ingredients: item.Ingredients)){
                    Text(item.name)
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
