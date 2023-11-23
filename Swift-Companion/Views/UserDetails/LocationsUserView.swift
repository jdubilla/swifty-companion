//
//  LocationsUserView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 23/11/2023.
//

import SwiftUI

struct LocationsUserView: View {
    
    @Binding var color: Color
    @Binding var request: APIRequest?
    
    var body: some View {
        SectionUserView(text: "Locations", color: $color)
        if let locations = request?.locations {
            ForEach(locations, id: \.self) { location in
                Text(location.begin_at)
                Text(location.end_at)
                Text(location.host)
            }
        }
    }
}

//#Preview {
//    LocationsUserView()
//}
