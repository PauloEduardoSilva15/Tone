//
//  NoteDictionary.swift
//  Tone
//
//  Created by Vitor Silva Souza on 22/05/26.
//

import SwiftUI

enum TipoEscala {
    case maior
    case menor
}

enum TipoAcorde {
    case maior, menor, diminuto
}

struct Acorde: Hashable {
    let grau: String
    let nome: String
    let notas: [String]
}

struct Sequencia {
    let notas = ["C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B"]
    
    
    func formarAcorde(tonica: String, tipo: TipoAcorde) -> [String] {
        guard let indice = notas.firstIndex(of: tonica) else { return [] }
        
        let terca: String
        let quinta: String
        
        switch tipo {
        case .maior:
            terca  = notas[(indice + 4) % 12]
            quinta = notas[(indice + 7) % 12]
            
        case .menor:
            terca  = notas[(indice + 3) % 12]
            quinta = notas[(indice + 7) % 12]
            
        case .diminuto:
            terca  = notas[(indice + 3) % 12]
            quinta = notas[(indice + 6) % 12]
        }
        return [notas[indice], terca, quinta]
    }
    

    func gerarCampoHarmonico(tom: String, escala: TipoEscala) -> [Acorde] {
        
        guard let indiceRaiz = notas.firstIndex(of: tom) else { return [] }
        
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
            let notaRaiz = notas[indexDaNota]
            let tipo = tipos[i]
            
            let sufixo = tipo == .menor ? "m" : (tipo == .diminuto ? "dim" : "")
            
            let nomeAcorde = "\(notaRaiz)\(sufixo)"
            
            let notasAcorde = formarAcorde(tonica: notaRaiz, tipo: tipo)
            
            campoHarmonico.append(Acorde(grau: graus[i], nome: nomeAcorde, notas: notasAcorde))
        }
        
        return campoHarmonico
    }
}



// Colocar no ViewHarmonyCamp
struct CampoHarmonicoView: View {
    let logica = Sequencia()
    
    @State private var tomAtual = "Eb"
    @State private var escalaAtual: TipoEscala = .menor
    
    var body: some View {
    
            let acordesGerados = logica.gerarCampoHarmonico(tom: tomAtual, escala: escalaAtual)
        
            let notas = logica.formarAcorde(tonica: tomAtual, tipo: .maior)
        
                VStack {
                    ForEach(acordesGerados, id: \.nome) { acorde in
                        
                        HarmonyCampCell(
                            grau: acorde.grau,
                            note: acorde.nome
                        )
        
                        
                        
                    }
                }
                .padding()
            
                
            
        }
    }
    

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        CampoHarmonicoView()
    }
}





//struct CampoHarmonicoPreview: View {
//    let logica = LogicaMusical()
//    let tomEscolhido = "C"
//    let escalaEscolhida: TipoEscala = .maior
//    
//    var body: some View {
//        VStack {
//            
//            Text("\(tomEscolhido) \(escalaEscolhida == .maior ? "Maior" : "Menor")")
//            
//            let campo =
//            logica.gerarCampoHarmonico(tom: tomEscolhido, escala: escalaEscolhida)
//            
//            ForEach(campo, id: \.nome) { acorde in
//                HStack {
//                    Text(acorde.nome)
//                        .foregroundStyle(Color.red)
//                    
//                    Text(acorde.notas.joined(separator: " - "))
//                }
//            }
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    CampoHarmonicoPreview()
//}


