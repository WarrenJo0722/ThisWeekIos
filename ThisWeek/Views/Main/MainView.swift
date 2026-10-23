//
//  MainView.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/22/26.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            MatchTabView()
                .tabItem {
                    Label("매칭", systemImage: "calendar")
                }
            Text("대화방 화면")
                .tabItem {
                    Label("대화", systemImage: "bubble.left.and.bubble.right")
                }
            Text("마이페이지 화면")
                .tabItem {
                    Label("마이", systemImage: "person")
                }
        }
    }
}

#Preview {
    MainView()
}
