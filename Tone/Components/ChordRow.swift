//
//  ChordView.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 21/05/26.
//

import SwiftUI


struct ChordRow: View {
    let chord: String
    let type: TipoAcorde
    @Environment(CarouselViewModel.self) var viewModel
    
    var body: some View {
        HStack() {
            MusicalChordButton(chord: chord, instrument: "Piano")
            let tonica = extrairTonica(do: chord, tipo: type)
            ChordCell(notes: EngineHarmonica.formarAcorde(tonica: tonica, tipo: type))
            
        }
    }
}

private func extrairTonica(do nome: String, tipo: TipoAcorde) -> String {
        switch tipo {
        case .menor:
            return nome.replacingOccurrences(of: "m", with: "").trimmingCharacters(in: .whitespaces)
        case .diminuto:
            return nome.replacingOccurrences(of: "º", with: "").trimmingCharacters(in: .whitespaces)
        case .maior:
            return nome
        }
    }

#Preview {
    ChordRow(chord: "Cm", type: .menor)
        .environment(CarouselViewModel())
}
