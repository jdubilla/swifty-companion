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
    @Binding var request: APIRequest
    
    
    @State var mainColor: Color?
    
    var body: some View {

        VStack(spacing: 0) {
                HeaderView(isUserSearch: $isUserSearch, request: $request, mainColor: $mainColor)
                
                UserLevelBarView(color: $mainColor, request: $request)
            ScrollView(.vertical) {

                ProjectsUserView(color: $mainColor, request: $request)
                SkillsUserView(color: $mainColor, request: $request)
//                SkillsUserView(color: $mainColor, request: $request)
//                Spacer()
            }

            }
        .ignoresSafeArea(.all)
        .onAppear() {
            mainColor = Color(hex: request.coalitions?[1].color ?? "")
        }
    }
}

//#Preview {
//    UserDetails(isUserSearch: .constant(true), request: .constant(APIRequest()))
//}

