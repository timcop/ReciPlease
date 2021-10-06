//
//  ReciPleaseApp.swift
//  ReciPlease
//
//  Created by Tim Copland on 28/09/21.
//

import SwiftUI

@main
struct ReciPleaseApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var recipeModel = RecipeModel()

    @State private var isLoaded: Bool = Bool()

    var body: some Scene {
        WindowGroup {
            Group {
               if (isLoaded) { ContentView().environmentObject(recipeModel) }
               else { Text("Loading . . .") }
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
            if phase == .background {
                print("HERRREw")
                print(recipeModel.recipes)
                recipeModel.storeRecList(recs: recipeModel.recipes)
                
            }
        }
    }
}
    
func completionHandler(value: @escaping (Bool) -> Void) {
    
    // some heavy work here!
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(3000)) { value(true) }
    
}
