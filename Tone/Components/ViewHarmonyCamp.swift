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
            //Text("Campo Harmônico")
            HStack{
                HarmonyCampCell(note: "C")
                HarmonyCampCell(note: "Dm")
                HarmonyCampCell(note: "Em")
            }
            HStack{
                HarmonyCampCell(note: "F")
                HarmonyCampCell(note: "G")
                HarmonyCampCell(note: "Am")
            }
            HStack{
                HarmonyCampCell(note: "Bº")
            }
        }
        
    }
}

#Preview {
    ViewHarmonyCamp()
}
