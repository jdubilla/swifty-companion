//
//  IsAuthenticatedView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 23/11/2023.
//

import SwiftUI

struct IsAuthenticatedView: View {
    
    @Binding var oAuth: OAuthManager
    
    @State var request: APIRequest?
    @State var isUserSearch = false
    
    var body: some View {
        if (!isUserSearch) {
            SearchUserView(isUserSearch: $isUserSearch, request: $request)
                .onAppear() {
                    if request == nil, let accessToken = oAuth.tokenInfos?.access_token {
                        request = APIRequest(token: accessToken)
                    }
                    // Faire les verifs du token ici
                }
        } else {
            UserDetails(isUserSearch: $isUserSearch, request: $request)
                .onAppear() {
                    // Faire les verifs du token ici
                }
        }
    }
}
