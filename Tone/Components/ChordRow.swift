//
//  ChordView.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 21/05/26.
//

import SwiftUI


struct ChordRow: View {
    let chord: String
    let typeChord: String
    @Environment(CarouselViewModel.self) var viewModel
    
    var body: some View {
        HStack() {
            MusicalChordButton(chord: chord+typeChord, instrument: "Piano")
            switch typeChord {
            case "m":
                ChordCell(notes: EngineHarmonica().formarAcorde(tonica: chord, tipo: TipoAcorde.menor))
            case "º":
                ChordCell(notes: EngineHarmonica().formarAcorde(tonica: chord, tipo: TipoAcorde.diminuto))
            default:
                ChordCell(notes: EngineHarmonica().formarAcorde(tonica: chord, tipo: TipoAcorde.maior))
            }
            
            
        }
    }
}

#Preview {
    ChordRow(chord: "B", typeChord: "")
        .environment(CarouselViewModel())
}
