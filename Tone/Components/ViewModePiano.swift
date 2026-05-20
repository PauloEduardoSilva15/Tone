//
//  ViewModePiano.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 20/05/26.
//


import SwiftUI

struct ViewModePiano: View {
    var body: some View {
        VStack {
            PianoRow(chord: "C")
            PianoRow(chord: "Dm")
            PianoRow(chord: "Em")
            PianoRow(chord: "F")
            PianoRow(chord: "G")
            PianoRow(chord: "Am")
            PianoRow(chord: "Bº")
        }
    }
}

#Preview {
    ViewModePiano()
}
