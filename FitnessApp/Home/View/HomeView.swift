//
//  HomeView.swift
//  FitnessApp
//
//  Created by Djordje Mitrovic on 27.3.25..
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading){
                    Text("Desi be")
                        .font(.largeTitle)
                        .padding()
                    
                    HStack{
                        Spacer()
                        VStack(alignment: .leading) {
                            VStack(alignment: .leading, spacing: 8){
                                Text("Calories")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.red)
                                
                                Text("\(viewModel.calories)")
                                    .bold()
                            }.padding()
                            
                            
                            VStack(alignment: .leading, spacing: 8){
                                Text("Active")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.green)
                                
                                Text("\(viewModel.active)")
                                    .bold()
                            }.padding()
                            
                            VStack(alignment: .leading, spacing: 8){
                                Text("Stand")
                                    .font(.callout)
                                    .bold()
                                    .foregroundColor(.blue)
                                
                                Text("\(viewModel.active)")
                            }.padding()
                            
                        }
                        Spacer()
                        
                        ZStack{
                            ProgressCircleView(progress: $viewModel.calories, color: .red, goal: 600)
                            ProgressCircleView(progress: $viewModel.active, color: .green, goal: 60)
                                .padding(.all, 20)
                            ProgressCircleView(progress: $viewModel.stand, color: .blue, goal: 600)
                                .padding(.all, 40)
                        }
                        .padding(.horizontal)
                        Spacer()
                    }.padding()
                    
                    HStack{
                        Text("Fitness Activity")
                            .font(.title2)
                        
                        Spacer()
                        
                        Button{
                            print("show more")
                        } label: {
                            Text("Show more")
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(20)
                        }
                    }.padding()
                    LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)){
                        ForEach(viewModel.mockActivities, id: \.id ){ activity in
                            ActivityCard(activity: activity)
                        }
                        
                    }.padding(.horizontal)
                    HStack{
                        Text("Recent Workout")
                            .font(.title2)
                        
                        Spacer()
                        
                        NavigationLink{
                            EmptyView()
                        }label:{
                            Text("Show more")
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(20)
                        }
                    }.padding()
                        .padding(.top)
                    
                    LazyVStack{
                        ForEach(viewModel.MockWorkouts, id: \.id ){ workout in
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
