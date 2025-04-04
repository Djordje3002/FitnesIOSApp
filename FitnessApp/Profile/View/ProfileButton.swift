//
//  ProfileButton.swift
//  FitnessApp
//
//  Created by Djordje Mitrovic on 27.3.25..
//

import SwiftUI

struct ProfileButton: View {
    
    @State var title: String
    @State var image: String
    @State var action: (() -> Void)
    
    var body: some View {
        Button{
            action()
        } label: {
            HStack{
                Image(systemName: image)
                
                Text(title)
            }
            .foregroundColor(.primary)
        }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ProfileButton(title: "Edit image", image: "square.and.pencil"){}
}
