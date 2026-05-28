//
//  ViewModeChord.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 21/05/26.
//

import SwiftUI


public struct ViewModeChord: View {
    @Environment(CarouselViewModel.self) var viewModel
    
    public var body: some View {
        VStack {
            ForEach(viewModel.campoHarmonicoAtual, id: \.self) { acorde in
                ChordRow(acorde: acorde)
            }
        }
    }
}

#Preview {
    ViewModeChord()
        .environment(CarouselViewModel())
}

