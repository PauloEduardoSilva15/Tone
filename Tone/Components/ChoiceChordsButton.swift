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
                selecaoAtual = id }})
        {
                
            VStack(spacing: 4) {
                
                Image(systemName: icone)
                    .font(sizeClass == .compact ? .title2 : .largeTitle)

                Text(texto)
                    .font(sizeClass == .compact ? .caption : .title2)
                    .fontWeight(.regular)
                
            }
            .frame(width: sizeClass == .compact ? 80 : 120, height: sizeClass == .compact ? 80 : 100)
            .foregroundColor(Selecionado ? .white : .black)
            .background(Selecionado ? Color.colorPrimary : Color.colorSecondary)
            .clipShape(Circle())
        }
        
    }
}

struct ChoiceChordsButton: View {
    
    @State private var botaoSelecionado: Int = 1
    
    var body: some View {
        
        HStack(spacing: 20) {
            ChordButton(id: 1,
                     icone: "music.quarternote.3",
                     texto: "Nota",
                     selecaoAtual: $botaoSelecionado)
            
            ChordButton(id: 2,
                     icone: "pianokeys",
                     texto: "Piano",
                     selecaoAtual: $botaoSelecionado)
            
            ChordButton(id: 3,
                     icone: "guitars.fill",
                     texto: "Violão",
                     selecaoAtual: $botaoSelecionado)
        }
        .padding()
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ChoiceChordsButton()
    }
}


