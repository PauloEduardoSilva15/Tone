//  ViewModeGuitar.swift
//

import SwiftUI

struct ViewModeGuitar: View {

    @Environment(CarouselViewModel.self) var viewModel

    private var linhas: [[Acorde]] {
        guard viewModel.campoHarmonicoAtual.count == 7 else { return [] }
        return [
            Array(viewModel.campoHarmonicoAtual[0..<3]),
            Array(viewModel.campoHarmonicoAtual[3..<6]),
            Array(viewModel.campoHarmonicoAtual[6..<7])
        ]
    }
    
    var body: some View {
        VStack {
            if !linhas.isEmpty {
                ForEach(linhas.indices, id: \.self) { linhaIndex in
                    HStack {
                        ForEach(linhas[linhaIndex], id: \.self) { acorde in
                            GuitarRow(acorde: acorde)
                        }
                    }
                }
            } else {
                Text("Selecione um tom")
                .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ViewModeGuitar()
            .environment(CarouselViewModel())
    }
}
