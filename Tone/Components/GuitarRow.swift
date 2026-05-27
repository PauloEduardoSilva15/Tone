//  RowGuitar.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 20/05/26.
//

import SwiftUI

struct GuitarRow: View {

    let chord: String

    var body: some View {

        VStack {

            MusicalChordButton(
                chord: chord,
                instrument: "Guitar"
            )

            GuitarCell(
                fingers: GuitarChordLibrary.chords[chord] ?? [],
                pestana: GuitarChordLibrary.pestanas[chord]
            )
        }
    }
}
#Preview {
    GuitarRow(chord: "C")
}
