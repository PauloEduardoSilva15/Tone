//
//  ViewHarmonyCamp.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct ViewHarmonyCamp: View {
    var body: some View {
        VStack {
            HStack {
                HarmonyCampCell(grau: "I", note: "C")
                HarmonyCampCell(grau: "II",note: "Dm")
                HarmonyCampCell(grau: "III",note: "Em")
            }
            
            HStack {
                HarmonyCampCell(grau: "IV",note: "F")
                HarmonyCampCell(grau: "V",note: "G")
                HarmonyCampCell(grau: "VI",note: "Am")
            }
            HStack { 
                HarmonyCampCell(grau: "VII",note: "Bº")
            }
        }
        
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ViewHarmonyCamp()
    }
}
