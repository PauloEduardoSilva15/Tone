//
//  PianoCell.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//
/*
import SwiftUI

struct TeclasBrancas: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        
        Rectangle()
            .fill(Color.white)
            .border(Color.black, width: 0.5)
            .frame(
                width: sizeClass == .compact ? 16 : 32,
                height: sizeClass == .compact ? 65 : 130)
    }
}

struct TeclasPretas: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    let Contador: Int
    
    var body: some View {
        
        HStack(spacing: sizeClass == .compact ? 6 : 12) {
            ForEach(0..<Contador, id: \.self) { _ in
                Rectangle()
                    .fill(Color.black)
                    .frame(
                        width: sizeClass == .compact ? 10 : 20,
                        height: sizeClass == .compact ? 40 : 80)
            }
        }
    }
}

struct Oitava: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        
        ZStack(alignment: .top) {
            HStack(spacing: 0) {
                ForEach(0..<7, id: \.self) { _ in
                    TeclasBrancas()
                }
            }
            
            HStack(spacing: sizeClass == .compact ? 0 : 12) {
                TeclasPretas(Contador: 2)
                
                Spacer()
                    .frame(width: 21)
                
                TeclasPretas(Contador: 3)
            }
            .padding(.leading, 1)
        }
    }
}

struct PianoCell: View {
    var body: some View {
        
        HStack(spacing: 0) {
            Oitava()
            Oitava()
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
        PianoCell()
    }
}
*/

import SwiftUI

struct TeclasBrancas: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    var isHighlighted: Bool
    
    var body: some View {
        
        Rectangle()
            .fill(isHighlighted ? Color.colorPrimary : Color.white)
            .border(Color.black, width: 0.5)
            .frame(width: sizeClass == .regular ? 20.7 : 16 , height: sizeClass == .regular ? 80 : 55)
    }
}

struct TeclasPretas: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    var isHighlighted: Bool
    
    var body: some View {
        Rectangle()
            .fill(isHighlighted ? Color.colorPrimary : Color.black)
            .frame(width: sizeClass == .regular ? 15 : 10, height: sizeClass == .regular ? 40 : 30)
            }
        }

struct Oitava: View {
    var notasDestacadas: [String] = ["C"]
    
    let notasBrancas = ["C", "D", "E", "F", "G", "A", "B"]
    let notasPretasGrupo1 = ["C#", "Eb"]
    let notasPretasGrupo2 = ["F#", "Ab", "Bb"]
    
    var body: some View {
        ZStack(alignment: .top) {
            
            HStack(spacing: 0) {
                ForEach(notasBrancas, id: \.self) { nota in
                    TeclasBrancas(isHighlighted: notasDestacadas.contains(nota))
                }
            }
            
            HStack(spacing: 4) {
                ForEach(notasPretasGrupo1, id: \.self) { nota in
                    TeclasPretas(isHighlighted: notasDestacadas.contains(nota))
                }
                
                Spacer()
                    .frame(width: 21)
                
                ForEach(notasPretasGrupo2, id: \.self) { nota in
                    TeclasPretas(isHighlighted: notasDestacadas.contains(nota))
                }
            }
            .padding(.leading, 1)
        }
    }
}


struct PianoCell: View {
    var acorde: Acorde?
    
    var body: some View {
        
        let notas = acorde?.notas ?? []
        let tonica = notas.first ?? "C"
        let indice = MusicConstants.notes.firstIndex(of: tonica) ?? 0
        
        let oitava1 = notas.filter { (MusicConstants.notes.firstIndex(of: $0) ?? 0) >= indice }
        let oitava2 = notas.filter { (MusicConstants.notes.firstIndex(of: $0) ?? 0) < indice }
        
            
            HStack(spacing: 0) {
                Oitava(notasDestacadas: oitava1)
                Oitava(notasDestacadas: oitava2)
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
