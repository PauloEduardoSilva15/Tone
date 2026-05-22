//
//  RowGuitar.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 20/05/26.
//

import SwiftUI

struct GuitarRow: View {
    let chord: String
    var body: some View {
        VStack{
            MusicalChordButton(chord: chord, type: 2)
            GuitarCell()
        }
    }
}

#Preview {
    GuitarRow(chord: "C")
}
