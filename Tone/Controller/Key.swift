//
//  Key.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI
import Observation

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


@Observable
class CarouselViewModel {
    let notes = ["C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B"]
    
    var notaSelecionada: String = "C"
    var sentimentoSelecionado: String = "Nenhuma emoção"
    var escalaSelecionada: String = "Maior"
    
    var campoHarmonicoAtual: [Acorde] = []
    
    private let sequenciaHarmonica = Sequencia()
    
    private var selectionTask: Task<Void, Never>?
    
    var scrolledID: Int? {
        didSet {
            agendarSelecaoComDelay()
        }
    }
    
    init() {
            atualizarCampoHarmonico()
        }
    
    private func agendarSelecaoComDelay() {
        selectionTask?.cancel()
        
        selectionTask = Task {
            guard let currentID = scrolledID else { return }
            
            do {
                try await Task.sleep(for: .milliseconds(800))
                
                let realIndex = currentID % notes.count
                let notaFinal = notes[realIndex]
                
                await MainActor.run {
                    self.notaSelecionada = notaFinal
                    print("Nota Selecionada: \(notaSelecionada) (ID: \(currentID))")
                    
                    self.atualizarCampoHarmonico()
                }
            } catch {
            }
        }
    }
    
    func escolherSentimento(add emotion: String) {
        sentimentoSelecionado = emotion
        print(sentimentoSelecionado)
    }
    
    func escolherEscala(add scale: String) {
        escalaSelecionada = scale
        print(escalaSelecionada)
        
        atualizarCampoHarmonico()
    }
    
    
    private func atualizarCampoHarmonico() {
        guard !notaSelecionada.isEmpty else { return }
        
        let tipoDaEscala: TipoEscala = (escalaSelecionada.lowercased() == "maior") ? .maior : .menor
        
        campoHarmonicoAtual = sequenciaHarmonica.gerarCampoHarmonico(tom: notaSelecionada, escala: tipoDaEscala)
        
        print("Campo Harmônico de \(notaSelecionada) \(escalaSelecionada) atualizado:")
        print(campoHarmonicoAtual.map { $0.nome })
    }
}
