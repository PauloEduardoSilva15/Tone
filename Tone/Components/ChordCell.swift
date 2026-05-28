//
//  ChordCell.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct ChordCell: View {
    //let notes:[String]
    @Environment(\.horizontalSizeClass) var sizeClass
    
    let acorde: Acorde
    let escala: Escala
    let emocao: Emocao
    
    private var corDaBorda: Color {
        MusicConstants.corParaGrau(acorde.grau, escala: escala, emocao: emocao)
    }
    
    private var fazParteDaProgressao: Bool {
        corDaBorda != .colorSecondary
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Text(acorde.notas.joined(separator: " - "))
                .font(sizeClass == .regular ? .title : .body)
                .foregroundColor(corDaBorda)
        }
        .frame(
            width: sizeClass == .regular ? 300 : 240,
            height: sizeClass == .regular ? 90 : 65
        )
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(corDaBorda, lineWidth: fazParteDaProgressao ? 2 : 1)
        )
        .shadow(
            color: fazParteDaProgressao ? corDaBorda.opacity(0.6) : .clear,
            radius: fazParteDaProgressao ? 8 : 0
        )
        .animation(.easeInOut(duration: 0.3), value: emocao)
    }
}

#Preview("Sem emoção") {
    ChordCell(acorde: Acorde(grau: "I", nome: "G", notas: ["C", "E","G"]), escala: Escala.maior, emocao: Emocao.nenhum)
        .background(.black)
}
#Preview("Com alegria") {
    ChordCell(acorde: Acorde(grau: "I", nome: "G", notas: ["C", "E","G"]), escala: Escala.maior, emocao: Emocao.alegria)
        .background(.black)
}


