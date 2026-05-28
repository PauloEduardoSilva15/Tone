//
//  Key.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI
import Observation

@Observable
@MainActor
class CarouselViewModel {
    var notaSelecionada: String = "C"
    var sentimentoSelecionado: Emocao = .nenhum
    var sentimentoAtivo: Emocao = .nenhum
    var escalaSelecionada: Escala = .maior
    var campoHarmonicoAtual: [Acorde] = []
    
    private var selectionTask: Task<Void, Never>?
    
    var scrolledID: Int? {
        didSet {
            agendarSelecaoComDelay()
        }
    }
    
    func inicializarScrollPosition(totalItems: Int) {
        guard scrolledID == nil else { return }
        scrolledID = (totalItems / 2) - ((totalItems / 2) % MusicConstants.notes.count)
    }
    
    init() {
        atualizarCampoHarmonico()
    }
    
    func printDebug() {
        print(campoHarmonicoAtual.map { $0.nome })
        print("Nota: \(notaSelecionada)\nSentimento: \(sentimentoSelecionado)\nEscala: \(escalaSelecionada)")
    }
    
    private func agendarSelecaoComDelay() {
        selectionTask?.cancel()
        
        selectionTask = Task {
            guard let currentID = scrolledID else { return }
            
            do {
                try await Task.sleep(for: .milliseconds(300))
                
                let realIndex = currentID % MusicConstants.notes.count
                let notaFinal = MusicConstants.notes[realIndex]
                
                self.notaSelecionada = notaFinal
                self.atualizarCampoHarmonico()
            } catch is CancellationError {
                
            } catch {
                print("Erro inesperado aconteceu em agendarSelecaoComDelay: \(error)")
            }
        }
    }
    
    private func atualizarCampoHarmonico() {
        guard !notaSelecionada.isEmpty else { return }
        
        campoHarmonicoAtual = EngineHarmonica.gerarCampoHarmonico(tom: notaSelecionada, escala: escalaSelecionada)
        
        printDebug()
    }
    
    func escolherSentimento(_ emocao: Emocao) {
        sentimentoSelecionado = emocao
        atualizarCampoHarmonico()
    }
    
    func escolherEscala(_ escala: Escala) {
        escalaSelecionada = escala
        atualizarCampoHarmonico()
    }
    
//    func aplicarEmocao() {
//        sentimentoAtivo = sentimentoSelecionado
//    }
}
    
