//
//  Category.swift
//  StereoMuzar
//
//  Created by Kate on 20.04.2023.
//

import Foundation

public struct Category: Identifiable, Equatable {
    public let id = UUID()
    public let name: String
    public let imageName: String
    public var songs: [Song]
}
