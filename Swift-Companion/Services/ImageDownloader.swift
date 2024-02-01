//
//  ImageDownloader.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 17/11/2023.
//

import SwiftUI

class ImageDownloader: ObservableObject {
	@Published var image: Image?

    func getImage(path: String) {
        if let url: URL = URL(string: path) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print(error.localizedDescription)
                        self.image = nil
                    }
                    if let data = data {
                        if let ui = UIImage(data: data) {
                            self.image = Image(uiImage: ui)
                        } else {
                            self.image = nil
                        }
                    }
                }
            }.resume()
        } else {
            self.image = nil
        }
    }
}
