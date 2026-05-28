//
//  ChordView.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 21/05/26.
//

import SwiftUI


struct ChordRow: View {
    let acorde: Acorde
    @Environment(CarouselViewModel.self) var viewModel
    
    var body: some View {
        HStack() {
            MusicalChordButton(chord: acorde.nome, instrument: "Piano")
            ChordCell(notes: acorde.notas)
        }
    }
}

#Preview {
    ChordRow(acorde: Acorde(grau: "I", nome: "C", notas: ["C", "E", "G"]))
        .environment(CarouselViewModel())
}
