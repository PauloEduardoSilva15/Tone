//
//  MusicalChordButton.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

public struct MusicalChordButton: View {
    let chord: String
    @State var type: Int
 
    @State private var audioPiano: AdvancedAudioManager = AdvancedAudioManager(filepath: "Audios/C_Piano")
    @State private var audioGuitar: AdvancedAudioManager = AdvancedAudioManager(filepath: "Audios/C_Guitar")
    @Environment(\.horizontalSizeClass) var sizeClass
    public var body: some View {
        VStack {
            Button(action: {
                if(type != 1){
                    audioGuitar.tocarAcorde(nomeDoAcorde: chord)
                    return
                }
                audioPiano.tocarAcorde(nomeDoAcorde: chord)
            }) {
                VStack {
                    Image(systemName: "volume.3")
                        .font(.caption)
                    Text(chord)
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
    MusicalChordButton(chord: "C", type: 2)
}
