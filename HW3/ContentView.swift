//
//  ContentView.swift
//  HW3
//
//  Created by 李子暘 on 2022/11/10.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var date = Date()
    @State private var FontColor = Color.black
    @State private var Rslider: Double = 0.5
    @State private var Gslider: Double = 0.5
    @State private var Bslider: Double = 0.5
    @State private var EnterSongName = ""
    @State private var SelectSong = ""
    @State private var SelectNewSong = Song.Anti_Hero.name
    @FocusState private var EnterFocus: Bool
    @State private var ShowLyricsPage = false
    @State private var Alert = false
    @State private var PlaySong = false
    @State private var isExpanded1 = false
    @State private var isExpanded2 = false
    @State private var istoggle = false
    @State private var temp = 2
    let player = AVPlayer()
    let newsongs = [
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
        Song.Mastermind
    ]
    let oldsongs = [
        Song.Love_Story,
        Song.High_Infidelity,
        Song.We_Are_Never_Ever_Getting_Back_Together,
        Song.So_It_Goes,
        Song.Safe_Sound,
        Song.Blank_Space,
        Song.Wildest_Dreams,
        Song.Look_What_You_Made_Me_Do
    ]
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
    init() {
        UIStepper.appearance().setDecrementImage(UIImage(systemName: "backward.fill"), for: .normal)
        UIStepper.appearance().setIncrementImage(UIImage(systemName: "forward.fill"), for: .normal)
    }
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Image("Midnight")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 400, height: 300)
                    .background(Color(red: Rslider, green: Gslider, blue: Bslider))
                Form{
                    DatePicker("今日", selection: $date)
                    ColorPicker("字體顏色", selection: $FontColor)
                    DisclosureGroup("專輯顏色", isExpanded: $isExpanded1){
                        HStack{
                            Text("R")
                                .foregroundColor(.red)
                            Slider(value: $Rslider, in: 0...1)
                                .tint(.red)
                        }
                        HStack{
                            Text("G")
                                .foregroundColor(.green)
                            Slider(value: $Gslider, in: 0...1)
                                .tint(.green)
                        }
                        HStack{
                            Text("B")
                                .foregroundColor(.blue)
                            Slider(value: $Bslider, in: 0...1)
                                .tint(.blue)
                        }
                    }
                    HStack{
                        TextField("輸入歌曲名字", text: $EnterSongName)
                            .focused($EnterFocus)
                        Button("確認"){
                            SelectSong = EnterSongName
                            for allsong in allsongs {
                                if SelectSong == allsong.name {
                                    temp = allsong.num
                                }
                            }
                            SelectNewSong = SelectSong
                            playmusic()
                            player.play()
                            PlaySong = true
                            EnterFocus = false
                        }
                    }
                    .contextMenu{
                        ForEach(allsongs) { allsong in
                            Button(allsong.name) {
                                SelectSong = allsong.name
                                for allsong in allsongs {
                                    if SelectSong == allsong.name {
                                        temp = allsong.num
                                    }
                                }
                                SelectNewSong = SelectSong
                                EnterSongName = SelectSong
                                PlaySong = true
                                playmusic()
                                player.play()
                            }
                        }
                    }
                    Stepper("歌曲編號 \(temp + 1) / 21", onIncrement: {
                        temp += 1
                        if temp > 20 {
                            SelectSong = allsongs[0].name
                            temp = 0
                            SelectNewSong = SelectSong
                            playmusic()
                            PlaySong = true
                            player.play()
                        } else {
                            SelectSong = allsongs[temp].name
                            SelectNewSong = SelectSong
                            playmusic()
                            PlaySong = true
                            player.play()
                        }
                    }, onDecrement: {
                        temp -= 1
                        if temp < 0 {
                            SelectSong = allsongs[20].name
                            temp = 20
                            SelectNewSong = SelectSong
                            playmusic()
                            PlaySong = true
                            player.play()
                        } else {
                            SelectSong = allsongs[temp].name
                            SelectNewSong = SelectSong
                            playmusic()
                            PlaySong = true
                            player.play()
                        }
                    })
                    Picker(selection: $SelectNewSong){
                        ForEach(newsongs) { newsong in
                            Text(newsong.name)
                        }
                    } label: {
                        Text("選擇新歌")
                    }
                    .pickerStyle(.navigationLink)
                    DisclosureGroup("其他歌曲", isExpanded: $isExpanded2){
                        ForEach(oldsongs) { oldsong in
                            Button(oldsong.name){
                                SelectSong = oldsong.name
                                for allsong in allsongs {
                                    if SelectSong == allsong.name {
                                        temp = allsong.num
                                    }
                                }
                                SelectNewSong = SelectSong
                                Alert = true
                            }
                            .alert("播放 \(SelectSong)", isPresented: $Alert, actions: {
                                Button("OK") {
                                    isExpanded2 = false
                                    PlaySong = true
                                    playmusic()
                                    player.play()
                                }
                            })
                        }
                    }
                    Toggle("隨機播放", isOn: $istoggle)
                }
                HStack{
                    Spacer()
                    Text(SelectSong)
                    Spacer()
                    Button{
                        if PlaySong {
                            PlaySong = false
                            if SelectSong != SelectNewSong {
                                SelectSong = SelectNewSong
                                for allsong in allsongs {
                                    if SelectSong == allsong.name {
                                        temp = allsong.num
                                    }
                                }
                                playmusic()
                            }
                            player.pause()
                        } else {
                            PlaySong = true
                            if SelectSong != SelectNewSong {
                                SelectSong = SelectNewSong
                                for allsong in allsongs {
                                    if SelectSong == allsong.name {
                                        temp = allsong.num
                                    }
                                }
                                playmusic()
                            }
                            player.play()
                        }
                    } label: {
                        Image(systemName: PlaySong ? "pause.fill" : "play.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    }
                    Button{
                        if istoggle {
                            var strtemp = allsongs.randomElement()!.name
                            while strtemp == SelectSong {
                                strtemp = allsongs.randomElement()!.name
                            }
                            SelectSong = strtemp
                            for allsong in allsongs {
                                if SelectSong == allsong.name {
                                    temp = allsong.num
                                }
                            }
                            SelectNewSong = SelectSong
                            playmusic()
                            PlaySong = true
                            player.play()
                        } else {
                            if temp + 1 > 20 {
                                SelectSong = allsongs[0].name
                                for allsong in allsongs {
                                    if SelectSong == allsong.name {
                                        temp = allsong.num
                                    }
                                }
                                SelectNewSong = SelectSong
                                playmusic()
                                PlaySong = true
                                player.play()
                            } else {
                                SelectSong = allsongs[temp + 1].name
                                for allsong in allsongs {
                                    if SelectSong == allsong.name {
                                        temp = allsong.num
                                    }
                                }
                                SelectNewSong = SelectSong
                                playmusic()
                                PlaySong = true
                                player.play()
                            }
                        }
                    } label: {
                        Image(systemName: "forward.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                    }
                    Button("歌詞"){
                        ShowLyricsPage = true
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 3))
                    .sheet(isPresented: $ShowLyricsPage){
                        LyricsView(SelectSong: $SelectSong)
                    }
                }
                .padding()
            }
            .foregroundColor(FontColor)
            .fontWeight(.bold)
            .navigationTitle("Taylor Swift")
        }
    }
    
    func playmusic() {
        let url = Bundle.main.url(forResource: SelectSong, withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
