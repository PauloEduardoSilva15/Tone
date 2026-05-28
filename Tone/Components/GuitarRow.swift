//  RowGuitar.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 20/05/26.
//

import SwiftUI

struct GuitarRow: View {
    @Environment(CarouselViewModel.self) var viewModel
    let acorde: Acorde
    
    private var corProgressao: Color {
        MusicConstants.corParaGrau(acorde.grau, escala: viewModel.escalaSelecionada, emocao: viewModel.sentimentoSelecionado)
    }
    
    private var fazParteDaProgressao: Bool {
        corProgressao != .colorSecondary
    }
    
    var body: some View {
        VStack {
            MusicalChordButton(
                chord: acorde.nome,
                instrument: "Guitar"
            )
            GuitarCell(
                fingers: GuitarChordLibrary.positions(for: acorde.nome),
                pestana: GuitarChordLibrary.pestana(for: acorde.nome)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(corProgressao, lineWidth: fazParteDaProgressao ? 2 : 0)
            )
            .shadow(
                color: fazParteDaProgressao ? corProgressao.opacity(0.6) : .clear,
                radius: fazParteDaProgressao ? 8 : 0
            )
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.sentimentoSelecionado)    }
}

#Preview {
    GuitarRow(acorde: Acorde(grau: "I", nome: "C", notas: ["C", "E", "G"]))
        .environment(CarouselViewModel())
}
