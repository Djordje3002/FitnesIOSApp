import SwiftUI

struct FitnessTabView: View {
    
    @State var selectedtTab = "Home"
    
    init(){
        let appereance = UITabBarAppearance()
        appereance.configureWithOpaqueBackground()
        appereance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green]
        appereance.stackedLayoutAppearance.selected.iconColor = .green
        
        UITabBar.appearance().scrollEdgeAppearance = appereance
    }
    
    var body: some View {
        TabView(selection: $selectedtTab){
            HomeView()
                .tag("Home")
                .tabItem{
                    Image(systemName: "house")
                    
                    Text("Home")
                }
            
            ChartsView()
                .tag("Historic")
                .tabItem{
                    Image(systemName: "chart.bar")
                    
                    Text("Charts")
                }
            
            LeaderBoardView()
                .tag("LeaderBoard")
                .tabItem{
                    Image(systemName: "list.bullet")
                    
                    Text("LeaderBoard")
                }
            
            ProfileView()
                .tag("ProfileView")
                .tabItem{
                    Image(systemName: "person")
                    
                    Text("Profile")
                }
        }
    }
}

#Preview {
    FitnessTabView()
}
