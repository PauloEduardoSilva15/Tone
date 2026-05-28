//
//  MusicTypes.swift
//  Tone
//
//  Created by Igor Carrasco on 27/05/26.
//

import SwiftUI

enum Escala: String, CaseIterable {
    case maior = "Maior"
    case menor = "Menor"
}

enum TipoAcorde {
    case maior, menor, diminuto
}

struct Acorde: Hashable {
    let grau: String
    let nome: String
    let notas: [String]
}

enum Emocao: String, CaseIterable {
    case nenhum = "Nenhuma emoção"
    case alegria = "Alegria"
    case tristeza = "Tristeza"
    case tensao = "Tensão"
    
    var cor: Color {
        switch self {
        case .alegria: return .happy
        case .tristeza: return .sad
        case .tensao: return .fear
        case .nenhum: return .colorSecondary
        }
    }
}
