//
//  LeaderboardViewModel.swift
//  FitnessApp
//
//  Created by Djordje Mitrovic on 7.4.25..
//

import Foundation

import Foundation

struct LeaderBoardUser: Codable, Identifiable {
    let id: Int
    let username: String
    let count: Int
}

@MainActor
class LeaderBoardViewModel: ObservableObject {
    @Published var mockData: [LeaderBoardUser] = []
    
    func fetchLeaderboardData() async throws {
        let users = try await DatabaseManager.shared.fetchLeaderboardData()
        self.mockData = users
    }
}
