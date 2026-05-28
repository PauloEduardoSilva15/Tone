//
//  ViewHarmonyCamp.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//
import SwiftUI

struct ViewHarmonyCamp: View {
    @Environment(CarouselViewModel.self) var viewModel
    
    // 1. Adicione a propriedade para receber o acorde que está tocando
    let acordeAtivo: String?
    
    var body: some View {
        VStack {
            if viewModel.campoHarmonicoAtual.count == 7 {
                
                // Primeira Linha (Graus 1 a 3)
                HStack {
                    ForEach(0..<3, id: \.self) { index in
                        let acorde = viewModel.campoHarmonicoAtual[index]
                        
                        HarmonyCampCell(
                            grau: acorde.grau,
                            note: acorde.nome,
                            accentColor: MusicConstants.corParaGrau(
                                acorde.grau,
                                escala: viewModel.escalaSelecionada,
                                emocao: viewModel.sentimentoSelecionado
                            ),
                            numerosProgressao: MusicConstants.numerosDaProgressao(
                                para: acorde.grau,
                                escala: viewModel.escalaSelecionada,
                                emocao: viewModel.sentimentoSelecionado
                            )
                        )
                        // 2. Aplica o efeito de escala individual se for o acorde ativo
                        .scaleEffect(acorde.nome == acordeAtivo ? 1.12 : 1.0)
                        .shadow(color: acorde.nome == acordeAtivo ? .white.opacity(0.2) : .clear, radius: 8)
                        .zIndex(acorde.nome == acordeAtivo ? 1 : 0) // Garante que a célula cresça por cima das vizinhas
                    }
                }
                .zIndex(0)
                
                // Segunda Linha (Graus 4 a 6)
                HStack {
                    ForEach(3..<6, id: \.self) { index in
                        let acorde = viewModel.campoHarmonicoAtual[index]
                        
                        HarmonyCampCell(
                            grau: acorde.grau,
                            note: acorde.nome,
                            accentColor: MusicConstants.corParaGrau(
                                acorde.grau,
                                escala: viewModel.escalaSelecionada,
                                emocao: viewModel.sentimentoSelecionado
                            ),
                            numerosProgressao: MusicConstants.numerosDaProgressao(
                                para: acorde.grau,
                                escala: viewModel.escalaSelecionada,
                                emocao: viewModel.sentimentoSelecionado
                            )
                        )
                        // 2. Aplica o efeito de escala individual se for o acorde ativo
                        .scaleEffect(acorde.nome == acordeAtivo ? 1.12 : 1.0)
                        .shadow(color: acorde.nome == acordeAtivo ? .white.opacity(0.2) : .clear, radius: 8)
                        .zIndex(acorde.nome == acordeAtivo ? 1 : 0)
                    }
                }
                .zIndex(0)
                
                // Terceira Linha (Grau 7)
                HStack {
                    let acorde = viewModel.campoHarmonicoAtual[6]
                    
                    HarmonyCampCell(
                        grau: acorde.grau,
                        note: acorde.nome,
                        accentColor: MusicConstants.corParaGrau(
                            acorde.grau,
                            escala: viewModel.escalaSelecionada,
                            emocao: viewModel.sentimentoSelecionado
                        ),
                        numerosProgressao: MusicConstants.numerosDaProgressao(
                            para: acorde.grau,
                            escala: viewModel.escalaSelecionada,
                            emocao: viewModel.sentimentoSelecionado
                        )
                    )
                    // 2. Aplica o efeito de escala individual se for o acorde ativo
                    .scaleEffect(acorde.nome == acordeAtivo ? 1.12 : 1.0)
                    .shadow(color: acorde.nome == acordeAtivo ? .white.opacity(0.2) : .clear, radius: 8)
                    .zIndex(acorde.nome == acordeAtivo ? 1 : 0)
                }
                .zIndex(0)
                
            } else {
                Text("Selecione um tom")
            }
        }
    }
}

#Preview {
    // Atualizado para o Preview não reclamar do novo parâmetro
    ViewHarmonyCamp(acordeAtivo: "C")
        .environment(CarouselViewModel())
}
