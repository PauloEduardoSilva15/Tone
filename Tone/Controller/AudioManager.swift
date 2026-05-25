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
    
    // Exemplo: Acorde de Dó Maior (C = 0, E = 4 semitons acima, G = 7 semitons acima)
    let dicionarioDeAcordes: [String: [Float]] = {
        return [
            "C" : [0, 4, 7],        // C, E, G
            "C#": [1, 5, 8],        // C, F, G#
            "Dm": [2, 5, 9],        // D, F, A
            "Eb": [3, 7, 10],       // C#, G, A#
            "Em": [4, 7, 11],       // E, G, B
            "F" : [5, 9, 12],       // F, A, C
            "F#": [6, 10, 13],      // F#, A#, C#
            "G" : [7, 11, 14],      // G, B, D
            "Ab": [8, 12, 15],      // G#, C, D#
            "Am": [9, 12, 16],      // A, C, E
            "Bb": [10, 14, 17],     // A#, D, F
            "Bº": [11, 14, 17],     // B, D, F
            "Cb": [11, 15, 18]      // B, D#, F#
        ]
    }()
    
    init(filepath: String) {
        configurarEngine(filepath: filepath)
    }
    
    private func configurarEngine(filepath: String) {
        
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

        audioEngine.stop()
        audioEngine = AVAudioEngine()
        
        guard let semitons = dicionarioDeAcordes[nomeDoAcorde] else { return }
        
        var playersParaAtivar: [AVAudioPlayerNode] = []
        
        for semitom in semitons {
            let playerNode = AVAudioPlayerNode()
            let pitchNode = AVAudioUnitTimePitch()
            
            pitchNode.pitch = semitom * 100
            
            audioEngine.attach(playerNode)
            audioEngine.attach(pitchNode)
            
            audioEngine.connect(playerNode, to: pitchNode, format: arquivo.processingFormat)
            audioEngine.connect(pitchNode, to: audioEngine.mainMixerNode, format: arquivo.processingFormat)
            
            playerNode.scheduleFile(arquivo, at: nil, completionHandler: nil)
            
            playersParaAtivar.append(playerNode)
        }
        
        do {
            try audioEngine.start()
            for player in playersParaAtivar {
                player.play()
            }
            
        } catch {
            print("Erro ao iniciar a Engine de Áudio: \(error.localizedDescription)")
        }
    }
}
