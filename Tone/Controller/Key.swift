//
//  Key.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI
/////////////////////////////////////////////////////////
// Precisa importar Combina para o protocolo ObservableObject
import Combine
/////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////
// Tipar a classe como ObservableObject
class KeyModel: ObservableObject {
/////////////////////////////////////////////////////////
    let notes = ["C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B"]

    /////////////////////////////////////////////////////////
    // @Published para as variáveis que serão alteradas nas views
    @Published var notaSelecionada: String = ""
    @Published var sentimentoSelecionado: String = "Nenhuma emoção"
    @Published var escalaSelecionada: String = "Maior"
    /////////////////////////////////////////////////////////
    
    private var selectionTask: Task<Void, Never>?
    
    var scrolledID: Int? {
        didSet {
            agendarSelecaoComDelay()
            print("Nota: \(notaSelecionada)\nSentimento: \(sentimentoSelecionado)\nEscala: \(escalaSelecionada)")
        }
    }
    
    private func agendarSelecaoComDelay() {
        selectionTask?.cancel()
        
        selectionTask = Task {
            guard let currentID = scrolledID else { return }
            
            do {
                try await Task.sleep(for: .milliseconds(10))
                
                let realIndex = currentID % notes.count
                let notaFinal = notes[realIndex]
                
                await MainActor.run {
                    self.notaSelecionada = notaFinal
                }
            } catch {}
        }
    }
    
    func escolherSentimento(add emotion: String) {
        sentimentoSelecionado = emotion
    }
    
    func escolherEscala(add scale: String) {
        escalaSelecionada = scale
    }
}
