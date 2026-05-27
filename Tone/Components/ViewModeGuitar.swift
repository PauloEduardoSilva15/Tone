//  ViewModeGuitar.swift
//

import SwiftUI

struct ViewModeGuitar: View {

    @Environment(CarouselViewModel.self) var viewModel

    var body: some View {

        VStack {

            if viewModel.campoHarmonicoAtual.count == 7 {

                HStack {

                    ForEach(0..<3, id: \.self) { index in

                        let acorde = viewModel.campoHarmonicoAtual[index]

                        GuitarRow(
                            chord: acorde.nome
                        )
                    }
                }
                HStack {

                    ForEach(3..<6, id: \.self) { index in

                        let acorde = viewModel.campoHarmonicoAtual[index]

                        GuitarRow(
                            chord: acorde.nome
                        )
                    }
                }

                HStack {

                    let acorde = viewModel.campoHarmonicoAtual[6]

                    GuitarRow(
                        chord: acorde.nome
                    )
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
