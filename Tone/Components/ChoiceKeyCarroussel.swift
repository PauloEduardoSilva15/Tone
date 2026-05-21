////
////  ChoiceKeyCarroussel.swift
////  Tone
////
////  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
////
//
import SwiftUI

struct ChoiceKeyCarroussel: View {
    // viewModel CarrousselViewModel controla e armazena as variáveis da Tonalidade
    @State private var viewModel = CarouselViewModel()
    @Environment(\.horizontalSizeClass) var sizeClass
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    private let itemMultiplier = 1000
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            
            // Definição dos tamanhos dos círculos
            let containerWidth: CGFloat = sizeClass == .compact ? 65 : 180
            let spacing: CGFloat = 10

            // e dita quanto espaço sobra nas laterais para exibir os vizinhos
            let lateralPadding = (screenWidth - containerWidth) / 2
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .center, spacing: spacing) {
                    ForEach(0..<viewModel.notes.count * itemMultiplier, id: \.self) { globalIndex in
                        let realIndex = globalIndex % viewModel.notes.count
                        let note = viewModel.notes[realIndex]
                        
                        // Descobre a distância entre o selecionado e os demais círculos
                        let currentSelectedID = viewModel.scrolledID ?? 0
                        let distance = abs(globalIndex - currentSelectedID)
                        
                        // Define as distâncias: se for 0 ele está selecionado. Se for 1, é um dos vizinhos próximos
                        let isSelected = distance == 0
                        let isNeighboor = distance == 1
                        // definição dos tamanhos
                        
                        let selectedSize: CGFloat = sizeClass == .compact ? 80 : 160
                        let neighborSize: CGFloat = sizeClass == .compact ? 55 : 110
                        let defaultSize: CGFloat = sizeClass == .compact ? 35 : 70
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
//                            .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.7), value: isSelected)
                            //.animation(.interactiveSpring(response: 0.5, dampingFraction: 0.9), value: isNeighboor)
                            .containerRelativeFrame(.horizontal, alignment: .center) // Aligns to screen width
                            //.padding(.horizontal, isNeighboor ? 15 : 0) // tentei, mas buga o centro do carrossel mais vezes
                    }
                }
                .scrollTargetLayout() // Required for view-aligned snapping
            }
            .scrollTargetBehavior(.viewAligned) // Ensures it snaps to cards
            .scrollPosition(id: $viewModel.scrolledID)
            .safeAreaPadding(.horizontal, lateralPadding)
            .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.7), value: viewModel.scrolledID)
        }
        //.frame(height: 120)
        .onAppear {
            // Faz o carrossel ficar infinito, pois cuida do reset do index do array notes
            let middleFactor = itemMultiplier / 2
            let initialIndex = middleFactor * viewModel.notes.count
            viewModel.scrolledID = initialIndex
        }
    }
}

#Preview {
    ChoiceKeyCarroussel()
        .padding(20)
}
