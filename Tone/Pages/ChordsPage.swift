//  ChordsPage.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//
import SwiftUI

struct ChordsPage: View {
    @Environment(CarouselViewModel.self) var viewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var sizeClass
    var body: some View {
        ViewThatFits(in: .horizontal){
            //deitado
            HorizontalChords()
            //em pé
            VerticalChords()
        }
        .navigationBarBackButtonHidden(true)}
}

#Preview {
    NavigationStack {
        ChordsPage()
            .environment(CarouselViewModel())
    }
}
