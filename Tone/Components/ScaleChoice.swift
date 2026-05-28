//
//  File.swift
//  Tone
//
//  Created by Gabriel Groppo on 19/05/26.
//

import SwiftUI

struct ScaleChoice: View {
    @Environment(CarouselViewModel.self) var viewModel
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        HStack{
            ForEach(Escala.allCases, id: \.self) { scale in
                Button(action: {
                    viewModel.escolherEscala(scale)
                }) {
                    Text(scale.rawValue)
                        .font(sizeClass == .regular ? .title2 : .subheadline)
                        .fontWeight(.regular)
                        .foregroundColor(
                            viewModel.escalaSelecionada == scale
                            ? .white
                            : .black
                        )
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, sizeClass == .regular ? 8 : 6)
                        .background(
                            viewModel.escalaSelecionada == scale
                            ? .colorPrimary
                            : .clear
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 40))
                }
            }
        }
        .padding(5)
        .background(.colorSecondary)
        .clipShape(RoundedRectangle(cornerRadius: 40))
    }
}

#Preview {
    ScaleChoice()
        .environment(CarouselViewModel())
}
