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
    var body: some View {
        
        Rectangle()
            .fill(Color.white)
            .border(Color.black, width: 0.5)
            .frame(width: sizeClass == .regular ? 20.7 : 16 , height: sizeClass == .regular ? 80 : 55)
    }
}

struct TeclasPretas: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    let Contador: Int
    var body: some View {
        
        HStack(spacing: 6) {
            ForEach(0..<Contador, id: \.self) { _ in
                Rectangle()
                    .fill(Color.black)
                    .frame(width: sizeClass == .regular ? 15 : 10, height: sizeClass == .regular ? 40 : 30)
            }
        }
    }
}

struct Oitava: View {
    var body: some View {
        
        ZStack(alignment: .top) {
            HStack(spacing: 0) {
                ForEach(0..<7, id: \.self) { _ in
                    TeclasBrancas()
                }
            }
            
            HStack(spacing: 0) {
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

