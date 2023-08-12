//
//  PhotoModel.swift
//  SwiftUI_Intermediate
//
//  Created by Streltsov, Kirill, SEVEN PRINCIPLES on 12.08.23.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
