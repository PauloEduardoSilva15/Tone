//
//  HarmonyCampCell.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct HarmonyCampCell: View {
    let grau: String
    let note: String
    let isHighlighted: Bool
    let numeroProgressao: Int?
    let corEmocao: Color
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        
        VStack(spacing: sizeClass == .regular ? 12 : 8) {
            
            Text(grau)
                .font(.system(size: sizeClass == .regular ? 21 : 16, weight: .regular, design: .default))
                .bold()
                .foregroundStyle(
                    isHighlighted
                    ? corEmocao
                    : Color("ColorSecondary")
                )
            
            Text(note)
                .font(.system(size: sizeClass == .regular ? 25 : 20, weight: .bold, design: .default))
                .bold()
                .foregroundStyle(
                    isHighlighted
                    ? corEmocao
                    : Color("ColorSecondary")
                )
        }
        .frame(
            width: sizeClass == .regular ? 120 : 80,
            height: sizeClass == .regular ? 120 : 80)
        
        .border(.colorSecondary, width:1)
        .cornerRadius(sizeClass == .regular ? 15 : 12)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color( isHighlighted ? corEmocao : .colorSecondary), lineWidth: 1))
        .overlay(alignment: .topLeading) {
            
            if isHighlighted {
                ZStack {
                    
                    Circle()
                        .fill(corEmocao)
                        .frame(width: 28, height: 28)
                        .shadow(color: corEmocao.opacity(0.8), radius: 8)
                    
                    Text("\(numeroProgressao ?? 0)")
                        .font(.caption)
                        .bold()
                        .foregroundColor(.black)
                }
                .offset(x: -10, y: -10)
            }
        }
        .padding(5)
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        HarmonyCampCell(
            grau: "I",
            note: "C",
            isHighlighted: true,
            numeroProgressao: 1,
            corEmocao: .yellow
        )
    }
}
