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
            if (project.status == "finished" &&
                project.validated != nil && project.validated == false) {
                if let final_mark = project.final_mark {
                    TextStatusProjectView(text: String(final_mark), color: .red)
                }
            } else if (project.status == "finished") {
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
        .background(getBackgroundColor())
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
    func getBackgroundColor() -> Color {
        if (project.status == "finished" && project.validated == true) {
            return Color(hex: "#32CD32").opacity(0.1)
        } else if (project.status == "finished" && project.validated == false) {
            return Color.red.opacity(0.1)
        } else {
            return color.opacity(0.1)
        }
    }
}

//#Preview {
//    ProjectListView()
//}
