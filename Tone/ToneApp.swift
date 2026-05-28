//
//  ToneApp.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

@main
struct ToneApp: App {
    @State private var viewModel = CarouselViewModel()
    
    var body: some Scene {
        WindowGroup {
            EntryPage()
                //.environment(CarouselViewModel())
                .environment(viewModel)
        }
    }
}
