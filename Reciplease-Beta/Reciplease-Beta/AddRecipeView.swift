//
//  AddRecipeView.swift
//  Reciplease-Beta
//
//  Created by Samuel Royal on 13/08/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import SwiftUI
import Combine


struct AddRecipeView: View {
    @State var title = ""
    @State var searchText = ""
    @State var method = "Method"
    @State var description = ""
    @State var servingSize = ""
    @State var ingredient = ""
    @State var ingredients: [String] = []
    @State var tap = false
    var quantsofIngredients: [Double] = []
    var ingredientsAlreadyHave: [String] = []
    var quantsofIAH: [Int] = []
    var staplesPPP: [Int] = []
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    
    var count: Int = 0
    init(){
        UITableViewCell.appearance().backgroundColor = #colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)
        UITableView.appearance().backgroundColor = #colorLiteral(red: 1, green: 0.8612575531, blue: 0.6343607306, alpha: 1)
    }
    
    
    
    
    
    var body: some View {
        ZStack{
            VStack{
                Text("RECIPLEASE").font(Font.custom("BebasNeue-Regular",size: 50))
                    .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                Spacer()
                    .frame(height:53)
                HStack{
                    
                    TextField("Title",text: $title)
                        .multilineTextAlignment(TextAlignment.center)
                        .frame(width: UIScreen.main.bounds.width-170,height:40)
                        .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style:
                            .continuous))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    Buttons1.ImageButton()
                }
                .frame(width: UIScreen.main.bounds.width - 20)
                HStack{
                    TextField("Description",text: $description)
                        .multilineTextAlignment(TextAlignment.center)
                        .frame(width: UIScreen.main.bounds.width-170,height:40)
                        .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style:
                            .continuous))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    TextField("Serving Size",text: $servingSize)
                        .keyboardType(.numberPad)
                        .onReceive(Just(servingSize)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.servingSize = filtered
                            }
                    }
                    .multilineTextAlignment(TextAlignment.center)
                    .frame(width: UIScreen.main.bounds.width-250,height:40)
                    .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style:
                        .continuous))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                }
                HStack{
                    VStack{
                        SearchBar(text: $searchText,placeholder: "Ingredients...")
                            .frame(width: UIScreen.main.bounds.width - 75)
                        Picker("",selection: $ingredient){
                            
                            ForEach(Data.Ingredients.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }), id: \.name) {item in
                                Text(item.name).font(.system(size: 10))
                                
                            }
                            
                        }
                    }
                    
                    Buttons1.AddButton()
                        .scaleEffect(tap ? 1.02:1)
                        .onTapGesture {
                        print(self.ingredient)
                        self.ingredients.append(self.ingredient)
                        self.tap = true
                        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
                            self.tap=false
                        }
                    }
                }
                
                Text("Ingredient List").font(Font.custom("BebasNeue-Regular",size: 23))
                    .padding(15)
                    .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                    .frame(width: UIScreen.main.bounds.width - 15,alignment: .leading)
                    .frame(width: UIScreen.main.bounds.width - 20)
                Text(returnArrayinStringForm(array: ingredients))
                
                Spacer()
                
                
                MultilineTextView(text:$method)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .frame(width: UIScreen.main.bounds.width - 40,height: 200)
                    .padding(10)
                
                NavigationLink(destination: ContentView()){
                    Buttons1.FinalAddRecipeButton()
                        .scaleEffect(tap ? 1.02:1)
                        .onTapGesture {
                            
                            Data.addRecipe(n: self.title, method: self.method, description: self.description, Ing: self.ingredients, Quants: self.quantsofIngredients, Serving: Int(self.servingSize) ?? 0, Image: "", staples: self.ingredientsAlreadyHave, staplesQuant: self.quantsofIAH, staplesPPP: self.staplesPPP)
                                self.mode.wrappedValue.dismiss()
                    }
                
                     
                }
                
            }
            .frame(height: UIScreen.main.bounds.height - 50,alignment: .top)
            
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


func returnArrayinStringForm(array: [String]) ->String{
    var s = ""
    for i in 0..<array.count{
        s = s + array[i]+"\n"
    }
    return(s)
    
}


extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
