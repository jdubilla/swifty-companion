//
//  LoadingView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 20/11/2023.
//

import SwiftUI

struct LoadingView: View {
    
    var request: APIRequest

    var body: some View {
        VStack {
            Text("Chargement")
        }
        .onAppear() {
            request.checkAndFetchTokenIfNeeded()
        }
    }
}

//#Preview {
//    LoadingView()
//}
