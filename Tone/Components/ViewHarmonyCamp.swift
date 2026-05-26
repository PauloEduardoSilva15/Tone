//
//  ViewHarmonyCamp.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct ViewHarmonyCamp: View {
    
    @State var viewModel: CarouselViewModel
    //@Environment(CarouselViewModel.self) var viewModel
    
    var body: some View {
        VStack {
            HStack {
                HarmonyCampCell(grau: "I", note: "C", isHighlighted: true, numeroProgressao: 1, corEmocao: .yellow)
                HarmonyCampCell(grau: "II",note: "Dm", isHighlighted: false, numeroProgressao: nil, corEmocao: .yellow)
                HarmonyCampCell(grau: "III",note: "Em", isHighlighted: false, numeroProgressao: nil, corEmocao: .yellow)
            }
            
            HStack {
                HarmonyCampCell(grau: "IV",note: "F", isHighlighted: true, numeroProgressao: 4, corEmocao: .yellow)
                HarmonyCampCell(grau: "V",note: "G", isHighlighted: true, numeroProgressao: 2, corEmocao: .yellow)
                HarmonyCampCell(grau: "VI",note: "Am", isHighlighted: true, numeroProgressao: 3, corEmocao: .yellow)
            }
            HStack {
                HarmonyCampCell(grau: "VII",note: "Bº", isHighlighted: false, numeroProgressao: 1, corEmocao: .yellow)
            }
        }
    }
}

#Preview {
    ViewHarmonyCamp(viewModel: CarouselViewModel())
}
