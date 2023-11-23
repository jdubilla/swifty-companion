//
//  AuthenticatedView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 23/11/2023.
//

import SwiftUI

struct AuthenticatedView: View {
    @State var showSafari = false
    @State var receivedCode: String?
    @State var isAuthenticated = false
    
    @Binding var oAuth: OAuthManager
    
    var body: some View {
        NavigationStack {
            VStack {
                if !isAuthenticated {
                    Button("Se connecter avec 42") {
                        showSafari = true
                    }
                    .sheet(isPresented: $showSafari) {
                        SafariView(receivedCode: $receivedCode)
                    }
                    .onChange(of: receivedCode) { oldValue, newValue in
                        if let code = newValue {
                            showSafari = false
//                            print("Code reçu: \(code)")
                            Task {
                                await oAuth.getToken(code: code)
                                showSafari = false
                                isAuthenticated = true
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Test")
    }
}

//#Preview {
//    AuthenticatedView()
//}
