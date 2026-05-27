//
//  ViewModePiano.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 20/05/26.
//


import SwiftUI

struct ViewModePiano: View {
    
    @Environment(CarouselViewModel.self) var viewModel

    var body: some View {
        
        VStack {
            ForEach(viewModel.campoHarmonicoAtual, id: \.nome) { acorde in
                
                PianoRow(acorde: acorde)
                
            }
        }
    }
}

#Preview {
    ViewModePiano()
        .environment(CarouselViewModel())
}
