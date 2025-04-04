import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Welcome")
                        .font(.largeTitle)
                        .padding()
                    
                    HStack {
                        Spacer()
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Calories")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.red)
                                Text("\(viewModel.calories) kcal")
                                    .bold()
                            }
                            .padding()
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Active")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.green)
                                Text("\(viewModel.active) min")
                                    .bold()
                            }
                            .padding()
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Stand")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.blue)
                                Text("\(viewModel.stand) hr") // Fixed to use 'stand' instead of 'active'
                                    .bold()
                            }
                            .padding()
                        }
                        Spacer()
                        
                        ZStack {
                            ProgressCircleView(progress: $viewModel.calories, color: .red, goal: 600)
                            ProgressCircleView(progress: $viewModel.active, color: .green, goal: 60)
                                .padding(.all, 20)
                            ProgressCircleView(progress: $viewModel.stand, color: .blue, goal: 12) // Adjusted goal to 12 for stand hours
                                .padding(.all, 40)
                        }
                        .frame(width: 150, height: 150) // Fixed size for better layout
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Text("Fitness Activity")
                            .font(.title2)
                        Spacer()
                        Button {
                            print("show more")
                        } label: {
                            Text("Show more")
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(20)
                        }
                    }
                    .padding()
                    
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                        ForEach(viewModel.mockActivities, id: \.id) { activity in
                            ActivityCard(activity: activity)
                        }
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Recent Workout")
                            .font(.title2)
                        Spacer()
                        NavigationLink {
                            EmptyView() // Placeholder for future detail view
                        } label: {
                            Text("Show more")
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(20)
                        }
                    }
                    .padding()
                    .padding(.top)
                    
                    LazyVStack {
                        ForEach(viewModel.mockWorkouts, id: \.id) { workout in
                            WorkoutCard(workout: workout)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
