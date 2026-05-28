///  MainPage.swift
//  Tone
//
//  Created by Paulo Eduardo Barbosa da Silva on 19/05/26.
//

import SwiftUI

struct MainPage: View {
     var body: some View {
        ViewThatFits(in: .horizontal){
            //Deitado
            HorizontalMain()
            //Em pé
            VerticalMain()
        }
        .navigationBarBackButtonHidden(true)
    }
}
#Preview {
    MainPage()
        .environment(CarouselViewModel())
}
