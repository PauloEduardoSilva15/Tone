//
//  ViewHarmonyCamp.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct ViewHarmonyCamp: View {
    
    var viewModel: CarouselViewModel
    
    var body: some View {
        VStack {
            HStack {
                HarmonyCampCell(grau: "I", note: "C", isHighlighted: true, numeroProgressao: 1, corEmocao: .yellow)
                HarmonyCampCell(grau: "II",note: "Dm", isHighlighted: false, numeroProgressao: nil, corEmocao: .yellow)
                HarmonyCampCell(grau: "III",note: "Em", isHighlighted: false, numeroProgressao: nil, corEmocao: .yellow)
            }
            
            HStack {
                HarmonyCampCell(grau: "IV",note: "F", isHighlighted: true, numeroProgressao: 4, corEmocao: .yellow)
                HarmonyCampCell(grau: "V",note: "G", isHighlighted: true, numeroProgressao: 2, corEmocao: .yellow)
                HarmonyCampCell(grau: "VI",note: "Am", isHighlighted: true, numeroProgressao: 3, corEmocao: .yellow)
            }
            HStack {
                HarmonyCampCell(grau: "VII",note: "Bº", isHighlighted: false, numeroProgressao: 1, corEmocao: .yellow)
            
            if viewModel.campoHarmonicoAtual.count == 7 {
                
                HStack {
                    ForEach(0..<3, id: \.self) { index in
                        let acorde = viewModel.campoHarmonicoAtual[index]
                        HarmonyCampCell(grau: acorde.grau, note: acorde.nome)
                    }
                }
                
                HStack {
                    ForEach(3..<6, id: \.self) { index in
                        let acorde = viewModel.campoHarmonicoAtual[index]
                        HarmonyCampCell(grau: acorde.grau, note: acorde.nome)
                    }
                }
                
                HStack {
                        let acorde = viewModel.campoHarmonicoAtual[6]
                        HarmonyCampCell(grau: acorde.grau, note: acorde.nome)
                    }
                
                } else {
                    Text("Selecione um tom")
                    
                }
                
                    
                }
            }
        }
