//
//  DatabaseManager.swift
//  FitnessApp
//
//  Created by Djordje Mitrovic on 3.4.25..
//

import Foundation
import FirebaseFirestore


class DatabaseManager{
    
    static let shared = DatabaseManager()
    
    private init(){}
    
    let database = Firestore.firestore()
    
    //Fetch leaderboards
    func fetchLaederboards() async throws{
        let snapshot = try await database.collection("-leaderboard").getDocuments()
        
        print(snapshot.documents)
        print(snapshot.documents.first?.data())
    }
    
    //Post leaderboards update
    func postStepCountUpdateFor(userID: String, stepCount: Int) async throws{
        try await database.collection("-leaderboard").document(userID).setData(["stepCount": stepCount])
    }
    
}
