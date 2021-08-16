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
    @State var ingredients: [String] = [""]
    @State var tap = false
    @State var placeheolder = ""
    var quantsofIngredients: [Double] = []
    var ingredientsAlreadyHave: [String] = []
    var quantsofIAH: [Int] = []
    var staplesPPP: [Int] = []
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    
    var count: Int = 0
    init(){
    }
    
    
    
    
    
    var body: some View {
        
        ZStack{
            VStack{
                ScrollView{
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
                    .randomBorder()
                }
                .frame(width: UIScreen.main.bounds.width - 20)
                    
                    
                HStack{
                    TextField("Description",text: $description)
                        .randomBorder()
                        .multilineTextAlignment(TextAlignment.center)
                        .frame(width: UIScreen.main.bounds.width-170,height:40)
                        .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style:
                            .continuous))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    TextField("Serving Size",text: $servingSize)
                        .randomBorder()
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(TextAlignment.center)
                        .frame(width: UIScreen.main.bounds.width-290,height:40)
                        .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style:
                            .continuous))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                        .onReceive(Just(servingSize)) { newValue in
                            let filtered = newValue.filter { "0123456789".contains($0) }
                            if filtered != newValue {
                                self.servingSize = filtered
                            }
                    }
                    
                }
                
               
                HStack{
                    Spacer()
                        .frame(height: 20)
                    ZStack{
                        Picker("",selection: $ingredient){
                            
                            ForEach(Data.Ingredients.filter({ searchText.isEmpty ? true : $0.name.lowercased().contains(searchText.lowercased()) }), id: \.name) {item in
                                Text(item.unit + " " + item.name).font(.system(size: 10))                            }
                        }
                        .offset(y:50)
                        .randomBorder()
                        .padding(.top,20)
                        .frame(height: 200)
                        .clipped()
                        Spacer()
                        .frame(height: 5)
                        SearchBar(text: $searchText,placeholder: "Ingredients...")
                            .frame(width: UIScreen.main.bounds.width-75)
                            .offset(x: -7)
                            .randomBorder()
                           
                    }
                    .frame(height: 20)
                    
                    
                    
                    
                    
                    Buttons1.AddButton()
                        .randomBorder()
                        .offset(x:-10)
                        .scaleEffect(tap ? 1.02:1)
                        .onTapGesture {
                            self.ingredients.append(self.ingredient)
                            self.tap = true
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
                                self.tap=false
                            }
                    }
                    
                }
                
    
                Spacer()
                    .frame(height: 100)
                VStack{
                    Text("Ingredient List").font(Font.custom("BebasNeue-Regular",size: 20))
                        .randomBorder()
                        .padding(15)
                        .foregroundColor(Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)))
                        .frame(width: UIScreen.main.bounds.width - 15,alignment: .leading)
                        .frame(width: UIScreen.main.bounds.width - 20)
                        Text(returnArrayinStringForm2(array:self.ingredients))
                        .font(Font.custom("BebasNeue-Regular",size: 13))
                            .modifier(ClearButton(text: self.ingredients[self.ingredients.count-1]))
                        Print(returnArrayinStringForm2(array:self.ingredients))
                        

                    
                    
                
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height - 900)
                    
                    Text("Method").font(Font.custom("BebasNeue-Regular",size: 20))
                        .foregroundColor(Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)))
                    TextEditor(text: $method)
                      .foregroundColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                    Spacer()
                        .frame(height: UIScreen.main.bounds.height - 700)
                    
                    NavigationLink(destination: ContentView()){
                        Buttons1.FinalAddRecipeButton()
                            .scaleEffect(tap ? 1.02:1)
                            .onTapGesture {
                                
                                Data.addRecipe(n: self.title, method: self.method, description: self.description, Ing: self.ingredients, Quants: self.quantsofIngredients, Serving: Int(self.servingSize) ?? 0, Image: "", staples: self.ingredientsAlreadyHave, staplesQuant: self.quantsofIAH, staplesPPP: self.staplesPPP)
                                sleep(1)
                                
                                self.mode.wrappedValue.dismiss()
                        }
                        
                        
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
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}




extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}


func returnArrayinStringForm2(array: [String]) ->String{
    var s = ""
    for i in 0..<array.count{
        s += array[i]+"\n"
    }
    return(s)
    
}

struct ClearButton: ViewModifier {
    @State var text: String
   
    public func body(content: Content) -> some View {
        HStack {
            content
            Button(action: {
                self.text = ""
                AddRecipeView().ingredients.remove(at:  AddRecipeView().ingredients.firstIndex(of: self.text) ?? 0)
            }) {
                Image(systemName: "multiply.circle.fill")
                    .foregroundColor(.secondary)
            }
        }
    }
}
