//
//  AnimatedStarsOverlay.swift
//  Tone
//
//  Created by Gabriel Groppo on 25/05/26.
//

import SwiftUI

struct AnimatedStarsOverlay: View {
    
    var body: some View {
        
        ZStack {
            
            ForEach(0..<80, id: \.self) { _ in
                TwinklingStar()
            }
        }
        //.ignoresSafeArea()
    }
}

struct TwinklingStar: View {
    
    @State private var opacity = Double.random(in: 0.1...1)
    
    let size = CGFloat.random(in: 4...6)
    
    let x = CGFloat.random(in: 0...1000)
    
    let y = CGFloat.random(in: 0...1000)
    
    var body: some View {
        
        Circle()
            .fill(Color.white)
            .frame(width: size, height: size)
            .position(x: x, y: y)
            .opacity(opacity)
            .blur(radius: 1)
            .onAppear {
                
                withAnimation(
                    .easeInOut(duration: 1)
                    .repeatForever()
                ) {
                    opacity = Double.random(in: 0.1...1)
                }
            }
    }
}



