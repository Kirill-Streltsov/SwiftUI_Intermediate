//
//  RotationGestureBootcamp.swift
//  SwiftUI_Intermediate
//
//  Created by Kirill Streltsov on 07.08.23.
//

import SwiftUI

struct RotationGestureBootcamp: View {
    
    @State var angle: Angle = .zero
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(50)
            .background(.blue)
            .cornerRadius(10)
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        angle = value
                    }
                    .onEnded { value in
                        withAnimation(.spring()) {
                            angle = Angle(degrees: 0)
                        }
                    }
            )
    }
}

struct RotationGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureBootcamp()
    }
}
