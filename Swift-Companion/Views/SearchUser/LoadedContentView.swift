//
//  LoadedContentView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 20/11/2023.
//

import SwiftUI

struct LoadedContentView: View {
    
    @Binding var isUserSearch: Bool
    var request: APIRequest?
    
    @State var disabled = false
    @State var username = "jdubilla"
    @State var showAlert = false
    @FocusState private var textfieldFocused: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("background42")
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
                        .focused($textfieldFocused)
                        .onLongPressGesture(minimumDuration: 0.0) {
                            textfieldFocused = true
                        }
                        .autocorrectionDisabled()
                        .onChange(of: username) { oldValue, newValue in
                            if newValue.count > 17 {
                                username = String(newValue.prefix(17))
                            }
                        }
                    Button("Rechercher") {
                            searchUser()
                    }
                    .disabled(username.isEmpty || request?.token == nil || disabled)
                    .font(.system(size: 25))
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .alert("Erreur", isPresented: $showAlert) {
                    
                } message: {
                    Text("Utilisateur introuvable")
                }
            }
        }
    }
    
    func searchUser() {
        Task {
            disabled = true
            await request?.fetchDataUser(username: username)
            disabled = false
            if request?.user != nil {
                withAnimation {
                    isUserSearch = true
                }
            } else {
                textfieldFocused = false
                showAlert = true
                username = ""
            }
        }
    }
}

//#Preview {
//    LoadedContentView()
//}
