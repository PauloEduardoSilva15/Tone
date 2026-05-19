//
//  HarmonyCampCell.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct HarmonyCampCell: View {
    let note: String
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        VStack(spacing: sizeClass == .regular ? 12 : 8){
            Text("I")
                .font(sizeClass == .regular ? .headline : .caption)
                .bold()
            Text(note)
                .bold()
        }
        
        .frame(
            width: sizeClass == .regular ? 110 : 70,
            height: sizeClass == .regular ? 110 : 70
        )
        .border(.colorSecundary, width: 4)
        .cornerRadius(sizeClass == .regular ? 16 : 12)
        
        
        
        
        
        
    }
}

#Preview {
    HarmonyCampCell(note: "C")
}
