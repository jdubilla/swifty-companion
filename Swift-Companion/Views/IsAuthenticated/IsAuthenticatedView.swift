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
                    if request == nil, let token = oAuth.tokenInfos {
                        request = APIRequest(token: token)
                    } else {
                        Task {
                            await checkToken()
                        }
                    }
                }
                .transition(.opacity)
        } else {
            UserDetails(isUserSearch: $isUserSearch, request: $request)
                .onAppear() {
                    Task {
                        await checkToken()
                    }
                }
                .transition(.slide)
        }
    }
    
    func checkToken() async {
        await oAuth.checkAndFetchTokenIfNeeded()
        if let token = oAuth.tokenInfos {
            request?.token = token
        }
    }
    
}
