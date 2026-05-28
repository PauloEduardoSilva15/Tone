//
//  PianoRow.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 20/05/26.
//

import SwiftUI

public struct PianoRow: View {
    let acorde: Acorde
    @Environment(CarouselViewModel.self) var viewModel

    private var corProgressao: Color {
        MusicConstants.corParaGrau(acorde.grau, escala: viewModel.escalaSelecionada, emocao: viewModel.sentimentoSelecionado)
    }

    private var fazParteDaProgressao: Bool {
        corProgressao != .colorSecondary
    }

    public var body: some View {
        HStack {
            MusicalChordButton(chord: acorde.nome, instrument: "Piano")
            PianoCell(acorde: acorde)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(corProgressao, lineWidth: fazParteDaProgressao ? 2 : 0)
                )
                .shadow(
                    color: fazParteDaProgressao ? corProgressao.opacity(0.6) : .clear,
                    radius: fazParteDaProgressao ? 8 : 0
                )
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.sentimentoSelecionado)
    }
}

#Preview("Sem emoção") {
    PianoRow(acorde: Acorde(grau: "I", nome: "C", notas: ["C", "E", "G"]))
        .environment(CarouselViewModel())
}
