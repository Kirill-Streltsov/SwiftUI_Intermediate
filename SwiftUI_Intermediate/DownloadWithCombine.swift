//
//  CombineBootcamp.swift
//  SwiftUI_Intermediate
//
//  Created by Kirill Streltsov on 09.08.23.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // .subscribe on backgroun thread is not by default. We can ommit it
        
        // 1. create the publisher
        // 2. subscribe publisher on background thread (optional as stated above)
        // 3. receive on main thread
        // 4. tryMap (check that the data is good)
        // 5. decode data
        // 6. sink (put the item into our app)
        // 7. store (cancel subscription if needed)
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main) // 3.
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    print("FINISHED")
                case .failure(let error):
                    print("ERROR WHILE GETTING DATA FROM THE WEB: \(error)")
                }
            } receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            }
            .store(in: &cancellables)

    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}
