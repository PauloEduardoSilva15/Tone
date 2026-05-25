//
//  ChordView.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 21/05/26.
//

import SwiftUI


struct ChordRow: View {
    let chord: String
    var chordNotes: [String: [String]] = [
        "C": ["C", "G", "Am"],
        "Dm": ["D", "F", "A"],
        "Em": ["E", "G", "B"],
        "F": ["F", "G", "C"],
        "G": ["G", "B", "D"],
        "Am": ["A", "C", "E"],
        "Bº": ["B", "D", "F"],
    ]
    var body: some View {
        HStack() {
            MusicalNoteButton(note: chord, type: 1)
            ChordCell(notes: chordNotes[chord] ?? [])
            
        }
    }
}

#Preview {
    ChordRow(chord: "C")
}
