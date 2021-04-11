//
//  RankView.swift
//  SpellingGame
//
//  Created by Chase on 2021/4/8.
//

import SwiftUI

struct RankView: View {
    @EnvironmentObject var appSettings: AppSettings
    @EnvironmentObject var gameSettings: GameSettings
    @EnvironmentObject var storesData: RecordsData
    var body: some View {
        ZStack(alignment: .center){
            Image("rankbackground")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                backBtn()
            }, label: {
                Image("undo")
                    .resizable()
                    .frame(width: 40, height: 40)
            }).position(x: 60, y: 30)
            ZStack{
                Color.init(red: 54/255, green: 45/255, blue: 25/255).frame(width: 500, height: 390).cornerRadius(30)
                ScrollView{
                    VStack{
                        ForEach(0..<storesData.records.count, id: \.self){index in
                            RecordRow(index: index)
                                .environmentObject(storesData)
                                .padding(5)
                        }
                    }
                }.frame(width: 400, height: 390).cornerRadius(30)
            }.frame(width: 400, height: 390).cornerRadius(30)
            
            /*Button(action: {
                storesData.records.removeAll()
            }, label: {
                Image("delete")
                    .resizable()
                    .frame(width: 50, height: 50)
            }).position(x: gameSettings.geometry_size_width * 0.9, y: gameSettings.geometry_size_height * 0.9)*/
        }.edgesIgnoringSafeArea(.all)
    }
    
    func backBtn() {
        appSettings.isRankView = false
        appSettings.clickPlayer.playFromStart()
    }
    
}

struct RecordRow: View {
    @State var index: Int
    @EnvironmentObject var storesData: RecordsData
    var body: some View {
        HStack(alignment: .center) {
            Text("\(index + 1)")
                .bold()
                .frame(width: 50, height: 50)
                .font(Font.system(size: 30))
                .foregroundColor(.black)
                .background(Color.red)
            
            Text("\(storesData.records[index].name)")
                .bold()
                .padding(.leading,2)
                .font(Font.system(size: 30))
            Spacer()
            Text("\(storesData.records[index].time)")
                .padding(.trailing,5)
                .font(Font.system(size: 25))
        }
        .frame(width: 300, height: 50)
        .background(Color.yellow)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

class RecordsData: ObservableObject {
    @AppStorage("records") var recordsData: Data?
    
    @Published var records = [Record]() {
        didSet {
            let encoder = JSONEncoder()
            do {
                recordsData = try encoder.encode(records)
            } catch {
                print(error)
            }
        }
    }
    
    init() {
        if let recordsData = recordsData {
            let decoder = JSONDecoder()
            do {
                records = try decoder.decode([Record].self, from: recordsData)
            } catch  {
                print(error)
            }
        }
    }
    
}

struct Record:Identifiable, Codable {
    var id = UUID()
    var name: String
    var time: String
    var time_num: Double
}
