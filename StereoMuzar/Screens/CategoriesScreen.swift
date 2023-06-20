//
//  CategoriesScreen.swift
//  StereoMuzar
//
//  Created by Kate on 20.04.2023.
//

import SwiftUI

struct CategoriesScreen: View {
    
    @State var categories = [
            Category(name: "Sport", imageName: "sport", songs: [
                Song(allName: "Remix Sport Workout - All Stars", singerName: "Remix Sport Workout", songName: "All Stars"),
                Song(allName: "Remix Sport Workout - Dusk Till Dawn", singerName: "Remix Sport Workout", songName: "Dusk Till Dawn"),
                Song(allName: "Remix Sport Workout - Treat You Better", singerName: "Remix Sport Workout", songName: "Treat You Better"),
                Song(allName: "Takeoff, Rich The Kid - Crypto", singerName: "Takeoff, Rich The Kid", songName: "Crypto")
            ]),
            Category(name: "Sleep", imageName: "sleep", songs: [
                Song(allName: "April Rain - Dontclosethedoorandletmein", singerName: "April Rain", songName: "Dontclosethedoorandletmein"),
                Song(allName: "Arctic Lake - (Moments)", singerName: "Arctic Lake", songName: "(Moments)"),
                Song(allName: "Bernward Koch - A Gift Remembered", singerName: "Bernward Koch", songName: "A Gift Remembered"),
                Song(allName: "Brian Crain - At the Ivy Gate", singerName: "Brian Crain", songName: "At the Ivy Gate"),
                Song(allName: "George Skaroulis - Elektra", singerName: "George Skaroulis", songName: "Elektra"),
            ]),
            Category(name: "Meditation", imageName: "meditation", songs: [
                Song(allName: "Yoga Relax Academy - Meditation", singerName: "Yoga Relax Academy", songName: "Meditation"),
            ]),
            Category(name: "Running", imageName: "run", songs: [
                Song(allName: "21 Savage, Metro Boomin - Runnin", singerName: "21 Savage, Metro Boomin", songName: "Runnin"),
                Song(allName: "Chase & Status feat. Moko - Count On Me", singerName: "Chase & Status feat. Moko", songName: "Count On Me"),
                Song(allName: "Chase & Status feat. Novelist - NRG", singerName: "Chase & Status feat. Novelist", songName: "NRG"),
                Song(allName: "D-Block & S-te-Fan, D-Sturb - Feel It!", singerName: "D-Block & S-te-Fan, D-Sturb", songName: "Feel It!"),
                Song(allName: "Remzcore & Hyrule War - Never Die", singerName: "Remzcore & Hyrule War", songName: "Never Die"),
                Song(allName: "will.i.am feat. Britney Spears - Scream & Shout", singerName: "will.i.am feat. Britney Spears", songName: "Scream & Shout")
            ]),
            Category(name: "Cooking", imageName: "cooking", songs: [
                Song(allName: "Ashley Price - Ice Cream", singerName: "Ashley Price", songName: "Ice Cream"),
                Song(allName: "Beets - Post Malone", singerName: "Post Malone", songName: "Beets"),
                Song(allName: "Calvin Sparks - OK Not To Be OK", singerName: "Calvin Sparks", songName: "OK Not To Be OK"),
                Song(allName: "Cooking Jazz Music Academy - Find Your Way", singerName: "Cooking Jazz Music Academy", songName: "Find Your Way"),
                Song(allName: "Drake - Hotline Bling", singerName: "Drake", songName: "Hotline Bling"),
                Song(allName: "Jenny Jewel - Blow Your Mind", singerName: "Jenny Jewel", songName: "Blow Your Mind"),
                Song(allName: "MAYOT feat. FEDUK - Море", singerName: "MAYOT feat. FEDUK", songName: "Море"),
            ]),
            Category(name: "Gym", imageName: "gym", songs: [
                Song(allName: "Dance Time Trio - Toosie Slide", singerName: "Dance Time Trio", songName: "Toosie Slide"),
                Song(allName: "Gym Class Heroes - Stereo Hearts (feat. Adam Levine)", singerName: "Gym Class Heroes", songName: "Stereo Hearts"),
                Song(allName: "MonoMakers, New Bass, Lowzer - Like This", singerName: "MonoMakers, New Bass, Lowzer", songName: "Like This"),
                Song(allName: "Pop Smoke - Brother Man", singerName: "Pop Smoke - Brother Man", songName: "Brother Man"),
                Song(allName: "Thomas Rivera - If I Can't Have You", singerName: "Thomas Rivera", songName: "If I Can't Have You"),
                Song(allName: "Will Shepard - Rise", singerName: "Will Shepard", songName: "Rise")
            ]),

            Category(name: "Party", imageName: "party", songs: [
                Song(allName: "Countdown Singers - Just the Way You Are", singerName: "Countdown Singers", songName: "Just the Way You Are"),
                Song(allName: "DanceArt - Bad Romance", singerName: "DanceArt", songName: "Bad Romance"),
                Song(allName: "Fresh Beat MCs - Imma Be", singerName: "Fresh Beat MCs", songName: "Imma Be"),
                Song(allName: "Princess Beat - Tik Tok", singerName: "Princess Beat", songName: "Tik Tok"),
                Song(allName: "Sassydee - California Gurls", singerName: "Sassydee", songName: "California Gurls")
            ])
        ]
    
    var body: some View {
        NavigationView {
            List(categories) { category in
                NavigationLink(destination: MusicListScreen(viewModel: .init(category: category))) {
                    HStack {
                        Image(category.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        Text(category.name)
                    }
                }

            }
            .navigationTitle("Categories")
        }
    }
}

final class MusicListViewModel: ObservableObject {
    @Published var category: Category

    private let audioService = AudioService.shared

    init(category: Category) {
        self.category = category
    }

    func tapOnCell(song: Song) {
        audioService.load(
            songs: category.songs,
            index: category.songs.firstIndex(where: { $0.id == song.id }) ?? 0
        )
    }
}

struct MusicListScreen: View {
    @ObservedObject var viewModel: MusicListViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.category.songs) { song in
                    HStack {
                        Text(song.singerName)
                        Text(" - ")
                        Text(song.songName)
                        Spacer()
                    }
                    .onTapGesture {
                        viewModel.tapOnCell(song: song)
                    }
                }
                .onDelete(perform: delete)
            }.padding(.top, 10)
        }
        .navigationTitle(viewModel.category.name)
    }

    func delete(at offsets: IndexSet) {
        // category.songs.remove(atOffsets: offsets)
    }
}


struct CategoriesScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesScreen()
    }
}
