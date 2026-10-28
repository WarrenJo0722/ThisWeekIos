//
//  UserViewModel.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/26/26.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

@Observable
class UserViewModel {
    var users: [User] = []
    var currentUserId: String?
    var currentUser: User? {
        users.first { $0.id == currentUserId }
    }
    
    @ObservationIgnored
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
    
    func findUser(id: String) -> User? {
        users.first { $0.id == id }
    }
    
    // MARK: - 인증
    
    func checkLogin() {
        currentUserId = Auth.auth().currentUser?.uid
    }
    
    // 파이어베이스 어센티케이션에 사용자 등록
    // 파이어스토어 유저 정보 등록
    func signUp(
        user: User,
        password: String,
        imageData: Data?,
        onSuccess: @escaping () -> Void = {},
        onFailure: @escaping (String) -> Void = { _ in }
    ) {
        Auth.auth().createUser(withEmail: user.email, password: password) { result, error in
            if let error {
                onFailure(error.localizedDescription)
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            guard let imageData else {
                self.saveProfile(uid: uid, user: user, onSuccess: onSuccess, onFailure: onFailure)
                return
            }
            
            // 사진 있으면
            let imageRef = Storage.storage().reference().child("profile/\(uid).jpg")
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            imageRef.putData(imageData, metadata: metadata) { _, error in
                if let error {
                    onFailure(error.localizedDescription)
                    return
                }
                imageRef.downloadURL { url, error in
                    guard let url else {
                        onFailure(error?.localizedDescription ?? "사진 주소를 받지 못 했습니다.")
                        return
                    }
                    var user = user
                    user.imageUrl = url.absoluteString
                    self.saveProfile(uid: uid, user: user, onSuccess: onSuccess, onFailure: onFailure)
                }
            }
        }
    }
    
    private func saveProfile(
        uid: String,
        user: User,
        onSuccess: @escaping () -> Void = {},
        onFailure: @escaping (String) -> Void = { _ in }
    ) {
        do {
            try Firestore.firestore()
                .collection("users")
                .document(uid)
                .setData(from: user) { error in
                    if let error {
                        onFailure(error.localizedDescription)
                    } else {
                        self.currentUserId = uid
                        onSuccess()
                    }
                }
        } catch {
            onFailure(error.localizedDescription)
        }
    }
    
    func login(
        email: String,
        password: String,
        onSuccess: @escaping () -> Void = {},
        onFailure: @escaping (String) -> Void = { _ in }
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                onFailure(error.localizedDescription)
                return
            }
            
            self.currentUserId = result?.user.uid
            
            onSuccess()
        }
    }
    
    func logout() {
        try? Auth.auth().signOut()
        currentUserId = nil
    }
}
