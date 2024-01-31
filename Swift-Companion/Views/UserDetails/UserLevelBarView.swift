//
//  UserLevelBarView.swift
//  Swift-Companion
//
//  Created by Jean-baptiste DUBILLARD on 18/11/2023.
//

import SwiftUI

struct UserLevelBarView: View {
    
    @Binding var color: Color
    @Binding var request: APIRequest?
	var geometry: GeometryProxy

    let maxLevel: Double = 100

	@ObservedObject var userImageDownloader: ImageDownloader = ImageDownloader()

    let leftPadding: CGFloat = 80

    var body: some View {
        HStack {
            Spacer()
                .frame(width: leftPadding)
            ZStack(alignment: .leading) {
                GeometryReader { geometry in
                    Rectangle()
                        .frame(width: geometry.size.width, height: 20)
                        .opacity(0.3)
                        .foregroundColor(Color.gray)
                    Rectangle()
                        .frame(width: min(CGFloat((getDecimalPart() / self.maxLevel) * (geometry.size.width)), geometry.size.width), height: 20)
                        .foregroundColor(color)
                    Text(String(request?.user?.cursus_users.last?.level ?? 0.0))
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .offset(x: 20)
                    if let image = userImageDownloader.image {
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .shadow(radius: 10, x: 10, y: 10)
                            .offset(x: -70, y: -40)
					} else {
						Image(systemName: "person.circle.fill")
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: 80, height: 80)
							.clipShape(Circle())
							.shadow(radius: 10, x: 10, y: 10)
							.offset(x: -70, y: -40)
					}
                }
            }
        }
        .frame(height: 50)
		.onChange(of: geometry.size) {
			print("Image link changed")
			userImageDownloader.getImage(path: request?.user?.image.link ?? "")
		}
		.onAppear() {
			print("onAppear")
			userImageDownloader.getImage(path: request?.user?.image.link ?? "")
		}
    }
    
    func getDecimalPart() -> Double {
        let number: Double = request?.user?.cursus_users.last?.level ?? 0.0
        let decimalPart = Double((number.truncatingRemainder(dividingBy: 1)) * 100)
        return decimalPart
    }
}
