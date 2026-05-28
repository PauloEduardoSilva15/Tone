//
//  GuitarCell.swift
//  Tone
//

import SwiftUI

// MARK: - Cordas (6 linhas verticais)
struct Cordas: View {
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<6, id: \.self) { i in
                Rectangle()
                    .fill(.black)
                    .frame(width: 1)
                if i < 5 { Spacer() }
            }
        }
    }
}

// MARK: - Trastes (linhas horizontais + nut condicional)
struct Trastes: View {
    let showNut: Bool

    var body: some View {
        VStack(spacing: 0) {
            // Nut grosso só quando começa na casa 1
            Rectangle()
                .fill(.black)
                .frame(height: showNut ? 6 : 1)

            Spacer()

            ForEach(0..<4, id: \.self) { i in
                Rectangle()
                    .fill(.black)
                    .frame(height: 1)
                if i < 3 { Spacer() }
            }
        }
    }
}

// MARK: - Guitar Cell
struct GuitarCell: View {
    let fingers: [GuitarFingerPosition]
    let pestana: Pestana?

    @Environment(\.horizontalSizeClass) var sizeClass

    private let visibleFrets = 4
    private let numStrings = 6

    // MARK: - Casa base
    private var baseFret: Int {
        var frets = fingers.map { $0.fret }
        if let pestana { frets.append(pestana.fret) }
        let minFret = frets.min() ?? 1
        let maxFret = frets.max() ?? 1

        // Só normaliza se o acorde NÃO cabe nas 4 casas visíveis
        if maxFret <= visibleFrets { return 1 }

        return minFret
    }

    private var showNut: Bool { baseFret == 1 }
    private var showFretLabel: Bool { baseFret > 1 }

    private var gridWidth: CGFloat { sizeClass == .regular ? 108.0 : 75.0 }
    private var gridHeight: CGFloat { sizeClass == .regular ? 108.0 : 75.0 }
    private var dotSize: CGFloat { sizeClass == .regular ? 14 : 10 }
    
    private var fretLabelPosition: (x: CGFloat, y: CGFloat) {
        if let pestana {
            return (
                x: 8 + pestanaCenterX(start: pestana.startString, end: pestana.endString),
                y: 8 + yPosition(fret: pestana.fret) // ← sem o "- 16", fica NA pestana
            )
        } else if let firstFinger = fingers.min(by: { $0.fret < $1.fret }) {
            return (
                x: 8 + xPosition(string: firstFinger.string),
                y: 8 + yPosition(fret: firstFinger.fret)
            )
        }
        return (x: 0, y: 0)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.colorSecondary

                // GRID DO BRAÇO
                ZStack {
                    Cordas()
                    Trastes(showNut: showNut)

                    // PESTANA
                    if let pestana {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.colorPrimary)
                            .frame(
                                width: pestanaWidth(start: pestana.startString, end: pestana.endString),
                                height: dotSize
                            )
                            .position(
                                x: pestanaCenterX(start: pestana.startString, end: pestana.endString),
                                y: yPosition(fret: pestana.fret)
                            )
                    }

                    // DEDOS
                    ForEach(fingers, id: \.self) { finger in
                        Circle()
                            .fill(.colorPrimary)
                            .frame(width: dotSize, height: dotSize)
                            .position(
                                x: xPosition(string: finger.string),
                                y: yPosition(fret: finger.fret)
                            )
                    }
                }
                .frame(width: gridWidth, height: gridHeight)
                .padding(8)

                // LABEL DA CASA — fora do grid, dentro da célula
                if showFretLabel {
                    Text("\(baseFret)ª casa")
                        .font(sizeClass == .regular ? .caption : .system(size: 9))
                        .foregroundColor(.colorSecondary)
                        .fontWeight(.semibold)
                        .position(x: fretLabelPosition.x, y: fretLabelPosition.y)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.black, lineWidth: 2)
            )
        }
        .frame(
            width: sizeClass == .regular ? 140 : 90,
            height: sizeClass == .regular ? 140 : 90
        )
    }

    // MARK: - Posicionamento

    func xPosition(string: Int) -> CGFloat {
        let spacing = gridWidth / 5
        return CGFloat(string) * spacing
    }

    func yPosition(fret: Int) -> CGFloat {
        let normalizedFret = fret - baseFret
        let sectionHeight = gridHeight / CGFloat(visibleFrets)
        return (CGFloat(normalizedFret) + 0.5) * sectionHeight
    }

    func pestanaWidth(start: Int, end: Int) -> CGFloat {
        let spacing = gridWidth / 5
        return CGFloat(end - start) * spacing + dotSize
    }

    func pestanaCenterX(start: Int, end: Int) -> CGFloat {
        (xPosition(string: start) + xPosition(string: end)) / 2
    }
}

#Preview("Casa 1 - com nut") {
    ZStack {
        Color.black.ignoresSafeArea()
        GuitarCell(
            fingers: GuitarChordLibrary.positions(for: "C"),
            pestana: GuitarChordLibrary.pestana(for: "C")
        )
    }
}

#Preview("Casa alta - com label") {
    ZStack {
        Color.black.ignoresSafeArea()
        GuitarCell(
            fingers: GuitarChordLibrary.positions(for: "G#m"),
            pestana: GuitarChordLibrary.pestana(for: "G#m"))
    }
}

