//
//  DownloadingImagesBootcamp.swift
//  SwiftUI_Intermediate
//
//  Created by Streltsov, Kirill, SEVEN PRINCIPLES on 12.08.23.
//

import SwiftUI

// Codable
// background threads
// weak self
// Combine
// Publishers/Subscribers
// FileManager
// NSCache

struct DownloadingImagesBootcamp: View {

    @StateObject var vm = DownloadingImagesViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    Text(model.title)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

struct DownloadingImagesBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesBootcamp()
    }
}
