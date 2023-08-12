//
//  DownloadingImagesViewModel.swift
//  SwiftUI_Intermediate
//
//  Created by Streltsov, Kirill, SEVEN PRINCIPLES on 12.08.23.
//

import Foundation
import Combine

class DownloadingImagesViewModel: ObservableObject {

    @Published var dataArray: [PhotoModel] = []
    var cancellables = Set<AnyCancellable>()

    let dataService = PhotoModelDataService.instance

    init() {
        addSubscribers()
    }

    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] photoModels in
                self?.dataArray = photoModels
            }
            .store(in: &cancellables)
    }
}
