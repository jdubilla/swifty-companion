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
            
            ZStack {
                Image("background42")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(.all)
                VStack {
                    if !isAuthenticated {
                        Button {
                            showSafari = true
                        } label: {
                            Text("Se connecter avec")
                            Image("42_Logo")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        .buttonStyle(.borderedProminent)
                        .font(.system(size: 20))
                        .sheet(isPresented: $showSafari) {
                            SafariView(receivedCode: $receivedCode)
                        }
                        .onChange(of: receivedCode) { oldValue, newValue in
                            if let code = newValue {
                                showSafari = false
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
        }
    }
}

//#Preview {
//    AuthenticatedView()
//}
