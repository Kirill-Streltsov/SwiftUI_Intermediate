//
//  SubscriberBootcamp.swift
//  SwiftUI_Intermediate
//
//  Created by Kirill Streltsov on 09.08.23.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    @Published var count = 0
    var timer: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    @Published var textIsValid = false
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .map { text -> Bool in
                if text.count > 3 {
                    return true
                }
                return false
            }
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.count += 1
                
            }
            .store(in: &cancellables)
    }
}

struct SubscriberBootcamp: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            Text("\(vm.textIsValid.description)")
            
            TextField("Enter text", text: $vm.textFieldText)
        }
    }
}

struct SubscriberBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberBootcamp()
    }
}
