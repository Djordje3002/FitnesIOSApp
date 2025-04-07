import Foundation
import FirebaseFirestore

class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private init() {}
    
    let database = Firestore.firestore()
    
    // Fetch leaderboards
    func fetchLeaderboardData() async throws -> [LeaderBoardUser] {
        let snapshot = try await database.collection("-leaderboard").getDocuments()
        return snapshot.documents.compactMap { doc in
            let data = doc.data()
            guard let stepCount = data["stepCount"] as? Int else { return nil }
            return LeaderBoardUser(id: doc.documentID.hashValue, username: doc.documentID, count: stepCount)
        }.sorted(by: { $0.count > $1.count })
    }
    
    // Save or update leaderboard step count
    func postUserToLeaderboard(userID: String, stepCount: Int) async throws {
        try await database.collection("-leaderboard").document(userID).setData([
            "stepCount": stepCount
        ])
    }
}

