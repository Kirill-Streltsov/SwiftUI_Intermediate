//
//  SrollViewReaderBootcamp.swift
//  SwiftUI_Intermediate
//
//  Created by Kirill Streltsov on 07.08.23.
//

import SwiftUI

struct SrollViewReaderBootcamp: View {
    
    @State var scrollToIndex: Int = 0
    @State var textFieldText = ""
    
    var body: some View {
        VStack {
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 55)
                .border(.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("SCROLL NOW") {
                
                if let index = Int(textFieldText) {
                    scrollToIndex = index
                }
                
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                    
                    
                    ForEach(0..<50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                        
                    }
                    .onChange(of: scrollToIndex) { index in
                        withAnimation(.spring()) {
                            proxy.scrollTo(index, anchor: nil)
                        }
                    }
                }
            }
        }
        
    }
}

struct SrollViewReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SrollViewReaderBootcamp()
    }
}
