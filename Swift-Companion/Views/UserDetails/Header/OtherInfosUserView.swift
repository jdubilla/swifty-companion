//
//  OtherInfosUserView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 27/11/2023.
//

import SwiftUI

struct OtherInfosUserView: View {
    
    @Binding var request: APIRequest?
    @Binding var mainColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: 25)
            if let user = request?.user {
                HeaderUserInfoView(image: "person.fill", text: user.login, color: $mainColor)
                HeaderUserInfoView(image: "envelope.circle", text: user.email, color: $mainColor)
                HeaderUserInfoView(image: "dollarsign.circle.fill", text: "\(String(user.wallet)) ₳", color: $mainColor)
                HeaderUserInfoView(image: "pc", text: String(user.location ?? " Unavailable"), color: $mainColor)
            }
        }.frame(maxWidth: 240)
    }
}

//#Preview {
//    OtherInfosUserView()
//}
