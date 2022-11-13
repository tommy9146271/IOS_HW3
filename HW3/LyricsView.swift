//
//  LyricsView.swift
//  HW3
//
//  Created by 李子暘 on 2022/11/11.
//

import SwiftUI

struct LyricsView: View {
    @Binding var SelectSong: String
    let allsongs = [
        Song.Lavender_Haze,
        Song.Maroon,
        Song.Anti_Hero,
        Song.Snow_On_The_Beach,
        Song.Youre_On_Your_Own_Kid,
        Song.Midnight_Rain,
        Song.Question,
        Song.Vigilante_Shit,
        Song.Bejeweled,
        Song.Labyrinth,
        Song.Karma,
        Song.Sweet_Nothing,
        Song.Mastermind,
        Song.Love_Story,
        Song.High_Infidelity,
        Song.We_Are_Never_Ever_Getting_Back_Together,
        Song.So_It_Goes,
        Song.Safe_Sound,
        Song.Blank_Space,
        Song.Wildest_Dreams,
        Song.Look_What_You_Made_Me_Do
    ]
    var body: some View {
        ScrollView{
            ForEach(allsongs) { allsong in
                if SelectSong == allsong.name {
                    Text(allsong.lyrics)
                }
            }
        }
        .padding()
    }
}

struct LyricsView_Previews: PreviewProvider {
    static var previews: some View {
        LyricsView(SelectSong: .constant(""))
    }
}
