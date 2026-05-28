//
//  GuitarCell.swift
//  Tone
//

import SwiftUI

struct LinhaHorizontal: View {

    var body: some View {

        HStack(spacing: 0) {

            ForEach(0..<6, id: \.self) { i in

                Rectangle()
                    .fill(Color.black)
                    .frame(width: 1)

                if i < 5 {
                    Spacer()
                }
            }
        }
    }
}

struct LinhaVertical: View {

    var body: some View {

        VStack(spacing: 0) {

            Rectangle()
                .fill(Color.black)
                .frame(height: 6)

            Spacer()

            ForEach(0..<4, id: \.self) { i in

                Rectangle()
                    .fill(Color.black)
                    .frame(height: 1)

                if i < 3 {
                    Spacer()
                }
            }
        }
    }
}

struct GuitarCell: View {

    let fingers: [GuitarFingerPosition]
    let pestana: Pestana?

    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {

        GeometryReader { geometry in

            let gridWidth = sizeClass == .regular ? 108.0 : 75.0
            let gridHeight = sizeClass == .regular ? 108.0 : 75.0

            ZStack {

                Color.colorSecondary

                // GRID DO BRAÇO
                ZStack {

                    LinhaHorizontal()
                    LinhaVertical()

                    // PESTANA
                    if let pestana {

                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.colorPrimary)
                            .frame(
                                width: pestanaWidth(
                                    start: pestana.startString,
                                    end: pestana.endString,
                                    totalWidth: gridWidth
                                ),
                                height: sizeClass == .regular ? 14 : 10
                            )
                            .position(
                                x: pestanaCenterX(
                                    start: pestana.startString,
                                    end: pestana.endString,
                                    width: gridWidth
                                ),

                                y: yPosition(
                                    fret: pestana.fret,
                                    height: gridHeight
                                )
                            )
                    }

                    // DEDOS
                    ForEach(fingers, id: \.self) { finger in

                        Circle()
                            .fill(Color.colorPrimary)
                            .frame(
                                width: sizeClass == .regular ? 14 : 10,
                                height: sizeClass == .regular ? 14 : 10
                            )
                            .position(
                                x: xPosition(
                                    string: finger.string,
                                    width: gridWidth
                                ),

                                y: yPosition(
                                    fret: finger.fret,
                                    height: gridHeight
                                )
                            )
                    }
                }
                .frame(
                    width: gridWidth,
                    height: gridHeight
                )
                .padding(8)
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

    // POSIÇÃO DAS CORDAS
    func xPosition(string: Int, width: CGFloat) -> CGFloat {

        let spacing = width / 5

        return CGFloat(string) * spacing
    }

    // POSIÇÃO DAS CASAS
    func yPosition(fret: Int, height: CGFloat) -> CGFloat {

        let spacing = height / 3.8

        return CGFloat(fret - 1) * spacing + spacing / 1.8
    }

    // LARGURA DA PESTANA
    func pestanaWidth(
        start: Int,
        end: Int,
        totalWidth: CGFloat
    ) -> CGFloat {

        let spacing = totalWidth / 5

        return CGFloat(end - start) * spacing + 14
    }

    // CENTRO DA PESTANA
    func pestanaCenterX(
        start: Int,
        end: Int,
        width: CGFloat
    ) -> CGFloat {

        let startX = xPosition(
            string: start,
            width: width
        )

        let endX = xPosition(
            string: end,
            width: width
        )

        return (startX + endX) / 2
    }
}

#Preview {

    ZStack {

        Color.black.ignoresSafeArea()

        GuitarCell(
            fingers: GuitarChordLibrary.chordsBase["F"] ?? [],
            pestana: GuitarChordLibrary.pestanasBase["F"]
        )
    }
}
