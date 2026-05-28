//
//  MusicalData.swift
//  Tone
//
//  Created by Igor Carrasco on 26/05/26.
//

import SwiftUI

struct GuitarFingerPosition: Hashable {
    let string: Int //corda
    let fret: Int //casa
}

struct Pestana {
    let fret: Int
    let startString: Int
    let endString: Int
}

enum GuitarChordLibrary {
    
    private static func separarRaizSufixo(_ nome: String) -> (String, String) {
        if nome.hasSuffix("m")  { return (String(nome.dropLast(1)), "m") }
        if nome.hasSuffix("º")  { return (String(nome.dropLast(1)), "º") }
        return (nome, "")
    }
    
    static func positions(for chord: String) -> [GuitarFingerPosition] {
        if let positions = chordsBase[chord] {
            return positions
        }
        // Separa raiz do sufixo (ex: "Dbm" → raiz "Db", sufixo "m")
        let (raiz, sufixo) = separarRaizSufixo(chord)
        
        if let enarmonico = MusicConstants.equivalentesEnarmonicos[raiz],
           let positions = chordsBase["\(enarmonico)\(sufixo)"] {
            return positions
        }
        
        return []
    }
    
    static func pestana(for chord: String) -> Pestana? {
        if let p = pestanasBase[chord] { return p }
        let (raiz, sufixo) = separarRaizSufixo(chord)
        if let enarmonico = MusicConstants.equivalentesEnarmonicos[raiz] {
            return pestanasBase["\(enarmonico)\(sufixo)"]
        }
        return nil
    }
    
    static let chordsBase: [String: [GuitarFingerPosition]] = [
        "C": [
            .init(string: 1, fret: 3),
            .init(string: 2, fret: 2),
            .init(string: 4, fret: 1)
        ],
        
        "C#": [
            .init(string: 1, fret: 4),
            .init(string: 2, fret: 3),
            .init(string: 4, fret: 2)
        ],
        
        "D": [
            .init(string: 1, fret: 2),
            .init(string: 2, fret: 3),
            .init(string: 3, fret: 2)
        ],
        
        "D#": [
            .init(string: 1, fret: 1),
            .init(string: 2, fret: 3),
            .init(string: 3, fret: 3)
        ],
        
        "E": [
            .init(string: 3, fret: 1),
            .init(string: 4, fret: 2),
            .init(string: 5, fret: 2)
        ],
        
        "F": [
            .init(string: 1, fret: 3),
            .init(string: 2, fret: 3),
            .init(string: 3, fret: 2)
        ],
        
        "F#": [
            .init(string: 1, fret: 4),
            .init(string: 2, fret: 4),
            .init(string: 3, fret: 3)
        ],
        
        "G": [
            .init(string: 0, fret: 3),
            .init(string: 1, fret: 2),
            .init(string: 4, fret: 3),
            .init(string: 5, fret: 3)
        ],
        
        "Ab": [
            .init(string: 1, fret: 6),
            .init(string: 2, fret: 6),
            .init(string: 3, fret: 5)
        ],
        
        "A": [
            .init(string: 2, fret: 2),
            .init(string: 3, fret: 2),
            .init(string: 4, fret: 2)
        ],
        
        "Bb": [
            .init(string: 2, fret: 3),
            .init(string: 3, fret: 3),
            .init(string: 4, fret: 3)
        ],
        
        "B": [
            .init(string: 2, fret: 4),
            .init(string: 3, fret: 4),
            .init(string: 4, fret: 4)
        ],
        
        "Cm": [
            .init(string: 4, fret: 4),
            .init(string: 2, fret: 5),
            .init(string: 3, fret: 5)
        ],
        
        "C#m": [
            .init(string: 4, fret: 5),
            .init(string: 2, fret: 6),
            .init(string: 3, fret: 6)
        ],
        
        "Dm": [
            .init(string: 1, fret: 1),
            .init(string: 2, fret: 3),
            .init(string: 3, fret: 2)
        ],
        
        "Ebm": [
            .init(string: 1, fret: 2),
            .init(string: 2, fret: 4),
            .init(string: 3, fret: 4)
        ],
        
        "Em": [
            .init(string: 4, fret: 2),
            .init(string: 5, fret: 2)
        ],
        
        "Fm": [
            .init(string: 1, fret: 3),
            .init(string: 2, fret: 4),
            .init(string: 3, fret: 3)
        ],
        
        "F#m": [
            .init(string: 1, fret: 5),
            .init(string: 2, fret: 7),
            .init(string: 3, fret: 7)
        ],
        
        "Gm": [
            .init(string: 1, fret: 3),
            .init(string: 2, fret: 3),
            .init(string: 3, fret: 3)
        ],
        
        "Abm": [
            .init(string: 1, fret: 6),
            .init(string: 2, fret: 6),
            //.init(string: 3, fret: 5)
        ],
        
        "Am": [
            .init(string: 2, fret: 2),
            .init(string: 3, fret: 2),
            .init(string: 4, fret: 1)
        ],
        
        "Bbm": [
            .init(string: 2, fret: 3),
            .init(string: 3, fret: 3),
            .init(string: 4, fret: 2)
        ],
        
        "Bm": [
            .init(string: 2, fret: 4),
            .init(string: 3, fret: 4),
            .init(string: 4, fret: 3)
        ],
    ]
    
