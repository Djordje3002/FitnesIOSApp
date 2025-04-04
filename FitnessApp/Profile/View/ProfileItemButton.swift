//
//  ProfileItemButton.swift
//  FitnessApp
//
//  Created by Djordje Mitrovic on 31.3.25..
//

import SwiftUI

struct ProfileItemButton: View {
    
    @State var title: String
    @State var backgroundColor: Color
    @State var titleColor: Color
    @State var action: (() -> Void)
    
    var body: some View {
        Button{
            withAnimation{
                action()
            }
        }label: {
            Text(title)
                .foregroundColor(titleColor)
                .padding()
                .frame(maxWidth: 200)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(backgroundColor)
                )
        }
    }
}

#Preview {
    ProfileItemButton(title: "kasnije", backgroundColor: .gray.opacity(0.1), titleColor: .red){}
}
