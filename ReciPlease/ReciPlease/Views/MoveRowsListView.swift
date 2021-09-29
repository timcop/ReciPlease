//
//  MoveRowsListView.swift
//  ReciPlease
//
//  Created by Tim Copland on 29/09/21.
//

import SwiftUI

struct MoveRowsListView: View {
    @State private var isShow = true
       
       var body: some View {
           ZStack {
               Color.pink
                   .edgesIgnoringSafeArea(.all)
               
               VStack { // 1
                   if isShow {
                       Text("Hello, SwiftUI!")
                           .font(.system(size: 56, weight: .heavy))
                   }
               }
               
               VStack {
                   Spacer()
                   Button("Show / Hide") {
                       withAnimation(.easeInOut(duration:2)) {
                           isShow.toggle()
                       }
                   }.foregroundColor(.black)
               }
           }
       }
}



struct MoveRowsListView_Previews: PreviewProvider {
    static var previews: some View {
        MoveRowsListView()
    }
}
