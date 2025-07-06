//
//  LoadingIndicatorView.swift
//  Shortsy
//
//  Created by hongdae on 6/29/25.
//

import SwiftUI

struct LoadingIndicatorView: View {
    @State private var animate = false
    
    let circleSize: CGFloat = 16
    let circleSpacing: CGFloat = 8
    
    var body: some View {
        HStack(spacing: circleSpacing) {
            Circle()
                .fill(Color.white)
                .frame(width: circleSize, height: circleSize)
                .scaleEffect(animate ? 1 : 0.5)
                .animation(
                    Animation.easeInOut(duration: 0.6)
                        .repeatForever()
                        .delay(0),
                    value: animate
                )
            Circle()
                .fill(Color.white)
                .frame(width: circleSize, height: circleSize)
                .scaleEffect(animate ? 1 : 0.5)
                .animation(
                    Animation.easeInOut(duration: 0.6)
                        .repeatForever()
                        .delay(0.2),
                    value: animate
                )
            Circle()
                .fill(Color.white)
                .frame(width: circleSize, height: circleSize)
                .scaleEffect(animate ? 1 : 0.5)
                .animation(
                    Animation.easeInOut(duration: 0.6)
                        .repeatForever()
                        .delay(0.4),
                    value: animate
                )
        }
        .onAppear {
            animate = true
        }
    }
}

#Preview {
    LoadingIndicatorView()
}
