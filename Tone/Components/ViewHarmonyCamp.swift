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
