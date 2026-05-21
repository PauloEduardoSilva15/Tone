//
//  MusicalChordButton.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

public struct MusicalNoteButton: View {
    let note: String
    let type: Int
    @Environment(\.horizontalSizeClass) var sizeClass
    public var body: some View {
        VStack {
            Button(action: {
                    
            }) {
                VStack {
                    Image(systemName: "volume.3")
                        .font(.caption)
                    Text(note)
                        .font(.headline)
                }
                .frame(
                    width: type == 1 ? 80: 110,
                    height: type == 1 ? 80 : 50
                )
            }
            .foregroundColor(.white)
            .background(Color.colorPrimary)
            .cornerRadius(type == 1 ? 30 : 16)
        }
        
    }
}


#Preview {
    MusicalNoteButton(note: "C", type: 2)
}
