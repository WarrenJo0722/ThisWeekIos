//
//  MatchViewModel.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/23/26.
//

import SwiftUI
import FirebaseFirestore

enum MatchPhase {
    case apply
    case waiting
    case matched
}

@Observable
class MatchViewModel {
    var apps: [Application] = []
    
    var week = 1
    
    @ObservationIgnored
    private var listener: ListenerRegistration?
    
    func listenApps() {
        guard listener == nil else { return }
        listener = Firestore.firestore()
            .collection("applications")
            .addSnapshotListener { snapshot, error in
                guard let snapshot else {
                    print("신청 목록 불러오기 실패: \(error?.localizedDescription ?? "")")
                    return
                }
                self.apps = snapshot.documents.compactMap { doc in
                    try? doc.data(as: Application.self)
                }
            }
    }
    
    func phase(userId: String) -> MatchPhase {
        guard let app = findApp(userId: userId) else {
            return .apply
        }
        if app.matchId.isEmpty {
            return .waiting
        }
        return .matched
    }
    
    func findApp(userId: String) -> Application? {
        apps.first { $0.userId == userId }
    }
    
    func findPartnerApp(myApp: Application) -> Application? {
        guard !myApp.matchId.isEmpty else { return nil }
        return apps.first {
            $0.matchId == myApp.matchId
            && $0.userId != myApp.userId
        }
    }
    
    func apply(
        userId: String,
        weekday: Weekday,
        place: Place,
        onSuccess: @escaping () -> Void = {},
        onFailure: @escaping (String) -> Void = { _ in }
    ) {
        let app = Application(
            userId: userId,
            week: week,
            weekday: weekday,
            place: place
        )
        
        do {
            try Firestore.firestore()
                .collection("applications")
                .document("\(week)_\(userId)")
                .setData(from: app) { error in
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
    
    func match(
        male: Application,
        female: Application,
        onSuccess: @escaping () -> Void = {},
        onFailure: @escaping (String) -> Void = { _ in }
    ) {
        let db = Firestore.firestore()
        let matchId = "\(week)_\(male.userId)_\(female.userId)"
        
        let match = Match(
            week: week, user1id: male.userId, user2id: female.userId, place: male.place, weekday: male.weekday
        )
        
        // Match 정보 저장
        // 남성 신청서에 matchId 업데이트
        // 여성 신청서에 matchId 업데이트
        let batch = db.batch()
        // add: 없던 것 새로 더할 때 : 생성, 추가
        // set: 기존에 있던 것을 통째로 바꿀 때 / 만약 기존 것이 없으면 새로 추가함.
        // update: 객체 안에 있는 필드 하나만 추가하거나 업데이트 할때
        do {
            try batch.setData(from: match, forDocument: db.collection("matches").document(matchId))
        } catch {
            onFailure(error.localizedDescription)
            return
        }
        batch.updateData(["matchId": matchId], forDocument: db.collection("applications").document("\(week)_\(male.userId)"))
        batch.updateData(["matchId": matchId], forDocument: db.collection("applications").document("\(week)_\(female.userId)"))
        batch.commit { error in
            if let error {
                onFailure(error.localizedDescription)
            } else {
                onSuccess()
            }
        }
    }
}