//import SwiftUI
//
//struct LinhaHorizontal: View {
//
//    var body: some View {
//
//        HStack(spacing: 0) {
//
//            ForEach(0..<6, id: \.self) { i in
//
//                Rectangle()
//                    .fill(Color.black)
//                    .frame(width: 1)
//
//                if i < 5 {
//                    Spacer()
//                }
//            }
//        }
//    }
//}
//
//struct LinhaVertical: View {
//
//    var body: some View {
//
//        VStack(spacing: 0) {
//
//            Rectangle()
//                .fill(Color.black)
//                .frame(height: 6)
//
//            Spacer()
//
//            ForEach(0..<4, id: \.self) { i in
//
//                Rectangle()
//                    .fill(Color.black)
//                    .frame(height: 1)
//
//                if i < 3 {
//                    Spacer()
//                }
//            }
//        }
//    }
//}
//
//struct GuitarCell: View {
//
//    let fingers: [GuitarFingerPosition]
//    let pestana: Pestana?
//
//    @Environment(\.horizontalSizeClass) var sizeClass
//
//    var body: some View {
//
//        GeometryReader { geometry in
//
//            let gridWidth = sizeClass == .regular ? 108.0 : 75.0
//            let gridHeight = sizeClass == .regular ? 108.0 : 75.0
//
//            ZStack {
//
//                Color.colorSecondary
//
//                // GRID DO BRAÇO
//                ZStack {
//
//                    LinhaHorizontal()
//                    LinhaVertical()
//
//                    // PESTANA
//                    if let pestana {
//
//                        RoundedRectangle(cornerRadius: 8)
//                            .fill(Color.colorPrimary)
//                            .frame(
//                                width: pestanaWidth(
//                                    start: pestana.startString,
//                                    end: pestana.endString,
//                                    totalWidth: gridWidth
//                                ),
//                                height: sizeClass == .regular ? 14 : 10
//                            )
//                            .position(
//                                x: pestanaCenterX(
//                                    start: pestana.startString,
//                                    end: pestana.endString,
//                                    width: gridWidth
//                                ),
//
//                                y: yPosition(
//                                    fret: pestana.fret,
//                                    height: gridHeight
//                                )
//                            )
//                    }
//
//                    // DEDOS
//                    ForEach(fingers, id: \.self) { finger in
//
//                        Circle()
//                            .fill(Color.colorPrimary)
//                            .frame(
//                                width: sizeClass == .regular ? 14 : 10,
//                                height: sizeClass == .regular ? 14 : 10
//                            )
//                            .position(
//                                x: xPosition(
//                                    string: finger.string,
//                                    width: gridWidth
//                                ),
//
//                                y: yPosition(
//                                    fret: finger.fret,
//                                    height: gridHeight
//                                )
//                            )
//                    }
//                }
//                .frame(
//                    width: gridWidth,
//                    height: gridHeight
//                )
//                .padding(8)
//            }
//            .clipShape(RoundedRectangle(cornerRadius: 20))
//            .overlay(
//                RoundedRectangle(cornerRadius: 20)
//                    .stroke(Color.black, lineWidth: 2)
//            )
//        }
//        .frame(
//            width: sizeClass == .regular ? 140 : 90,
//            height: sizeClass == .regular ? 140 : 90
//        )
//    }
//
//    // POSIÇÃO DAS CORDAS
//    func xPosition(string: Int, width: CGFloat) -> CGFloat {
//
//        let spacing = width / 5
//
//        return CGFloat(string) * spacing
//    }
//
//    // POSIÇÃO DAS CASAS
//    func yPosition(fret: Int, height: CGFloat) -> CGFloat {
//
//        let spacing = height / 3.8
//
//        return CGFloat(fret - 1) * spacing + spacing / 1.8
//    }
//
//    // LARGURA DA PESTANA
//    func pestanaWidth(
//        start: Int,
//        end: Int,
//        totalWidth: CGFloat
//    ) -> CGFloat {
//
//        let spacing = totalWidth / 5
//
//        return CGFloat(end - start) * spacing + 14
//    }
//
//    // CENTRO DA PESTANA
//    func pestanaCenterX(
//        start: Int,
//        end: Int,
//        width: CGFloat
//    ) -> CGFloat {
//
//        let startX = xPosition(
//            string: start,
//            width: width
//        )
//
//        let endX = xPosition(
//            string: end,
//            width: width
//        )
//
//        return (startX + endX) / 2
//    }
//}

#Preview {

    ZStack {

        Color.black.ignoresSafeArea()

        GuitarCell(
            fingers: GuitarChordLibrary.chordsBase["F"] ?? [],
            pestana: GuitarChordLibrary.pestanasBase["F"]
        )
    }
}

#Preview("Debug Label") {
    VStack(spacing: 20) {
        // Esse TEM que mostrar o label
        VStack {
            Text("G#m")
                .foregroundColor(.white)
            GuitarCell(
                fingers: GuitarChordLibrary.chordsBase["G#m"] ?? [],
                pestana: GuitarChordLibrary.pestanasBase["G#m"]
            )
            // Debug: mostra os valores
            let frets = (GuitarChordLibrary.chordsBase["G#m"] ?? []).map { $0.fret }
            Text("frets: \(frets.map(String.init).joined(separator: ",")) | pestana: \(GuitarChordLibrary.pestanasBase["G#m"]?.fret ?? -1)")
                .font(.caption2)
                .foregroundColor(.gray)
        }

        // Esse NÃO mostra label (cabe no grid)
        VStack {
            Text("C")
                .foregroundColor(.white)
            GuitarCell(
                fingers: GuitarChordLibrary.chordsBase["C"] ?? [],
                pestana: GuitarChordLibrary.pestanasBase["C"]
            )
        }
    }
    .padding()
    .background(Color.black)
}
