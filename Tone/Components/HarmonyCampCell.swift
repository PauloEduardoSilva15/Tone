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
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        
        VStack(spacing: sizeClass == .regular ? 12 : 8) {
            
            Text(grau)
                .font(.system(size: sizeClass == .regular ? 21 : 16, weight: .regular, design: .default))
                .bold()
                .foregroundStyle(Color("ColorSecondary"))
            
            Text(note)
                .font(.system(size: sizeClass == .regular ? 25 : 20, weight: .bold, design: .default))
                .bold()
                .foregroundStyle(Color("ColorSecondary"))
            
        }
        .frame(
            width: sizeClass == .regular ? 120 : 80,
            height: sizeClass == .regular ? 120 : 80)
        
        .border(.colorSecondary, width:1)
        .cornerRadius(sizeClass == .regular ? 15 : 12)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.white, lineWidth: 1))
        .padding(5)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        HarmonyCampCell(grau: "I", note: "C")
    }
}
