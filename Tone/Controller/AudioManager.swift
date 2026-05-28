//
//  AudioManager.swift
//  MiDiKeyboard
//
//  Created by Paulo Eduardo Barbosa da Silva on 15/05/26.
//



import Foundation
import AVFoundation

@Observable
class AdvancedAudioManager {
    private var audioEngine = AVAudioEngine()
    private var audioFile: AVAudioFile?

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

    // MARK: - Cálculo dinâmico de semitons

    /// Mapa de nota → semitom relativo a C
    private static let notaParaSemitom: [String: Float] = [
        "C": 0, "C#": 1, "Db": 1,
        "D": 2, "D#": 3, "Eb": 3,
        "E": 4, "Fb": 4, "E#": 5,
        "F": 5, "F#": 6, "Gb": 6,
        "G": 7, "G#": 8, "Ab": 8,
        "A": 9, "A#": 10, "Bb": 10,
        "B": 11, "Cb": 11, "B#": 0
    ]

    /// Intervalos de cada tipo de acorde (em semitons)
    private static let intervalos: [String: [Float]] = [
        "":    [0, 4, 7],   // maior
        "m":   [0, 3, 7],   // menor
        "º":   [0, 3, 6],   // diminuto
        "dim": [0, 3, 6]    // diminuto (variante)
    ]

    /// Separa "C#m" → raiz: "C#", sufixo: "m"
    private func separarAcorde(_ nome: String) -> (raiz: String, sufixo: String) {
        if nome.hasSuffix("dim") { return (String(nome.dropLast(3)), "dim") }
        if nome.hasSuffix("º")  { return (String(nome.dropLast(1)), "º") }
        if nome.hasSuffix("m")  { return (String(nome.dropLast(1)), "m") }
        return (nome, "")
    }

    /// Calcula os semitons absolutos pra qualquer acorde
    private func semitons(para nomeDoAcorde: String) -> [Float]? {
        let (raiz, sufixo) = separarAcorde(nomeDoAcorde)

        guard let semitonBase = Self.notaParaSemitom[raiz],
              let intervalo = Self.intervalos[sufixo]
        else { return nil }

        return intervalo.map { semitonBase + $0 }
    }

    // MARK: - Tocar

    func tocarAcorde(nomeDoAcorde: String) {
        guard let arquivo = audioFile else { return }

        audioEngine.stop()
        audioEngine = AVAudioEngine()

        guard let semitons = semitons(para: nomeDoAcorde) else {
            print("Acorde '\(nomeDoAcorde)' não reconhecido")
            return
        }

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
