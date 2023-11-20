//
//  ProjectListView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 19/11/2023.
//

import SwiftUI

struct ProjectListView: View {
    
    var project: ProjectsUsers
    var color: Color
    
    var body: some View {
        HStack {
            Text(project.project.name)
            Spacer()
            if (project.status == "finished") {
                if let final_mark = project.final_mark {
                    TextStatusProjectView(text: String(final_mark), color: .green)
                }
            } else if (project.status == "in_progress") {
                TextStatusProjectView(text: "En progression", color: .yellow)
            } else if (project.status == "searching_a_group") {
                TextStatusProjectView(text: "En recherche de groupe", color: .yellow)
            }  else if (project.status == "waiting_for_correction") {
                TextStatusProjectView(text: "En attente de correction", color: .yellow)
            }
        }
        .padding(4)
        .listRowSeparator(.hidden)
        .background(project.status == "finished" ? Color(hex: "#32CD32").opacity(0.1) : color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

//#Preview {
//    ProjectListView()
//}
