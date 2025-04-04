import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()

    var body: some View {
        VStack {
            // Profile Header
            HStack(spacing: 16) {
                Image(viewModel.selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(.gray.opacity(0.15)))
                    .onTapGesture {
                        viewModel.presentEditImage()
                    }

                VStack(alignment: .leading) {
                    Text("Good morning,")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                        .minimumScaleFactor(0.5)

                    Text(viewModel.currentName)
                        .font(.title)
                }
            }

            // Name Editing
            if viewModel.isEditingName {
                TextField("Name...", text: $viewModel.currentName)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke())

                HStack {
                    ProfileItemButton(title: "Cancel", backgroundColor: .gray.opacity(0.1), titleColor: .red) {
                        withAnimation { viewModel.dismissEdit() }
                    }

                    ProfileItemButton(title: "Done", backgroundColor: .primary, titleColor: .white) {
                        withAnimation {
                            if !viewModel.currentName.isEmpty {
                                viewModel.editName()
                            }
                        }
                    }
                }
                .padding(.bottom)
            }

            // Image Editing
            if viewModel.isEditingImage {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.images, id: \.self) { image in
                            Button {
                                withAnimation { viewModel.selectImage(image: image) }
                            } label: {
                                VStack {
                                    Image(image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)

                                    if viewModel.selectedImage == image {
                                        Circle()
                                            .frame(width: 16, height: 16)
                                            .foregroundColor(.primary)
                                    }
                                }
                                .padding()
                            }
                        }
                    }
                }

                HStack {
                    ProfileItemButton(title: "Cancel", backgroundColor: .gray.opacity(0.1), titleColor: .red) {
                        withAnimation { viewModel.dismissEdit() }
                    }

                    ProfileItemButton(title: "Done", backgroundColor: .primary, titleColor: .white) {
                        withAnimation { viewModel.saveSelectedImage() }
                    }
                }
                .padding(.bottom)
            }

            // Edit Options
            VStack {
                ProfileButton(title: "Edit name", image: "square.and.pencil") {
                    withAnimation {
                        viewModel.presentEditName()
                    }
                }

                ProfileButton(title: "Edit image", image: "square.and.pencil") {
                    withAnimation {
                        viewModel.presentEditImage()
                    }
                }
            }
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.15)))

            // Other Options
            VStack(alignment: .leading) {
                ProfileButton(title: "Contact Us", image: "envelope") {
                    viewModel.presentEmailApp()
                }
                
                Link(destination: URL(string: "https://www.wikipedia.org")!){
                    HStack{
                        Image(systemName: "doc")
                        
                        Text("Privacy Policy")
                    }
                    .foregroundColor(.primary)
                } .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)

                Link(destination: URL(string: "https://iman-gadzhi.com")!){
                    HStack{
                        Image(systemName: "doc")
                        
                        Text("Terms of Service")
                    }
                    .foregroundColor(.primary)
                } .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.15)))
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

#Preview {
    ProfileView()
}

