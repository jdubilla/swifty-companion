//
//  SkillsUserView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 20/11/2023.
//

import SwiftUI

struct SkillsUserView: View {
    
    @Binding var color: Color?
    @Binding var request: APIRequest
    
    var body: some View {
        Spacer().frame(height: 10)
        SectionUserView(text: "Skills", color: $color)
    }
}

//#Preview {
//    SkillsUserView()
//}
