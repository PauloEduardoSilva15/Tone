//
//  GuitarCell.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI
    
struct LinhaHorizontal: View {
    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(0..<6, id: \.self) { i in
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 2)
                if i < 5 {
                    Spacer()
                }
            }
        }
    }
}

struct LinhaVertical: View {
    var body: some View {
        
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.red)
                .frame(height: 6)
            
            Spacer()
            
            ForEach(0..<4, id: \.self) { i in
                Rectangle()
                    .fill(Color.red)
                    .frame(height: 2)
                if i < 3 {
                    Spacer()
                }
            }
        }
    }
}
        
struct GuitarCell: View {
    var body: some View {
        
        
            ZStack {
                LinhaHorizontal()
                LinhaVertical()
            }

        .frame(width: 100, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.red, lineWidth: 2))
                .padding(5)

        
    }
}

#Preview {
    ZStack {
        
        Color.white.ignoresSafeArea()
    GuitarCell()
}
}
