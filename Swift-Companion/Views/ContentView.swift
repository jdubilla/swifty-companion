//
//  ContentView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 15/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var oAuth: OAuthManager = OAuthManager()

    var body: some View {
        if !oAuth.isAuthenticated {
            AuthenticatedView(oAuth: $oAuth)
        } else {
            IsAuthenticatedView(oAuth: $oAuth)
        }
    }
}

#Preview {
    ContentView()
}
