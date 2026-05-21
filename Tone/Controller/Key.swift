//
//  Key.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI
import Observation

@Observable
class CarouselViewModel {
    let notes = ["C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B"]
    
    var notaSelecionada: String = ""
    
    private var selectionTask: Task<Void, Never>?
    
    // O ID que o ScrollView vai controlar
    var scrolledID: Int? {
        didSet {
            // Sempre que o ID mudar, essa função é disparada
            // Toda vez que o ID muda, agendamos a validação com um "await"
            agendarSelecaoComDelay()
        }
    }
    
    // Função que recebe a nota selecionada e armazena na variável notaSelecionada, após aguardar 150ms (para evitar mudanças muito drásticas) e printa a nota selecionada (para debug)
    private func agendarSelecaoComDelay() {
        selectionTask?.cancel()
        
        selectionTask = Task {
            guard let currentID = scrolledID else { return }
            
            do {
                try await Task.sleep(for: .milliseconds(150))
                
                // Descobre o índice da nota selecionada dentro da array de notas
                let realIndex = currentID % notes.count
                let notaFinal = notes[realIndex]
                
                await MainActor.run {
                    self.notaSelecionada = notaFinal
                    print("🎵 Nota Selecionada: \(notaSelecionada) (ID: \(currentID))")
                }
            } catch {
                
            }
        }
    }
}
