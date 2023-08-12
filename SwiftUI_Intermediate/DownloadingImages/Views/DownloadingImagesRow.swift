//
//  DownloadingImagesRow.swift
//  SwiftUI_Intermediate
//
//  Created by Streltsov, Kirill, SEVEN PRINCIPLES on 12.08.23.
//

import SwiftUI

struct DownloadingImagesRow: View {

    let model: PhotoModel
    
    var body: some View {
        HStack {
            DownloadingImageView(url: model.url)
                .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.headline)
                Text(model.url)
                    .foregroundColor(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct DownloadingImagesRow_Previews: PreviewProvider {
    static var previews: some View {
        DownloadingImagesRow(model: PhotoModel(albumId: 1, id: 1, title: "title", url: "url here", thumbnailUrl: "thumbnail url"))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
