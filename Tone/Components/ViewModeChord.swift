//
//  ViewModeChord.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 21/05/26.
//

import SwiftUI


public struct ViewModeChord: View {
    @Environment(CarouselViewModel.self) var viewModel
    
  
    public var body: some View {
        VStack {
            ForEach(viewModel.campoHarmonicoAtual, id: \.self) { acorde in
                let nomeLimpo = acorde.nome.trimmingCharacters(in: .whitespacesAndNewlines)
                let tipo: TipoAcorde = descobrirTipo(do: nomeLimpo)
                ChordRow(chord: acorde.nome, type: tipo)
            }
        }
    }
    
    private func descobrirTipo(do nome: String) -> TipoAcorde {
        switch nome {
        case _ where nome.hasSuffix("m"):
            return .menor
        case _ where nome.hasSuffix("º"):
            return .diminuto
        default:
            return .maior
        }
    }
}

#Preview {
    ViewModeChord()
        .environment(CarouselViewModel())
}

