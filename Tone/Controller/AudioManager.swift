//
//  AudioManager.swift
//  MiDiKeyboard
//
//  Created by Paulo Eduardo Barbosa da Silva on 15/05/26.
//

import Foundation
import AVFoundation
import Combine

@Observable
class AdvancedAudioManager{
    private var audioEngine = AVAudioEngine()
    private var audioFile: AVAudioFile?
    
    // Dicionário mapeando o acorde para os semitons que o compõem (em relação ao Dó)
    // Exemplo: Acorde de Dó Maior (Dó = 0, Mi = 4 semitons acima, Sol = 7 semitons acima)
    let dicionarioDeAcordes: [String: [Float]] = {
        return [
            "C": [0, 4, 7],      // C, E, G
            "Dm": [2, 5, 9],      // D, F, A
            "Em": [4, 7, 11],     // E, G, B
            "F": [5, 9, 12],     // F, A, C
            "G": [7, 11, 14],   // G, B, D
            "Am": [9, 12, 16],     // A, C, E
            "Bº": [11, 14, 17]
        ]
    }()
    
    init(filepath: String) {
        configurarEngine(filepath: filepath)
    }
    
    private func configurarEngine(filepath: String) {
        
        // Carrega o seu único arquivo de áudio base (precisa ser a nota Dó/C para a matemática bater)
        guard let url = Bundle.main.url(forResource: filepath, withExtension: "mp3") else {
            print("Erro: Arquivo base '\(filepath).mp3' não encontrado.")
            return
        }
        
        do {
            audioFile = try AVAudioFile(forReading: url)
        } catch {
            print("Erro ao carregar o arquivo base: \(error)")
        }
    }
    

    func tocarAcorde(nomeDoAcorde: String) {
        guard let arquivo = audioFile else { return }

        // 1. Para e limpa a engine anterior se houver
        audioEngine.stop()
        audioEngine = AVAudioEngine()
        
        guard let semitons = dicionarioDeAcordes[nomeDoAcorde] else { return }
        
        // Criamos uma array temporária para guardar os players que vamos tocar
        var playersParaAtivar: [AVAudioPlayerNode] = []
        
        // 2. Configura e conecta todos os nós na estrutura da Engine
        for semitom in semitons {
            let playerNode = AVAudioPlayerNode()
            let pitchNode = AVAudioUnitTimePitch()
            
            pitchNode.pitch = semitom * 100
            
            audioEngine.attach(playerNode)
            audioEngine.attach(pitchNode)
            
            audioEngine.connect(playerNode, to: pitchNode, format: arquivo.processingFormat)
            audioEngine.connect(pitchNode, to: audioEngine.mainMixerNode, format: arquivo.processingFormat)
            
            // Agenda o arquivo (isso carrega o áudio na agulha do player, mas não toca ainda)
            playerNode.scheduleFile(arquivo, at: nil, completionHandler: nil)
            
            // Guarda a referência do player configurado
            playersParaAtivar.append(playerNode)
        }
        
        // 3. PRIMEIRO: Liga o motor principal (A Engine de Áudio)
        do {
            try audioEngine.start()
            
            // 4. SEGUNDO: Agora que a engine está rodando 100%, manda os players tocarem
            for player in playersParaAtivar {
                player.play()
            }
            
        } catch {
            print("Erro ao iniciar a Engine de Áudio: \(error.localizedDescription)")
        }
    }
}
