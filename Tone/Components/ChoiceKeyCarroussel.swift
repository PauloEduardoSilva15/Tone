////
////  ChoiceKeyCarroussel.swift
////  Tone
////
////  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
////
//
import SwiftUI

struct ChoiceKeyCarroussel: View {
    let notes = ["C", "C#", "D", "Eb", "E", "F", "F#", "G", "Ab", "A", "Bb", "B"]
    
    private let itemMultiplier = 1000
    
    @State private var scrolledID: Int?
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            
            // Definição dos tamanhos dos círculos
            let selectedWidth: CGFloat = 85
            let spacing: CGFloat = 16

            // O cálculo mágico: posiciona o elemento selecionado exatamente no centro
            // e dita quanto espaço sobra nas laterais para exibir os vizinhos
            let lateralPadding = (screenWidth - selectedWidth) / 2
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .center, spacing: spacing) {
                    ForEach(0..<notes.count * itemMultiplier, id: \.self) { globalIndex in
                        let realIndex = globalIndex % notes.count
                        let note = notes[realIndex]
                        
                        // Descobre a distância entre o selecionado e os demais círculos
                        let currentSelectedID = scrolledID ?? 0
                        let distance = abs(globalIndex - currentSelectedID)
                        
                        // Define as distâncias: se for 0 ele está selecionado. Se for 1, é um dos vizinhos próximos
                        let isSelected = distance == 0
                        let isNeighboor = distance == 1
                        
                        // definição dos tamanhos
                        let size: CGFloat = isSelected ? 80 : (isNeighboor ? 55 : 35)
                        let opacictyCircle: Double = isSelected ? 1 : (isNeighboor ? 0.8 : 0.5)
                        
                        let circleColor: Color = isSelected ? .colorPrimary : (isNeighboor ? .colorSecondary : .colorSecondary.opacity(opacictyCircle))
                        let textColor: Color = isSelected ? .white : .black
                        let textFont: Font = isSelected ? .title2 : (isNeighboor ? .body : .caption)
                                                
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
                            .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.7), value: isSelected)
                            //.animation(.interactiveSpring(response: 0.5, dampingFraction: 0.9), value: isNeighboor)
                            .containerRelativeFrame(.horizontal, alignment: .center) // Aligns to screen width
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
        .padding(20)
}
