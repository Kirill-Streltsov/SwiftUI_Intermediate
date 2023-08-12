//
//  PhotoModelDataService.swift
//  SwiftUI_Intermediate
//
//  Created by Streltsov, Kirill, SEVEN PRINCIPLES on 12.08.23.
//

import Foundation
import Combine

class PhotoModelDataService {

    static let instance = PhotoModelDataService()
    var cancellables = Set<AnyCancellable>()

    @Published var photoModels: [PhotoModel] = []

    private init() {
        downloadData()
    }

    func downloadData() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else { return }
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PhotoModel].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error downloading data: \(error)")
                }
            } receiveValue: { [weak self] photoModels in
                self?.photoModels = photoModels
            }
            .store(in: &cancellables)

    }

    private func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}
