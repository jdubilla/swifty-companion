//
//  SkillsUserView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 20/11/2023.
//

import SwiftUI
import Charts

struct SkillsUserView: View {
    
    @Binding var color: Color
    @Binding var request: APIRequest?
    
    var body: some View {
        Spacer().frame(height: 10)
        SectionUserView(text: "Skills", color: $color)
        
        ScrollView(.horizontal) {
            HStack {
                if let skills = request?.user?.cursus_users[1].skills {
                    Chart {
                        ForEach(skills, id: \.self) { skill in
                            BarMark(x: .value("Type", skill.name), y: .value("Level", Int(skill.level)))
                                .annotation {
                                    Text("\(skill.level, specifier: "%.2f")\n(\((skill.level / 20) * 100, specifier: "%.2f")%)")
                                        .font(.caption)
                                        .foregroundStyle(Color.gray)
                                        .multilineTextAlignment(.center)
                                }
                                .foregroundStyle(color)
                        }
                    }
                    .chartYScale(domain: 0...21)
                }
            }.frame(minWidth: 1000, minHeight: 200)
            
        }
        .padding()
    }
}

//#Preview {
//    SkillsUserView()
//}
