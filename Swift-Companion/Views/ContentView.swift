//
//  ContentView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 15/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var request: APIRequest = APIRequest()
    @State var isUserSearch = false
    
    var body: some View {
        if (!isUserSearch) {
            SearchUserView(isUserSearch: $isUserSearch, request: $request)
        } else {
            UserDetails(isUserSearch: $isUserSearch, request: $request)
        }
    }
}

#Preview {
    ContentView()
}
