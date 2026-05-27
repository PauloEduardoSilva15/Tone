//
//  ViewModeChord.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 21/05/26.
//

import SwiftUI

public struct ViewModeChord: View {
    
    let harmonyCamp_C: [Acorde] = EngineHarmonica().gerarCampoHarmonico(tom: "C", escala: .maior)
  
    public var body: some View {
        
        VStack {
            ForEach(harmonyCamp_C, id: \.self) { acorde in
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

