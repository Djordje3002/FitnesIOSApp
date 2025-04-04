//
//  ChartDataView.swift
//  FitnessApp
//
//  Created by Djordje Mitrovic on 2.4.25..
//

import SwiftUI

struct ChartDataView: View {
    
    @State var average: Int
    @State var total: Int
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 16) {
                Text("Average: ")
                    .font(.title2)
                Text("\(average)")
            }
            .padding()
            .background(.gray.opacity(0.1))
            .cornerRadius(10)
            
            Spacer()
            
            VStack(spacing: 16){
                Text("Total: ")
                    .font(.title2)
                Text("\(total)")
            }
            .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(10)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

#Preview {
    ChartDataView(average: 123, total: 1234)
}
