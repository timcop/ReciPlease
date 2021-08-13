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
    @State var searchText = ""
    @State var method = "Method"
    var body: some View {
        VStack{
            VStack{
                Spacer()
                    .frame(height:30)
                HStack{
                   
                    TextField("Title",text: $title)
                        .multilineTextAlignment(TextAlignment.center)
                        .frame(width: UIScreen.main.bounds.width-170,height:40)
                        .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style:
                        .continuous))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    ImageButton()
                }
                .frame(width: UIScreen.main.bounds.width - 20)
                HStack{
                    SearchBar(text: $searchText)
                        .frame(width: UIScreen.main.bounds.width - 75)
                        
                    
                   // List(LISTNAME.filter({ searchText.isEmpty ? true : $0.name.contains(searchText) })) { item in
                  //      Text(item.name)
                   // }
                    AddButton()
                }
                
                Text("Ingredient List").font(Font.custom("BebasNeue-Regular",size: 23))
                    .padding(15)
                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                    .frame(width: UIScreen.main.bounds.width - 15,alignment: .leading)
                .frame(width: UIScreen.main.bounds.width - 20)
                Spacer()
                
                
                MultilineTextView(text:$method)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .frame(width: UIScreen.main.bounds.width - 40,height: 200)
                    .padding(10)
                FinalAddRecipeButton()
                    
                
                
            }
            .frame(height: UIScreen.main.bounds.height - 170,alignment: .top)
            
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


struct MultilineTextView: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        view.clipsToBounds = true;
        view.layer.cornerRadius = 5
        view.font = .systemFont(ofSize: 15)
        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

