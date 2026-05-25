//
//  PianoRow.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 20/05/26.
//

import SwiftUI

public struct PianoRow: View {
    let chord: String
    public var body: some View {
        HStack{
            MusicalNoteButton(note: chord, type: 1)
            PianoCell()
        }
        
    }
}

#Preview {
    PianoRow(chord: "C")
}
