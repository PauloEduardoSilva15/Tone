//
//  EngineHarmonica.swift
//  Tone
//
//  Created by Igor Carrasco on 27/05/26.
//
import SwiftUI

struct EngineHarmonica {
    static func formarAcorde(tonica: String, tipo: TipoAcorde) -> [String] {
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
    
    static func gerarCampoHarmonico(tom: String, escala: Escala) -> [Acorde] {
        guard let indiceRaiz = MusicConstants.notes.firstIndex(of: tom) else { return [] }
        
        var campoHarmonico: [Acorde] = []
        
        let intervalos: [Int]
        let tipos: [TipoAcorde]
        let graus: [String]
        
        if escala == .maior {
            intervalos = [0, 2, 4, 5, 7, 9, 11]
            tipos = [.maior, .menor, .menor, .maior, .maior, .menor, .diminuto]
            graus = ["I", "II", "III", "IV", "V", "VI", "VII"]
        } else {
            intervalos = [0, 2, 3, 5, 7, 8, 10]
            tipos = [.menor, .diminuto, .maior, .menor, .menor, .maior, .maior]
            graus = ["I", "II", "III", "IV", "V", "VI", "VII"]
        }
        
        for i in 0..<7 {
            let indexDaNota = (indiceRaiz + intervalos[i]) % 12
            let notaRaiz = MusicConstants.notes[indexDaNota]
            let tipo = tipos[i]
            
            let sufixo = tipo == .menor ? "m" : (tipo == .diminuto ? "º" : "")
            let nomeAcorde = "\(notaRaiz)\(sufixo)"
            let notasAcorde = formarAcorde(tonica: notaRaiz, tipo: tipo)
            
            campoHarmonico.append(Acorde(grau: graus[i], nome: nomeAcorde, notas: notasAcorde))
        }
        campoHarmonico = corrigirEnarmonia(do: campoHarmonico, comTonica: tom)
        return campoHarmonico
    }
    
    private static func corrigirEnarmonia(do campoHarmonico: [Acorde], comTonica tonica: String) -> [Acorde] {
        let letrasMusicais = ["A", "B", "C", "D", "E", "F", "G"]
        
        guard let letraInicial = tonica.first?.uppercased(),
              let indiceLetraInicial = letrasMusicais.firstIndex(of: letraInicial)
        else { return campoHarmonico }
        
        let offsetsDaTríade = [0, 2, 4] // raiz, terça, quinta
        
        return campoHarmonico.enumerated().map { (grau, acorde) in
            
            // Corrige cada nota do acorde (tônica, terça, quinta)
            let notasCorrigidas = acorde.notas.enumerated().map { (i, nota) in
                let indiceLetraEsperada = (indiceLetraInicial + grau + offsetsDaTríade[i]) % 7
                let letraEsperada = letrasMusicais[indiceLetraEsperada]
                
                // Já está com a letra certa? Mantém
                if nota.hasPrefix(letraEsperada) { return nota }
                
                // Busca equivalente enarmônico
                if let equivalente = MusicConstants.equivalentesEnarmonicos[nota],
                   equivalente.hasPrefix(letraEsperada) {
                    return equivalente
                }
                
                return nota
            }
            
            // Reconstrói o nome do acorde com a raiz corrigida
            let raizCorrigida = notasCorrigidas[0]
            let sufixo = acorde.nome.hasSuffix("º") ? "º"
                       : acorde.nome.hasSuffix("m") ? "m"
                       : ""
            
            return Acorde(grau: acorde.grau, nome: "\(raizCorrigida)\(sufixo)", notas: notasCorrigidas)
        }
    }
    
}
