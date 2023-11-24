//
//  ProjectUserView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 19/11/2023.
//

import SwiftUI

struct ProjectsUserView: View {
    
    @Binding var color: Color
    @Binding var request: APIRequest?
    
    @State var indexPicker = 0
    @State var maxCursusId: Int = 0
    
    var projectsStatus = ["Finished", "Others"]
    var projectsStatusTranslate = ["Finis", "En cours"]
    
    var body: some View {
        SectionUserView(text: "Projets", color: $color)
        VStack(spacing: 0) {
            Picker(projectsStatus[indexPicker], selection: $indexPicker) {
                ForEach(0..<projectsStatus.count, id: \.self) { i in
                    Text(projectsStatusTranslate[i])
                        .fontWeight(.bold)
                }
            }
            .pickerStyle(.segmented)
            .background(color)
            .clipShape(RoundedCorner(radius: 5))
            .padding(.horizontal)
            if let projects = request?.user?.projects_users {
                ScrollView(.vertical) {
                    ForEach(projects) { project in
                        if (indexPicker == 0 &&
                            project.status == "finished" &&
                            project.cursus_ids.contains(maxCursusId)) {
                            ProjectListView(project: project, color: color)
                        } else if (indexPicker == 1 &&
                                   project.status != "finished" &&
                                   project.cursus_ids.contains(maxCursusId)) {
                            ProjectListView(project: project, color: color)
                        }
                    }
                }.padding(.top)
            }
        }
        .onAppear() {
            maxCursusId = request?.user!.cursus_users.last?.cursus_id ?? 0
            maxCursusId = maxCursusId > 21 ? 21 : maxCursusId
        }
        .padding()
        .frame(maxHeight: 300)
    }
}

