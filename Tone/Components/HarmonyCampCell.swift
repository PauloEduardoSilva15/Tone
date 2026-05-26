//
//  HarmonyCampCell.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct HarmonyCampCell: View {
    @Environment(CarouselViewModel.self) var viewModel
    let grau: String
    let note: String
    let accentColor: Color
    //let numeroProgressao: Int?
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        VStack(spacing: sizeClass == .regular ? 12 : 8) {
            Text(grau)
                .font(.system(size: sizeClass == .regular ? 21 : 16, weight: .regular))
                .bold()
                .foregroundStyle(accentColor) // <--- Usando a cor
            
            Text(note)
                .font(.system(size: sizeClass == .regular ? 25 : 20, weight: .bold))
                .bold()
                .foregroundStyle(accentColor) // <--- Usando a cor
        }
        .frame(width: sizeClass == .regular ? 120 : 80, height: sizeClass == .regular ? 120 : 80)
        .cornerRadius(sizeClass == .regular ? 15 : 12)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(accentColor, lineWidth: 1) 
        )
//        .overlay(alignment: .topLeading) {
//            
//            if let numero = numeroProgressao {
//                
//                ZStack {
//                    
//                    Circle()
//                        .fill(accentColor)
//                        .frame(width: sizeClass == .regular ? 34 : 28,
//                               height: sizeClass == .regular ? 34 : 28)
//                        .shadow(color: accentColor.opacity(0.8), radius: 8)
//                    
//                    Text("\(numero)")
//                        .font(sizeClass == .regular ? .headline : .caption)
//                        .bold()
//                        .foregroundStyle(.black)
//                }
//                .offset(x: -10, y: -10)
//            }
//        }
        .padding(5)
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        HarmonyCampCell(grau: "I", note: "C", accentColor: .blue)
    }
    .environment(CarouselViewModel())
}
