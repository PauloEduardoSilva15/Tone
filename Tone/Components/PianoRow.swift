//
//  PianoRow.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 20/05/26.
//

import SwiftUI

public struct PianoRow: View {
    let acorde: Acorde
    
    public var body: some View {

        HStack{
            MusicalChordButton(chord: acorde.nome, instrument: "Piano")
            PianoCell(acorde: acorde)
        }
        
    }
}

#Preview {
    PianoRow(acorde: Acorde(grau: "I", nome: "G", notas: ["C", "E","G"]))
    
}
