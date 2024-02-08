//
//  SafariView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 23/11/2023.
//

import SwiftUI
import SafariServices

private func getApiUID() -> String {
    guard let filePath = Bundle.main.path(forResource: "InfosAPI", ofType: "plist"),
          let plist = NSDictionary(contentsOfFile: filePath),
          let value = plist.object(forKey: "API_UID") as? String else {
        return ""
    }
    return value
}

struct SafariView: UIViewControllerRepresentable {
    var code: String?
    @Binding var receivedCode: String?
    var apiUid = getApiUID()
    
    let url = URL(string: "https://api.intra.42.fr/oauth/authorize?client_id=\(getApiUID())&redirect_uri=https://www.google.com/&response_type=code")!
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.delegate = context.coordinator
        return safariViewController
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(receivedCode: $receivedCode)
    }
}


class Coordinator: NSObject, SFSafariViewControllerDelegate {
    
    var code: String?
    var receivedCodeBinding: Binding<String?>?

    init(receivedCode: Binding<String?>) {
        self.receivedCodeBinding = receivedCode
    }

    func safariViewController(_ controller: SFSafariViewController, initialLoadDidRedirectTo URL: URL) {        
        if let queryItems = URLComponents(string: URL.absoluteString)?.queryItems {
            if queryItems.count == 1, let query = queryItems.first {
                let codeQuery = query.description.split(separator: "=")
                if (codeQuery.count == 2 && codeQuery[0] == "code") {
                    code = String(codeQuery[1])
                    receivedCodeBinding?.wrappedValue = String(codeQuery[1])
                }
            }
        } else {
            print("No query items found")
        }
    }
}

