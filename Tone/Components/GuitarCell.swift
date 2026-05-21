//
//  GuitarCell.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI
    
struct LinhaHorizontal: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        
        HStack(spacing: 0) {
            ForEach(0..<6, id: \.self) { i in
                Rectangle()
                    .fill(Color.black)
                    .frame(width: sizeClass == .compact ? 1 : 2)
                if i < 5 {
                    Spacer()
                }
            }
        }
    }
}

struct LinhaVertical: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.black)
                .frame(height: sizeClass == .compact ? 6 : 12)
            
            Spacer()
            
            ForEach(0..<4, id: \.self) { i in
                Rectangle()
                    .fill(Color.black)
                    .frame(height: sizeClass == .compact ? 1 : 2)
                if i < 3 {
                    Spacer()
                }
            }
        }
    }
}
        
struct GuitarCell: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        
        ZStack {
            Color.colorSecondary
            
            ZStack {
                LinhaHorizontal()
                LinhaVertical()
            }
            .frame(
                width: sizeClass == .compact ? 90 : 180,
                height: sizeClass == .compact ? 100 : 200)
            .clipShape(RoundedRectangle(cornerRadius: sizeClass == .compact ? 15 : 30))
            .overlay(
                RoundedRectangle(cornerRadius: sizeClass == .compact ? 15 : 30)
                    .stroke(Color.black, lineWidth: sizeClass == .compact ? 1 : 2))
            
        }
        .frame(width: sizeClass == .compact ? 115 : 230,
               height: sizeClass == .compact ? 115 : 230)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        
    }
}


#Preview {
    
    ZStack {
        Color.black.ignoresSafeArea()
    GuitarCell()
        
    }
}
