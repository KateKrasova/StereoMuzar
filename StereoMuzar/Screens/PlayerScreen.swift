//
//  PlayerScreen.swift
//  StereoMuzar
//
//  Created by Kate on 20.04.2023.
//

import SwiftUI
import AudioKit

final class PlayerViewModel: ObservableObject {
    // MARK: - Private Props

    let audioService = AudioService.shared

    // MARK: - Methods

    func prevTrack() {
        audioService.prevTrack()
    }

    func nextTrack() {
        audioService.nextTrack()
    }

    func togglePlayPause() {
        audioService.togglePlayPause()
    }
}

struct PlayerScreen: View {
    @State private var isShuffled = false
    @State private var isRepeat = false
    
    @State private var playImageName = "play.circle.fill"

    @ObservedObject var viewModel: PlayerViewModel
    
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @State var currentPosition = 0.0

    var body: some View {
        NavigationStack {
            ZStack{
                Color("background")
                    .edgesIgnoringSafeArea(.vertical)
                
                VStack {
                    HStack {
                        Spacer()
//                        Text("playerData.categoryName")
                            .padding(.trailing, 20)
                    }
                    
                VStack(alignment: .leading) {
                    HStack{
                        Text(viewModel.audioService.currentTrack?.songName ?? "No song")
                            .font(.system(size: 30))
                            .padding(.leading, 40)
                        Spacer()
                    }
                    
                    HStack{
                        Text(viewModel.audioService.currentTrack?.singerName ?? "No artist")
                            .font(.system(size: 20))
                            .padding(.leading, 40)
                        Spacer()
                    }
                    }
                    .padding(.trailing, 120)
                    .padding(.bottom, 50)
                    
                    Button(
                        action: {
                            viewModel.togglePlayPause()

                            if viewModel.audioService.isPlaying {
                                playImageName = "pause.circle.fill"
                            } else {
                                playImageName = "play.circle.fill"
                            }
                        }
                    ) {
                        Image(systemName: playImageName)
                            .font(.system(size: 150))
                            .foregroundColor(Color("button"))
                    }
                    .padding()

                    ProgressView(value: currentPosition)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color("progress")))
                        .padding()
                    
                    HStack {
                        Button(
                            action: {
                                viewModel.prevTrack()
                            }
                        ) {
                            Image(systemName: "backward.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Color("navigation"))
                        }
                        .padding()
                        
                        Button(
                            action: {
                                isRepeat.toggle()
                            }
                        ) {
                            Image(systemName: "repeat.1")
                                .font(.system(size: 20))
                                .foregroundColor(isRepeat ? Color("shuffleOn") : Color("shuffleOff") )
                        }
                        .padding()
                        
                        Button(
                            action: {
                                viewModel.nextTrack()
                            }
                        ) {
                            Image(systemName: "forward.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Color("navigation"))
                        }
                        .padding()
                    }
                    .padding()
                    
//                    Button(action: {
//                        isShuffled.toggle()
//
//                    }) {
//                        Image(systemName: "shuffle")
//                            .font(.system(size: 20))
//                            .foregroundColor(isShuffled ? Color("shuffleOn") : Color("shuffleOff") )
//                    }
                }
            }
            .onReceive(timer) { _ in
                currentPosition = viewModel.audioService.currentPosition
            }
            .navigationTitle("Player")
        }
    }
}

struct PlayerScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlayerScreen(viewModel: .init())
    }
}
