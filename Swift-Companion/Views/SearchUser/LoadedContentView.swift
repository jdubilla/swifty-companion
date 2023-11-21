//
//  LoadedContentView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 20/11/2023.
//

import SwiftUI

struct LoadedContentView: View {
    
    @Binding var isUserSearch: Bool
    var request: APIRequest
    
    @State var disabled = false
    @State var username = ""
    @State var showAlert = false
    
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
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .frame(width: 200)
                        .font(.title)
                        .multilineTextAlignment(.center)
                    Button("Rechercher") {
                            searchUser()
                    }
//                    .disabled(username.isEmpty || request.token == nil || disabled)
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
                request.checkAndFetchTokenIfNeeded()
            }
        }
    }
    
    func searchUser() {
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
}

//#Preview {
//    LoadedContentView()
//}
