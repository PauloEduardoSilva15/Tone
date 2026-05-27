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
            ChordRow(chord: "C", typeChord: "")
            ChordRow(chord: "D", typeChord: "m")
            ChordRow(chord: "E", typeChord: "m")
            ChordRow(chord: "F", typeChord: "")
            ChordRow(chord: "G", typeChord: "")
            ChordRow(chord: "A", typeChord: "m")
            ChordRow(chord: "B", typeChord: "º")
        }
    }
}

#Preview {
    ViewModeChord()
        .environment(CarouselViewModel())
}
