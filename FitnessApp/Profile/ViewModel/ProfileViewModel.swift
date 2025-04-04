import SwiftUI
import Foundation

class ProfileViewModel: ObservableObject {
    @Published var isEditingName = false
    @Published var isEditingImage = false
    @Published var currentName: String = UserDefaults.standard.string(forKey: "profileName") ?? "Name"
    @Published var selectedImage: String = UserDefaults.standard.string(forKey: "profileImage") ?? "avatar1"

    let images = ["avatar1", "avatar2", "avatar3", "avatar4", "avatar5"]

    func presentEditName() {
        isEditingName = true
        isEditingImage = false
    }

    func presentEditImage() {
        isEditingName = false
        isEditingImage = true
    }

    func dismissEdit() {
        isEditingName = false
        isEditingImage = false
    }

    func editName() {
        UserDefaults.standard.setValue(currentName, forKey: "profileName")
        dismissEdit()
    }

    func selectImage(image: String) {
        selectedImage = image
    }

    func saveSelectedImage() {
        UserDefaults.standard.setValue(selectedImage, forKey: "profileImage")
        dismissEdit()
    }
    
    func presentEmailApp() {
        let emailSubject = "Contact Djoleta"
        let emailRecipient = "djkartaljevic@gmail.com"

        guard let encodedEmailSubject = emailSubject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let encodedEmailRecipient = emailRecipient.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "mailto:\(encodedEmailRecipient)?subject=\(encodedEmailSubject)") else {
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

