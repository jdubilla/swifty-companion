//
//  LoadedContentView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 20/11/2023.
//

import SwiftUI

struct LoadedContentView: View {
    
    @Binding var username: String
    @Binding var showAlert: Bool
    @Binding var disabled: Bool
    @Binding var isUserSearch: Bool
    var request: APIRequest
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("assembly_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(.all)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                VStack(spacing: 20) {
                    TextField("Login", text: $username)
                        .padding()
                        .background(Color.white)
                        .clipShape(.rect(cornerRadius: 10))
                        .frame(width: 200)
                        .font(.title)
                        .multilineTextAlignment(.center)
                    Button("Rechercher") {
                        Task {
                            disabled = true
                            await request.fetchDataUser(username: username)
                            disabled = false
                            if request.user != nil {
                                isUserSearch = true
                            } else {
                                showAlert = true
                                username = ""
                            }
                        }
                    }
                    .disabled(username.isEmpty || request.token == nil || disabled)
                    .font(.system(size: 25))
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .alert("Erreur", isPresented: $showAlert) {
                    
                } message: {
                    Text("Utilisateur introuvable")
                }
                
            }
            .onAppear() {
                self.username = ""
                request.checkAndFetchTokenIfNeeded()
            }
        }
    }
}

//#Preview {
//    LoadedContentView()
//}
