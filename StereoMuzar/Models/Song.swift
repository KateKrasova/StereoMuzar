//
//  Song.swift
//  StereoMuzar
//
//  Created by Kate on 20.04.2023.
//

import Foundation

public struct Song: Identifiable, Equatable {
    public let id = UUID()
    public let allName: String
    public let singerName: String
    public let songName: String
}
