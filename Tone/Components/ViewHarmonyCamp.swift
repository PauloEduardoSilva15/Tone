//
//  ViewHarmonyCamp.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct ViewHarmonyCamp: View {
    @Environment(CarouselViewModel.self) var viewModel
    
    var body: some View {
        VStack {
            if viewModel.campoHarmonicoAtual.count == 7 {
                // Primeira Linha (I, II, III)
                HStack {
                    ForEach(0..<3, id: \.self) { index in
                        let acorde = viewModel.campoHarmonicoAtual[index]
                        HarmonyCampCell(
                            grau: acorde.grau,
                            note: acorde.nome,
                            accentColor: MusicConstants.corParaGrau(acorde.grau, escala: viewModel.escalaSelecionada, emocao: viewModel.sentimentoSelecionado)
                        )
                    }
                }
                
                // Segunda Linha (IV, V, VI)
                HStack {
                    ForEach(3..<6, id: \.self) { index in
                        let acorde = viewModel.campoHarmonicoAtual[index]
                        HarmonyCampCell(
                            grau: acorde.grau,
                            note: acorde.nome,
                            accentColor: MusicConstants.corParaGrau(acorde.grau, escala: viewModel.escalaSelecionada, emocao: viewModel.sentimentoSelecionado)
                        )
                    }
                }
                
                // Terceira Linha (VII)
                HStack {
                    let acorde = viewModel.campoHarmonicoAtual[6]
                    HarmonyCampCell(
                        grau: acorde.grau,
                        note: acorde.nome,
                        accentColor: MusicConstants.corParaGrau(acorde.grau, escala: viewModel.escalaSelecionada, emocao: viewModel.sentimentoSelecionado)
                    )
                }
            } else {
                Text("Selecione um tom")
            }
        }
    }
}

#Preview {
    ViewHarmonyCamp()
        .environment(CarouselViewModel())
}
