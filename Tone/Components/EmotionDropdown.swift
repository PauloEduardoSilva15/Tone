//
//  EmotionPicker.swift
//  Tone
//
//  Created by Gabriel Groppo on 19/05/26.
//
import SwiftUI

struct EmotionDropdown: View {
    @Environment(CarouselViewModel.self) var viewModel
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var isExpanded = false

    var body: some View {
        Button(action: {
            isExpanded.toggle()
        }) {
            HStack {
                Text(viewModel.sentimentoSelecionado.rawValue)
                    .foregroundColor(.black)
                    .font(sizeClass == .regular ? .title2 : .default)
                    .fontWeight(sizeClass == .regular ? .semibold : .regular)
                Spacer()
                
                Image(systemName: "chevron.down")
                    .foregroundColor(.black)
                    .rotationEffect(
                        .degrees(isExpanded ? 180 : 0)
                    )
                    .animation(.easeInOut(duration: 0.2), value: isExpanded)
            }
            .padding(sizeClass == .regular ? 18 : 12)
            .background(.colorSecondary)
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .overlay(alignment: .topLeading) {
            if isExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    
                    ForEach(Emocao.allCases, id: \.self) { emocao in
                        
                        Button(action: {
                            viewModel.escolherSentimento(emocao)
                            isExpanded = false
                        }) {
                            
                            HStack {
                                
                                Text(emocao.rawValue)
                                    .foregroundColor(.black)
                                    .font(sizeClass == .regular ? .title2 : .body)
                                    .fontWeight(sizeClass == .regular ? .semibold : .regular)
                                
                                Spacer()
                                
                                if viewModel.sentimentoSelecionado == emocao {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.colorPrimary)
                                        .fontWeight(.bold)
                                }
                            }
                            .padding(10)
                        }
                        
                        Divider()
                    }
                }
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.colorSecondary)
                )
                .shadow(color: .black.opacity(0.3), radius: 10)
            }
        }
    }
}


struct EmotionDropdownComTxtProgressao: View {
    @Environment(CarouselViewModel.self) var viewModel
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var isExpanded = false
    
    private var progressaoAtual: String? {
        guard viewModel.sentimentoSelecionado != .nenhum,
              let graus = MusicConstants.progressao[viewModel.escalaSelecionada]?[viewModel.sentimentoSelecionado]
        else { return nil }
        
        return graus.joined(separator: " - ")
    }

    var body: some View {
        Button(action: {
            isExpanded.toggle()
        }) {
            HStack {
                Text(viewModel.sentimentoSelecionado.rawValue
                     + (progressaoAtual != nil ? "  →  \(progressaoAtual!)" : ""))
                    .foregroundColor(.black)
                    .font(sizeClass == .regular ? .title2 : .body)
                    .fontWeight(sizeClass == .regular ? .semibold : .regular)
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .foregroundColor(.black)
                    .rotationEffect(
                        .degrees(isExpanded ? 180 : 0)
                    )
                    .animation(.easeInOut(duration: 0.2), value: isExpanded)
            }
            .padding(sizeClass == .regular ? 18 : 12)
            .background(.colorSecondary)
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .overlay(alignment: .topLeading) {
            if isExpanded {
                VStack(alignment: .leading, spacing: 0) {
                    
                    ForEach(Emocao.allCases, id: \.self) { emocao in
                        
                        Button(action: {
                            viewModel.escolherSentimento(emocao)
                            isExpanded = false
                        }) {
                            
                            HStack {
                                
                                Text(emocao.rawValue)
                                    .foregroundColor(.black)
                                    .font(sizeClass == .regular ? .title2 : .body)
                                    .fontWeight(sizeClass == .regular ? .semibold : .regular)
                                
                                Spacer()
                                
                                if viewModel.sentimentoSelecionado == emocao {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.colorPrimary)
                                        .fontWeight(.bold)
                                }
                            }
                            .padding(10)
                        }
                        
                        Divider()
                    }
                }
                .padding(6)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.colorSecondary)
                )
                .shadow(color: .black.opacity(0.3), radius: 10)
            }
        }
    }
}

#Preview("Sem texto") {
    EmotionDropdown()
        .environment(CarouselViewModel())
}

#Preview("Com texto da progressão") {
    EmotionDropdownComTxtProgressao()
        .environment(CarouselViewModel())
}
