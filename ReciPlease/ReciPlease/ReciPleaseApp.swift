//
//  ReciPleaseApp.swift
//  ReciPlease
//
//  Created by Tim Copland on 28/09/21.
//

import SwiftUI

@main
struct ReciPleaseApp: App {
//    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var recipeModel = RecipeModel()

    @State private var isLoaded: Bool = Bool()
    

    var body: some Scene {

        WindowGroup {
            Group {
               if (isLoaded) { ContentView().environmentObject(recipeModel) }
               else {
                   
                   LoadingView()
                   
                   
               }
            }.onAppear() {
                if recipeModel.recipes.count == 1 {
                    recipeModel.recipes = recipeModel.getRecList()
//                    sleep(3)
//                    isLoaded = true
                    completionHandler { value in isLoaded = value }

                } else {
                    isLoaded = true
                }
            }

        }
        .onChange(of: scenePhase) { phase in
            
            switch phase {
               case .active:
                   print("active")
               case .inactive:
                   print("inactive")
                print(recipeModel.recipes)
                recipeModel.storeRecList(recs: recipeModel.recipes)
               case .background:
//                    print("HERRREw")
                    print(recipeModel.recipes)
                    recipeModel.storeRecList(recs: recipeModel.recipes)
            @unknown default:
                print("error")
            }

        }
    }
}


func completionHandler(value: @escaping (Bool) -> Void) {
    
    // some heavy work here!
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(2000)) { value(true) }
    
}

struct LoadingView: View {
    @State private var isLoading = false
    var body: some View {
        ZStack {
            Text("Cooking up your Recipes")
                .font(.system(.body, design: .rounded))
                .bold()
                .offset(x: 0, y: -25)
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color(.systemGray5), lineWidth: 3)
                .frame(width: 250, height: 3)
            RoundedRectangle(cornerRadius: 3)
                .stroke(Color.blue, lineWidth: 3)
                .frame(width: 30, height: 3)
                .offset(x: isLoading ? 110 : -110, y: 0)
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value:isLoading)
        }.onAppear {
            isLoading = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.953, green: 0.627, blue: 0.067, alpha: 1)))
        .edgesIgnoringSafeArea(.all)
    }
}
