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
            LoadedContentView(username: $username, showAlert: $showAlert, disabled: $disabled, isUserSearch: $isUserSearch, request: request)
        } else {
            LoadingView(request: request)
        }
    }
}

#Preview {
    SearchUserView(isUserSearch: .constant(false), request: .constant(APIRequest()))
}
