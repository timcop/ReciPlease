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
    var body: some View{
        Text(Title)
    }
}

struct RecipeListView: View {
    var body: some View {
        NavigationView{
            List(Data.RecipeList , id: \.name){ item in
                NavigationLink(destination: DetailView(Title: item.name)){
                    Text(item.name)
                }
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
