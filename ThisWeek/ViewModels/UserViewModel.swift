//
//  UserViewModel.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/26/26.
//

import SwiftUI
import FirebaseFirestore

@Observable
class UserViewModel {
    var users: [User] = []
    var currentUserId: String?
    var currentUser: User? {
        users.first { $0.id == currentUserId }
    }
    
    private var listener: ListenerRegistration?
    
    func listenUsers() {
        guard listener == nil else { return }
        listener = Firestore.firestore()
            .collection("users")
            .addSnapshotListener { snapshot, error in
                guard let snapshot else {
                    print("회원 목록 불러오기 실패: \(error?.localizedDescription ?? "")")
                    return
                }
                self.users = snapshot.documents.compactMap { doc in
                    try? doc.data(as: User.self)
                }
            }
    }
    
    func selectUser(user: User) {
        currentUserId = user.id
    }
    
    func addUser(
        user: User,
        onSuccess: @escaping () -> Void = {},
        onFailure: @escaping (String) -> Void = { _ in }
    ) {
        do {
            try Firestore.firestore()
                .collection("users")
                .addDocument(from: user) { error in
                    if let error {
                        onFailure(error.localizedDescription)
                    } else {
                        onSuccess()
                    }
                }
        } catch {
            onFailure(error.localizedDescription)
        }
    }
    
    func deleteUser(user: User) {
        guard let id = user.id else { return }
        Firestore.firestore().collection("users").document(id)
            .delete()
        if currentUserId == id {
            currentUserId = nil
        }
    }
}
