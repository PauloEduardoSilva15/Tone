//
//  MusicalChordButton.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

public struct MusicalNoteButton: View {
    let note: String
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
                    width: sizeClass == .regular ? 60: 80,
                    height: sizeClass == .regular ? 40: 80
                )
            }
            .foregroundColor(.white)
            .background(Color.colorPrimary)
            .cornerRadius(sizeClass == .regular ? 10: 15)
        }
        
    }
}


#Preview {
    MusicalNoteButton(note: "C")
}
