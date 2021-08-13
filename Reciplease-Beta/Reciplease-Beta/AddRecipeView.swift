//
//  AddRecipeView.swift
//  Reciplease-Beta
//
//  Created by Samuel Royal on 13/08/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import SwiftUI

struct AddRecipeView: View {
    @State var title = ""
    var body: some View {
        VStack{
            VStack{
                HStack{
                    TextField("Title",text: $title)
                        .padding(20)
                        .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 16, style:
                        .continuous))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    ImageButton()
                    
                    
                }
                
                
            }
            .frame(height: UIScreen.main.bounds.height - 150,alignment: .top)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
    }
        
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
