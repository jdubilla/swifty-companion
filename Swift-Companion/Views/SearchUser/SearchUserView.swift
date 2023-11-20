//
//  SearchUserView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 16/11/2023.
//

import SwiftUI

struct SearchUserView: View {
    
    @Binding var isUserSearch: Bool
    @Binding var request: APIRequest
    
    @State var username: String = ""
    @State var showAlert = false
    @State var disabled = false
    
    var body: some View {
        if request.token != nil {
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
        } else {
            VStack {
                Text("Chargement")
            }
            .onAppear() {
                self.username = ""
                request.checkAndFetchTokenIfNeeded()
            }
        }
    }
}

#Preview {
    SearchUserView(isUserSearch: .constant(false), request: .constant(APIRequest()))
}
