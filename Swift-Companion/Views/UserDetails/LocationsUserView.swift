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
    var isPortraitMode: Bool
    
    var body: some View {
        VStack {
            SectionUserView(text: "Locations", color: $color)
            if let locations = request?.locations, locations.count > 0 {
                List(locations, id: \.self) { location in
                    HStack {
                        Text(formatDate(dateString: location.begin_at))
                        Text(location.host.capitalized)
                        Spacer()
                        if let endAt = location.end_at {
                            Text(calculateHourDifference(beginDateString: location.begin_at,endDateString: endAt))
                        } else {
                            Text("Session en cours")
                        }
                    }.padding(EdgeInsets(top: 4, leading: isPortraitMode ? 35 : 0, bottom: 4, trailing: isPortraitMode ? 35 : 0))

                }.listStyle(.plain)
            } else {
                Text("Rien à afficher 😢")
            }
            
        }.frame(minHeight: 300)
    }
    
    func calculateHourDifference(beginDateString: String, endDateString: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        guard let beginDate = dateFormatter.date(from: beginDateString),
              let endDate = dateFormatter.date(from: endDateString) else {
            return ""
        }

        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: beginDate, to: endDate)

        if let hours = components.hour, let minutes = components.minute {
            if hours > 0 {
                return "\(hours)h\(minutes)min"
            } else {
                return "\(minutes)min"
            }
        } else {
            return ""
        }
    }
    
    func formatDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM"
            return outputFormatter.string(from: date)
        }
        
        return ""
    }
}
