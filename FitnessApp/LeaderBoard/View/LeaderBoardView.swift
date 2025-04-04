//
//  LeaderBoardView.swift
//  FitnessApp
//
//  Created by Djordje Mitrovic on 27.3.25..
//

import SwiftUI

struct LeaderBoardUser: Codable, Identifiable{
    let id: Int
    let username: String
    let count: Int
}

class LeaderBoardViewModel: ObservableObject{
    
    var mockData = [
        LeaderBoardUser(id: 0, username: "maihajlo", count: 1234),
        LeaderBoardUser(id: 1, username: "jovan", count: 345),
        LeaderBoardUser(id: 2,  username: "milos", count: 234567),
        LeaderBoardUser(id: 3,  username: "mirko", count: 113),
        LeaderBoardUser(id: 4,  username: "milan", count: 234),
        LeaderBoardUser(id: 5,  username: "biljana", count: 8),
        LeaderBoardUser(id: 6,  username: "maihajlo", count: 1234),
        LeaderBoardUser(id: 7,  username: "jovan", count: 345),
        LeaderBoardUser(id: 8,  username: "milos", count: 234567),
        LeaderBoardUser(id: 9,  username: "mirko", count: 113),
        LeaderBoardUser(id: 10,  username: "milan", count: 234),
        LeaderBoardUser(id: 11, username: "biljana", count: 8)
    ]
    
}

struct LeaderBoardView: View {
    
    @StateObject var viewModel = LeaderBoardViewModel()
    
    @State var showTerms = true
    
    var body: some View {
        VStack{
            Text("Leaderboards")
                .font(.largeTitle)
                .bold()
            
            HStack{
                Text("Name")
                    .bold()
                
                Spacer()
                
                Text("Steps")
                    .bold()
            }
            .padding()
            
            LazyVStack(spacing: 16){
                ForEach(viewModel.mockData){ person in
                    HStack{
                        Text("\(person.id)")
                        
                        Text(person.username)
                        
                        Spacer()
                        
                        Text("\(person.count)")
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .fullScreenCover(isPresented: $showTerms) {
            TermsView()
        }
        .task{
            do{
                try await DatabaseManager.shared.fetchLaederboards()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    LeaderBoardView()
}
