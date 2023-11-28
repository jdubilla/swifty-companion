//
//  SecondeView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 15/11/2023.
//

import SwiftUI
import UIKit
import WebKit

struct UserDetails: View {
    
    @Binding var isUserSearch: Bool
    @Binding var request: APIRequest?
    
    @State var mainColor: Color = .orange
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(isUserSearch: $isUserSearch, request: $request, mainColor: $mainColor)
            UserLevelBarView(color: $mainColor, request: $request)
            ScrollView(.vertical) {
                ProjectsUserView(color: $mainColor, request: $request)
                SkillsUserView(color: $mainColor, request: $request)
                LocationsUserView(color: $mainColor, request: $request)
                AchievementsView(color: $mainColor, request: $request)
            }
        }
        .ignoresSafeArea(.all)
        .onAppear() {
            if let color = request?.coalitions?.last?.color {
                mainColor = Color(hex: color)
            } else {
                mainColor = Color.orange
            }
        }
    }
}

//#Preview {
//    UserDetails(isUserSearch: .constant(true), request: .constant(APIRequest()))
//}

