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
        
    var body: some View {
        @Bindable var viewModelBind = viewModel // Precisa passar pois precisa de um Binding no ScrollPosition
        
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
                        
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .center, spacing: CarouselConfig.spacing) {
                    ForEach(0..<MusicConstants.notes.count * CarouselConfig.itemMultiplier, id: \.self) { globalIndex in
                        let totalNotes = MusicConstants.notes.count
                        let current = viewModel.scrolledID ?? 0
                        let realIndex = globalIndex % MusicConstants.notes.count
                        let distance = abs((globalIndex - current) % totalNotes)
                        
                        NoteCircle(note: MusicConstants.notes[realIndex], distance: distance, sizeClass: sizeClass)
                            .id(globalIndex)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            
            .scrollPosition(id: $viewModelBind.scrolledID, anchor: .center)
            
            .defaultScrollAnchor(.center)
            .safeAreaPadding(.horizontal, lateralPadding(screenWidth: screenWidth))
            .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.7), value: viewModel.scrolledID)
        }
        .frame(height: sizeClass == .regular ? 130 : 80)
        .task {
            guard viewModel.scrolledID == nil else { return }
            try? await Task.sleep(for: .milliseconds(50)) // para dar um timming do app iniciar com nota no carrossel
            let totalItems = MusicConstants.notes.count * CarouselConfig.itemMultiplier
            viewModel.inicializarScrollPosition(totalItems: totalItems)
            // Faz o carrossel ficar infinito, pois cuida do reset do index do array notes
        }
    }
    
    private func lateralPadding(screenWidth: CGFloat) -> CGFloat {
        let containerWidth = CarouselConfig.containerWidth(for: sizeClass)
        return (screenWidth - containerWidth) / 2
    }
}

private enum CarouselConfig {
    static let itemMultiplier = 1000
    static let spacing: CGFloat = 10
    
    static func containerWidth(for sizeClass: UserInterfaceSizeClass?) -> CGFloat {
        sizeClass == .compact ? 80 : 195
    }
}

struct NoteCircle: View {
    let note: String
    let distance: Int
    let sizeClass: UserInterfaceSizeClass?
    
    private var isSelected: Bool { distance == 0 }
    private var isNeighbor: Bool { distance == 1 }
    
    private var size: CGFloat {
        let sizes: (selected: CGFloat, neighbor: CGFloat, base: CGFloat) =
        sizeClass == .compact ? (80, 55, 35) : (130, 80, 50)
        return isSelected ? sizes.selected : (isNeighbor ? sizes.neighbor : sizes.base)
    }
    private var opacity: Double {
        isSelected ? 1 : (isNeighbor ? 0.8 : 0.5)
    }
    private var circleColor: Color {
        isSelected ? .colorPrimary : .colorSecondary.opacity(opacity)
    }
    private var font: Font {
        let fonts: (selected: Font, neighbor: Font, base: Font) =
        sizeClass == .compact
        ? (.title2, .body, .caption)
        : (.largeTitle, .title, .title3)
        return isSelected ? fonts.selected : (isNeighbor ? fonts.neighbor : fonts.base)
    }
    
    var body: some View {
        Circle()
            .fill(circleColor)
            .frame(width: size, height: size)
            .overlay(
                Text(note)
                    .foregroundStyle(isSelected ? .white : .black)
                    .font(font)
                    .fontWeight(.semibold)
            )
            .opacity(opacity)
    }
}

#Preview {
    ChoiceKeyCarroussel()
        .padding(20)
        .environment(CarouselViewModel())
}
