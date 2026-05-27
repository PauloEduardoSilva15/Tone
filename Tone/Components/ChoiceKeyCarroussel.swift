////
////  ChoiceKeyCarroussel.swift
////  Tone
////
////  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
////
//

import SwiftUI

struct ChoiceKeyCarroussel: View {
    @Environment(CarouselViewModel.self) var viewModel
    @Environment(\.horizontalSizeClass) var sizeClass
    
    private let itemMultiplier = 1000
    
    var body: some View {
        @Bindable var viewModel = viewModel // Precisa passar pois precisa de um Binding no ScrollPosition
        
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            
            // Definição dos tamanhos dos círculos
            let containerWidth: CGFloat = sizeClass == .compact ? 80 : 195
            let spacing: CGFloat = 10
            
            // e dita quanto espaço sobra nas laterais para exibir os vizinhos
            let lateralPadding = (screenWidth - containerWidth) / 2
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .center, spacing: spacing) {
                    ForEach(0..<MusicConstants.notes.count * itemMultiplier, id: \.self) { globalIndex in
                        let realIndex = globalIndex % MusicConstants.notes.count
                        let note = MusicConstants.notes[realIndex]
                        
                        // Descobre a distância entre o selecionado e os demais círculos
                        let currentSelectedID = viewModel.scrolledID ?? 0
                        let distance = abs(globalIndex - currentSelectedID)
                        
                        // Define as distâncias: se for 0 ele está selecionado. Se for 1, é um dos vizinhos próximos
                        let isSelected = distance == 0
                        let isNeighboor = distance == 1
                        
                        // definição dos tamanhos
                        let selectedSize: CGFloat = sizeClass == .compact ? 80 : 130
                        let neighborSize: CGFloat = sizeClass == .compact ? 55 : 80
                        let defaultSize: CGFloat = sizeClass == .compact ? 35 : 50
                        let size: CGFloat = isSelected ? selectedSize : (isNeighboor ? neighborSize : defaultSize)
                        let opacictyCircle: Double = isSelected ? 1 : (isNeighboor ? 0.8 : 0.5)
                        
                        let circleColor: Color = isSelected ? .colorPrimary : (isNeighboor ? .colorSecondary : .colorSecondary.opacity(opacictyCircle))
                        let textColor: Color = isSelected ? .white : .black
                        
                        let selectedFont: Font = sizeClass == .compact ? .title2 : .largeTitle
                        let neighborFont: Font = sizeClass == .compact ? .body : .title
                        let defaultFont: Font = sizeClass == .compact ? .caption : .title3
                        let textFont: Font = isSelected ? selectedFont : (isNeighboor ? neighborFont : defaultFont)
                        
                        Circle()
                            .fill(circleColor)
                            .frame(width: size, height: size)
                            .overlay(
                                Text("\(note)")
                                    .foregroundStyle(textColor)
                                    .font(textFont)
                                    .fontWeight(.semibold)
                            )
                            .opacity(opacictyCircle)
                            .id(globalIndex)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            
            .scrollPosition(id: $viewModel.scrolledID, anchor: .center)
            
            .defaultScrollAnchor(.center)
            .safeAreaPadding(.horizontal, lateralPadding)
            .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.7), value: viewModel.scrolledID)
        }
        .frame(height: sizeClass == .regular ? 130 : 80)
        .onAppear {
            // Faz o carrossel ficar infinito, pois cuida do reset do index do array notes
            let middleFactor = itemMultiplier / 2
            let initialIndex = middleFactor * MusicConstants.notes.count
            viewModel.scrolledID = initialIndex
        }
    }
}

#Preview {
    ChoiceKeyCarroussel()
        .padding(20)
        .environment(CarouselViewModel())
}
