//
//  SearchBar.swift
//  ReciPlease
//
//  Created by Sam Royal on 1/10/21.
//

import SwiftUI

/** Custom search bar used within ContentView() */
struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var searching: Bool
     
     var body: some View {
         ZStack {
             Rectangle()
                 .foregroundColor(Color(.systemGray6))
             HStack {
                 Image(systemName: "magnifyingglass")
                 TextField("Search ..", text: $searchText){ startedEditing in
                 if startedEditing {
                     withAnimation {
                         searching = true
                     }
                 }
             } onCommit: {
                 withAnimation {
                     searching = false
                 }
             }
             }
             .foregroundColor(.gray)
             .padding(.leading, 13)
         }
             .frame(height: 40)
             .cornerRadius(13)
             .padding()
     }
 }
