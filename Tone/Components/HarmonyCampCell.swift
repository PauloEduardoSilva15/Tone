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
    let numerosProgressao: [Int]
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        VStack(spacing: sizeClass == .regular ? 12 : 8) {
            Text(grau)
                .font(sizeClass == .regular ? .title : .title3)
                .fontWeight(sizeClass == .regular ? .regular : .regular)
                
                .foregroundStyle(accentColor)
            
            Text(note)
                .font(sizeClass == .regular ? .title : .title3)
                .fontWeight(sizeClass == .regular ? .regular : .regular)
                
                .foregroundStyle(accentColor)
        }
        .frame(width: sizeClass == .regular ? 120 : 80, height: sizeClass == .regular ? 120 : 80)
        .cornerRadius(sizeClass == .regular ? 15 : 12)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(accentColor, lineWidth: 1) 
        )
        .overlay(alignment: .topLeading) {
            
            if !numerosProgressao.isEmpty {
                
                ZStack {
                    
                    Circle()
                        .fill(accentColor)
                        .frame(
                            width: sizeClass == .regular ? 38 : 30,
                            height: sizeClass == .regular ? 38 : 30
                        )
                        .shadow(color: accentColor.opacity(0.8), radius: 8)
                    
                    Text(
                        numerosProgressao
                            .map { String($0) }
                            .joined(separator: "-")
                    )
                    .font(sizeClass == .regular ? .headline : .subheadline)
                    .bold()
                    .foregroundStyle(.black)
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
        HarmonyCampCell(grau: "I", note: "C", accentColor: .blue, numerosProgressao: [1])
    }
    .environment(CarouselViewModel())
}
