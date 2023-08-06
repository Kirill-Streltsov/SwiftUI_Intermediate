//
//  SheetsBootcamp.swift
//  SwiftUI_Intermediate
//
//  Created by Kirill Streltsov on 07.08.23.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID()
    let title: String
}

// 1 - use a binding
// 2 - use multiple sheets
// 3 - use $item

struct SheetsBootcamp: View {
    
    @State var selectedModel: RandomModel = RandomModel(title: "Starting title")
    @State var showSheet = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                selectedModel = RandomModel(title: "ONE")
                showSheet = true
            }
            Button("Button 2") {
                selectedModel = RandomModel(title: "TWO")
                showSheet = true
            }
        }
        .sheet(isPresented: $showSheet) {
            NextScreen(selectedModel: $selectedModel)
        }
    }
}

struct NextScreen: View {
    
    @Binding var selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct SheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SheetsBootcamp()
    }
}
