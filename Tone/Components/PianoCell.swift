//
//  PianoCell.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//
import SwiftUI

struct TeclasBrancas: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    var isHighlighted: Bool
    var corApertada: Color
    
    var body: some View {
        
        Rectangle()
            .fill(isHighlighted ? corApertada : Color.white)
            .border(Color.black, width: 0.5)
            .frame(width: sizeClass == .regular ? 20.7 : 17 , height: sizeClass == .regular ? 80 : 55)
    }
}

struct TeclasPretas: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    var isHighlighted: Bool
    var corApertada: Color
    
    var body: some View {
        Rectangle()
            .fill(isHighlighted ? corApertada : Color.black)
            .frame(width: sizeClass == .regular ? 15 : 10, height: sizeClass == .regular ? 40 : 32)
            }
        }

struct Oitava: View {
    var notasDestacadas: [String]
    var corApertada: Color
    
    let notasBrancas = ["C", "D", "E", "F", "G", "A", "B"]
    let notasPretasGrupo1 = ["C#", "Eb"]
    let notasPretasGrupo2 = ["F#", "Ab", "Bb"]
    
    var body: some View {
        ZStack(alignment: .top) {
            
            HStack(spacing: 0) {
                ForEach(notasBrancas, id: \.self) { nota in
                    TeclasBrancas(isHighlighted: notasDestacadas.contains(nota), corApertada: corApertada)
                }
            }
            
            HStack(spacing: 7) {
                ForEach(notasPretasGrupo1, id: \.self) { nota in
                    TeclasPretas(isHighlighted: notasDestacadas.contains(nota), corApertada: corApertada)
                }
                
                Spacer()
                    .frame(width: 10)
                
                ForEach(notasPretasGrupo2, id: \.self) { nota in
                    TeclasPretas(isHighlighted: notasDestacadas.contains(nota), corApertada: corApertada)
                }
            }
            .padding(.leading, 1)
        }
    }
}


struct PianoCell: View {
    var acorde: Acorde?
    var corApertada: Color = .colorPrimary
    
    var body: some View {
        
        let notasOriginais = acorde?.notas ?? []
        
            let notas = notasOriginais.map { nota -> String in
                if MusicConstants.notes.contains(nota) {
                    return nota
                } else if let enarmonico = MusicConstants.equivalentesEnarmonicos[nota],                        MusicConstants.notes.contains(enarmonico) {
                    return enarmonico
                }
                return nota
            }
        
        let tonica = notas.first ?? "C"
        let indice = MusicConstants.notes.firstIndex(of: tonica) ?? 0
        
        let oitava1 = notas.filter { (MusicConstants.notes.firstIndex(of: $0) ?? 0) >= indice }
        let oitava2 = notas.filter { (MusicConstants.notes.firstIndex(of: $0) ?? 0) < indice }
        
            
            HStack(spacing: 0) {
                Oitava(notasDestacadas: oitava1, corApertada: corApertada)
                Oitava(notasDestacadas: oitava2, corApertada: corApertada)
            }
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.white, lineWidth: 1))
            .padding(5)
            
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PianoCell(acorde: Acorde(grau: "II", nome: "A", notas: ["A", "C#", "E"]))
    }
}
