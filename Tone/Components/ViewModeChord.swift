//
//  ViewModeChord.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 21/05/26.
//

import SwiftUI

public struct ViewModeChord: View {
    public var body: some View {
        VStack {
            ChordRow(chord: "C")
            ChordRow(chord: "Dm")
            ChordRow(chord: "Em")
            ChordRow(chord: "F")
            ChordRow(chord: "G")
            ChordRow(chord: "Am")
            ChordRow(chord: "Bº")
        }
    }
}

#Preview {
    ViewModeChord()
}
