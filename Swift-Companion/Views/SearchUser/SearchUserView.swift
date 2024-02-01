//
//  SearchUserView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 16/11/2023.
//

import SwiftUI

struct SearchUserView: View {
    
    @Binding var isUserSearch: Bool
    @Binding var request: APIRequest?
    
    var body: some View {
        if request?.token != nil {
                LoadedContentView(isUserSearch: $isUserSearch, request: request)
        } else {
            LoadingView()
        }
    }
}
