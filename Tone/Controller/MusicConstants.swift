//
//  MusicConstants.swift
//  Tone
//
//  Created by Igor Carrasco on 27/05/26.
//
import SwiftUI

enum MusicConstants {
    static let notes = ["C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B"]
    
    static let progressao: [Escala: [Emocao : [String]]] = [
        .maior: [
            .alegria: ["I", "IV", "V", "IV"],
            .tristeza: ["I", "II", "IV", "IV"],
            .tensao: ["VI", "III", "IV", "IV"]
            ],
        .menor: [
            .alegria: ["VI", "V", "V", "I"],
            .tristeza: ["I", "IV", "V", "V"],
            .tensao: ["I", "V", "VI", "VI"]
        ]
    ]
    
    static let equivalentesEnarmonicos: [String: String] = [
        "C#": "Db", "Db": "C#",
        "D#": "Eb", "Eb": "D#",
        "F#": "Gb", "Gb": "F#",
        "G#": "Ab", "Ab": "G#",
        "A#": "Bb", "Bb": "A#",
        "B": "Cb", "Cb": "B",
        "B#": "C", "C": "B#",
        "E": "Fb", "Fb": "E",
        "F": "E#", "E#": "F",
    ]
    
    static func corParaGrau(_ grau: String, escala: Escala, emocao: Emocao) -> Color {
        guard emocao != .nenhum,
              let graus = progressao[escala]?[emocao],
              graus.contains(grau)
        else { return .colorSecondary }

        return emocao.cor
    }
    
    static func numerosDaProgressao(para grau: String, escala: Escala, emocao: Emocao) -> [Int] {
        guard emocao != .nenhum,
              let graus = progressao[escala]?[emocao]
        else {
            return []
        }
        
// "Filtre os que batem e pegue os índices"
        return graus.enumerated()
            .filter { $0.element == grau }
            .map { $0.offset + 1 }
    }
}
