//
//  ActivityCard.swift
//  FitnessApp
//
//  Created by Djordje Mitrovic on 27.3.25..
//

import SwiftUI

struct ActivityCard: View {
    
    @State var activity: Activity
    
    var body: some View {
        ZStack{
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            
            VStack{
                HStack(alignment: .top){
                    VStack(alignment: .leading, spacing: 8){
                        Text(activity.title)
                            .lineLimit(1)
                            
                        
                        Text(activity.subtitle)
                            .font(.caption)
                        }
                        Spacer()
                        
                    Image(systemName: activity.image)
                        .foregroundColor(activity.titntColor)
                }
                
                Text(activity.amount)
                    .font(.title)
                    .bold()
            }
            .padding()
        }
    }
}

#Preview {
    ActivityCard(activity: Activity(id: 0, title: "Steps bro", subtitle: "Big nigga", image: "figure.walk", titntColor: .green, amount: "12,432"))
}
