//
//  MusicalData.swift
//  Tone
//
//  Created by Igor Carrasco on 26/05/26.
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
    
    static func corParaGrau(_ grau: String, escala: Escala, emocao: Emocao) -> Color {
        guard emocao != .nenhum,
              let graus = progressao[escala]?[emocao],
              graus.contains(grau)
        else { return .colorSecondary }

        return emocao.cor
    }
    static func numerosDaProgressao(
        para grau: String,
        escala: Escala,
        emocao: Emocao
    ) -> [Int] {
        
        guard emocao != .nenhum,
              let graus = progressao[escala]?[emocao]
        else {
            return []
        }
        
        var numeros: [Int] = []
        
        for (index, grauAtual) in graus.enumerated() {
            
            if grauAtual == grau {
                numeros.append(index + 1)
            }
        }
        
        return numeros
    }
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

struct EngineHarmonica {
    private func formarAcorde(tonica: String, tipo: TipoAcorde) -> [String] {
        guard let indice = MusicConstants.notes.firstIndex(of: tonica) else { return [] }
        
        let terca: String
        let quinta: String
        
        switch tipo {
        case .maior:
            terca  = MusicConstants.notes[(indice + 4) % 12]
            quinta = MusicConstants.notes[(indice + 7) % 12]
            
        case .menor:
            terca  = MusicConstants.notes[(indice + 3) % 12]
            quinta = MusicConstants.notes[(indice + 7) % 12]
            
        case .diminuto:
            terca  = MusicConstants.notes[(indice + 3) % 12]
            quinta = MusicConstants.notes[(indice + 6) % 12]
        }
        return [MusicConstants.notes[indice], terca, quinta]
    }
    
    func gerarCampoHarmonico(tom: String, escala: Escala) -> [Acorde] {
        guard let indiceRaiz = MusicConstants.notes.firstIndex(of: tom) else { return [] }
        
        var campoHarmonico: [Acorde] = []
        
        let intervalos: [Int]
        let tipos: [TipoAcorde]
        let graus: [String]
        
        if escala == .maior {
            intervalos = [0, 2, 4, 5, 7, 9, 11]
            tipos = [.maior, .menor, .menor, .maior, .maior, .menor, .diminuto]
            graus = ["I", "II", "III", "IV", "V", "VI", "VIIº"]
        } else {
            intervalos = [0, 2, 3, 5, 7, 8, 10]
            tipos = [.menor, .diminuto, .maior, .menor, .menor, .maior, .maior]
            graus = ["I", "II", "III", "IV", "V", "VI", "VII"]
        }
        
        for i in 0..<7 {
            let indexDaNota = (indiceRaiz + intervalos[i]) % 12
            let notaRaiz = MusicConstants.notes[indexDaNota]
            let tipo = tipos[i]
            
            let sufixo = tipo == .menor ? "m" : (tipo == .diminuto ? "dim" : "")
            let nomeAcorde = "\(notaRaiz)\(sufixo)"
            let notasAcorde = formarAcorde(tonica: notaRaiz, tipo: tipo)
            
            campoHarmonico.append(Acorde(grau: graus[i], nome: nomeAcorde, notas: notasAcorde))
        }
        
        return campoHarmonico
    }
}
