//
//  ChoiceKeyCarroussel.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct ChoiceKeyCarroussel: View {
    var body: some View {
        SnappingCarousel()
    }
    
}
    
struct SnappingCarousel: View {
    let notes = ["C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B"]
    
    private let itemMultiplier = 1000
    
    @State private var scrolledID: Int?

    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            
            // Definição dos tamanhos dos círculos
            let selectedWidth: CGFloat = 85
            let unselectedWidth: CGFloat = 50
            let spacing: CGFloat = 1
            
            // O cálculo mágico: posiciona o elemento selecionado exatamente no centro
            // e dita quanto espaço sobra nas laterais para exibir os vizinhos
            let lateralPadding = (screenWidth - selectedWidth) / 2
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: spacing) {
                    ForEach(0..<notes.count * itemMultiplier, id: \.self) { globalIndex in
                        let realIndex = globalIndex % notes.count
                        let note = notes[realIndex]
                        
                        let isSelected = globalIndex == scrolledID
                        
                        Circle()
                            .fill(isSelected ? .colorPrimary : .colorSecondary.opacity(0.5))
                            .frame(width: isSelected ? selectedWidth : unselectedWidth, height: isSelected ? selectedWidth : unselectedWidth)
                            .overlay(
                                Text("\(note)")
                                    .foregroundStyle(isSelected ? .white : .black)
                                    .font(isSelected ? .title2 : .callout)
                                    .fontWeight(.semibold)
                            )
                            .opacity(isSelected ? 1 : 0.4)
                            .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.7), value: isSelected)
                            .containerRelativeFrame(.horizontal) // Aligns to screen width
                    }
                }
                .scrollTargetLayout() // Required for view-aligned snapping
            }
            .scrollTargetBehavior(.viewAligned) // Ensures it snaps to cards
            .scrollPosition(id: $scrolledID)
            .safeAreaPadding(.horizontal, lateralPadding)
        }
        .frame(height: 120)
        .onAppear { // Faz o carrossel ficar infinito, pois cuida do reset do index do array notes
            let middleFactor = itemMultiplier / 2
            let initialIndex = middleFactor * notes.count
            scrolledID = initialIndex
        }
    }
}

#Preview {
    ChoiceKeyCarroussel()
}
