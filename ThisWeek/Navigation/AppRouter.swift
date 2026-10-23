//
//  AppRouter.swift
//  ThisWeek
//
//  Created by Kihwan Jo on 10/23/26.
//

import SwiftUI

enum Route: Hashable {
    case main
    case admin
}

struct AppRouter: View {
    @State private var path: [Route] = []
    @State private var matchViewModel = MatchViewModel()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .topTrailing) {
                // 인트로 화면
                IntroView() {
                    path.append(.main)
                }
                
                // 관리자 투명 화면
                Button {
                    path.append(.admin)
                } label: {
                    Label("관리자", systemImage: "person")
                }
                .tint(.blue)
                .padding()
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .main:
                    MainView()
                case .admin:
                    AdminView()
                }
            }
        }
        .environment(matchViewModel)
    }
}

#Preview {
    AppRouter()
}
