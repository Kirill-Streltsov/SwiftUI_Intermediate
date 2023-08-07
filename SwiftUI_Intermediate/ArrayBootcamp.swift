//
//  ArrayBootcamp.swift
//  SwiftUI_Intermediate
//
//  Created by Kirill Streltsov on 07.08.23.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID()
    let name: String
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    
    init() {
        getUsers()
    }
    
    func updateFilteredArray() {
        // sort
        // filter
        // map
        
        mappedArray = dataArray
            .sorted(by: { $0.points > $1.points })
            .filter { $0.isVerified }
            .compactMap { $0.name }
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Nick", points: 5, isVerified: true)
        let user2 = UserModel(name: "Chris", points: 52, isVerified: false)
        let user3 = UserModel(name: "Joe", points: 15, isVerified: true)
        let user4 = UserModel(name: "Samantha", points: 5, isVerified: true)
        let user5 = UserModel(name: "Jason", points: 3, isVerified: false)
        let user6 = UserModel(name: "Sarah", points: 0, isVerified: false)
        let user7 = UserModel(name: "Kirill", points: 12, isVerified: true)
        let user8 = UserModel(name: "Peter", points: 4, isVerified: false)
        let user9 = UserModel(name: "Kris", points: 51, isVerified: true)
        let user10 = UserModel(name: "Sebastian", points: 37, isVerified: false)
        let user11 = UserModel(name: "Nick", points: 23, isVerified: true)
        let user12 = UserModel(name: "Nick", points: 101, isVerified: false)
        dataArray.append(contentsOf: [user1, user2, user3, user4, user5, user6, user7, user8, user9, user10, user11, user12])
    }
}

struct ArrayBootcamp: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(vm.dataArray) { user in
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        HStack {
                            Text("Points: \(user.points)")
                            Spacer()
                            if user.isVerified {
                                Image(systemName: "flame.fill")
                            }
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
                }
                
            }
        }
    }
}

struct ArrayBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArrayBootcamp()
    }
}
