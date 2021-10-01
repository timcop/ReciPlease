//
//  TestView.swift
//  ReciPlease
//
//  Created by Tim Copland on 29/09/21.
//

import SwiftUI

struct TestView: View {
    @State var test:String = ""
    var body: some View {
        ScrollView {
            VStack {
                Text("HERE")
                Form {
                    Section(header: Text("Recipe Name")) {
                        TextField("Recipe Name", text: $test)
                    }
                }
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
