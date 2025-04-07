import SwiftUI

struct LeaderBoardView: View {
    
    @StateObject var viewModel = LeaderBoardViewModel()
    @State var showTerms = false
    
    var body: some View {
        VStack {
            Text("Leaderboards")
                .font(.largeTitle)
                .bold()
            
            HStack {
                Text("Name")
                    .bold()
                Spacer()
                Text("Steps")
                    .bold()
            }
            .padding()
            
            LazyVStack(spacing: 16) {
                ForEach(viewModel.mockData) { person in
                    HStack {
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
        .task {
            do {
                guard let name = UserDefaults.standard.string(forKey: "username") else {
                    showTerms = true
                    return
                }
                let steps = try await HealthManager.shared.fetchTodayStepsAsync()
                try await DatabaseManager.shared.postUserToLeaderboard(userID: name, stepCount: steps)
                try await viewModel.fetchLeaderboardData()
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
#Preview {
    LeaderBoardView()
}
