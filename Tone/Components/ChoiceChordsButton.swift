//
//  ChoiceChordsButton.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct ChordButton: View {
    let id: Int
    let icone: String
    let texto: String
    
    @Binding var selecaoAtual: Int
    
    var Selecionado: Bool {
        selecaoAtual == id
    }
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {

        Button(action: {
                withAnimation(.easeInOut(duration: 0.1)) {
                selecaoAtual = id
            }})
        {
                
            VStack(spacing: 4) {
                
                Image(systemName: icone)
                    .font(sizeClass == .compact ? .title3 : .largeTitle)

                Text(texto)
                    .font(sizeClass == .compact ? .caption : .title2)
                    .fontWeight(.regular)
                
            }
            .frame(width: sizeClass == .compact ? 60 : 110, height: sizeClass == .compact ? 60 : 100)
            .foregroundColor(Selecionado ? .white : .black)
            .background(Selecionado ? Color.colorPrimary : Color.colorSecondary)
            .clipShape(Circle())
        }
        
    }
}



#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ChordButton(id: 0, icone: "note.list", texto: "C", selecaoAtual: .constant(0))
    }
}


