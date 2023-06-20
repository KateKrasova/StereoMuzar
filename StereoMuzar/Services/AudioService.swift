//
//  AudioService.swift
//  StereoMuzar
//
//  Created by Kate on 20.04.2023.
//

import AudioKit
import Foundation

public final class AudioService {
    // MARK: - Shared

    static let shared = AudioService()

    // MARK: - Internal Props

    var isInit: Bool = false

   var isPlaying: Bool {
        player.isPlaying
    }

    var currentTime: TimeInterval {
        player.currentTime
    }

    var duration: TimeInterval? {
        player.file?.duration
    }

    var currentPosition: Double {
        player.currentPosition
    }

    var currentTrack: Song?

    // MARK: - Private Props

    private let engine = AudioEngine()
    private let player = AudioPlayer()

    private var playList: [Song] = []
    private var currentIndexForTrack = -1

    private init() {
        engine.output = player
        player.completionHandler = completionHandler

        do {
            try engine.start()
            isInit = true
        } catch {
            Log(error)
        }
    }
}

// MARK: - Public Methods

public extension AudioService {
    func load(song: Song) {
        guard isInit else { return }

        do {
            if let trackFileURL = Bundle.main.url(forResource: song.allName, withExtension: "mp3") {
                player.stop()
                try player.load(url: trackFileURL)
                currentTrack = song
                player.play()
            }
        } catch {
            Log(error)
        }
    }

    func load(songs: [Song], index: Int) {
        playList = songs
        currentIndexForTrack = index
        load(song: songs[index])
    }
    

    func togglePlayPause() {
        guard isInit else { return }
        player.isPlaying ? player.pause() : player.play()
    }

    func prevTrack() {
        currentIndexForTrack = currentIndexForTrack == 0
            ? playList.count - 1
            : currentIndexForTrack - 1

        loadFromPlaylist(index: currentIndexForTrack)
    }

    func nextTrack() {
        currentIndexForTrack = currentIndexForTrack == playList.count - 1
            ? 0
            : currentIndexForTrack + 1

        loadFromPlaylist(index: currentIndexForTrack)
    }

    func completionHandler() {
    }
}

private extension AudioService {
    func loadFromPlaylist(index: Int) {
        load(song: playList[index])
    }
}
