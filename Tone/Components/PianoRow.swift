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
            MusicalChordButton(chord: chord, instrument: "Piano")
            PianoCell()
        }
        
    }
}

#Preview {
    PianoRow(chord: "C")
}
