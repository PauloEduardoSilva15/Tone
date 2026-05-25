//
//  ViewModeGuitar.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 21/05/26.
//

import SwiftUI

struct ViewModeGuitar: View {
    var body: some View {
        VStack {
            HStack {
                GuitarRow(chord: "C")
                GuitarRow(chord: "Dm")
                GuitarRow(chord: "Em")
            }
            HStack {
                GuitarRow(chord: "F")
                GuitarRow(chord: "G")
                GuitarRow(chord: "Am")
            }
            HStack {
                GuitarRow(chord: "Bº")
            }
        }
    }
}

#Preview {
    ViewModeGuitar()
}
