//
//  SrollViewReaderBootcamp.swift
//  SwiftUI_Intermediate
//
//  Created by Kirill Streltsov on 07.08.23.
//

import SwiftUI

struct SrollViewReaderBootcamp: View {
    var body: some View {
        ScrollView {
            ForEach(0..<50) { index in
                Text("This is item #\(index)")
                    .font(.headline)
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
            }
        }
    }
}

struct SrollViewReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SrollViewReaderBootcamp()
    }
}