    static let pestanasBase: [String: Pestana] = [
        
        "F": Pestana(fret: 1,startString: 0,endString: 5),
        
        "F#": Pestana(fret: 2,startString: 0,endString: 5),
        
        "Ab": Pestana(fret: 4,startString: 0,endString: 5),
        
        "Bb": Pestana(fret: 1,startString: 0,endString: 5),
        
        "B": Pestana(fret: 2,startString: 0,endString: 5),
        
        "Cm": Pestana(fret: 3, startString: 1, endString: 5),
        
        "C#": Pestana(fret: 1, startString: 0, endString: 5),
        
        "C#m": Pestana(fret: 4, startString: 1, endString: 5),
        
//        "Dbm": Pestana(fret: 4, startString: 0, endString: 5),
        
//        "D#m": Pestana(fret: 6, startString: 0, endString: 5),
        
        "Ebm": Pestana(fret: 6, startString: 0, endString: 5),
        
        "Fm": Pestana(fret: 1, startString: 0, endString: 5),
        
        "F#m": Pestana(fret: 2, startString: 0, endString: 5),
        
//        "Gbm": Pestana(fret: 2, startString: 0, endString: 5),
        
        "Gm": Pestana(fret: 3, startString: 0, endString: 5),
        
//        "G#m": Pestana(fret: 4, startString: 0, endString: 5),
        
        "Abm": Pestana(fret: 4, startString: 0, endString: 5),
        
//        "A#m": Pestana(fret: 1, startString: 0, endString: 5),
        
        "Bbm": Pestana(fret: 1, startString: 0, endString: 5),
        
        "Bm": Pestana(fret: 2, startString: 0, endString: 5),
        
//        "B#m": Pestana(fret: 4, startString: 0, endString: 5),
        
//        "Cbm": Pestana(fret: 2, startString: 0, endString: 5)
    ]
}

#Preview("Biblioteca Completa") {
    ScrollView {
        LazyVGrid(columns: [
            GridItem(.adaptive(minimum: 110), spacing: 12)
        ], spacing: 16) {
            ForEach(Array(GuitarChordLibrary.chordsBase.keys).sorted(), id: \.self) { nome in
                VStack(spacing: 4) {
                    Text(nome)
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    GuitarCell(
                        fingers: GuitarChordLibrary.chordsBase[nome] ?? [],
                        pestana: GuitarChordLibrary.pestanasBase[nome]
                    )
                }
            }
        }
        .padding()
    }
    .background(Color.black)
}
