//
//  ProjectUserView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 19/11/2023.
//

import SwiftUI

struct ProjectsUserView: View {
    
    @Binding var color: Color?
    @Binding var request: APIRequest
    
    @State var indexPicker = 0
    
    var projectsStatus = ["Finished", "Others"]
    
    var body: some View {
        SectionUserView(text: "Projets", color: $color)
//        Spacer().frame(height: 10)
        VStack(spacing: 0) {
            Picker(projectsStatus[indexPicker], selection: $indexPicker) {
                ForEach(0..<projectsStatus.count, id: \.self) { i in
                    Text(projectsStatus[i])
                        .fontWeight(.bold)
                }
            }
            .pickerStyle(.segmented)
            .background(color ?? .white)
            .clipShape(RoundedCorner(radius: 5))
            .padding(.horizontal)
            if let projects = request.user?.projects_users {
//                List(0..<projects.count, id: \.self) { index in
                ScrollView(.vertical) {
                    
                ForEach(projects) { project in
                    if (indexPicker == 0 &&
                        project.status == "finished" &&
                        project.cursus_ids.contains(21)) {
                        ProjectListView(project: project, color: color ?? .orange)
                    } else if (indexPicker == 1 &&
                               project.status != "finished" &&
                               project.cursus_ids.contains(21)) {
                        ProjectListView(project: project, color: color ?? .orange)
                    }
                }
                }.padding(.top)


//                }.listStyle(.plain)
            }
        }
        .padding()
        .frame(maxHeight: 300)
    }
}

#Preview {
    ProjectsUserView(color: .constant(Color.purple), request: .constant(APIRequest()))
}
