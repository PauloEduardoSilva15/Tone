//
//  VerticalMain.swift
//  Tone
//
//  Created by Gabriel Groppo on 25/05/26.
//


import SwiftUI

struct VerticalMain: View {
    @State private var showAcordes: Bool = false
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    
    // 1. Criamos a variável que vai gerenciar a lógica desta tela
    @State private var viewModel = CarouselViewModel()
    
    var body: some View {
        ZStack{
            Image("BackGroundImage")
                .resizable()
                .frame(height: .infinity) // .ignoresSafeArea() talvez seja melhor aqui dependendo do seu design
            
            // AnimatedStarsOverlay() // Descomente se tiver esse componente no seu projeto
            
            VStack{
                VStack{
                    Image(isIpad ? "MediumLogo" : "SmallLogo")
                        .padding(.trailing, isIpad ? 580 : 280)
                        .padding(.top, isIpad ? 100 : 60)
                    Spacer()
                    
                    Text("Escolha o tom")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(isIpad ? .title : .title2)
                        .fontWeight(isIpad ? .bold : .semibold)
                    ChoiceKeyCarroussel()
                        .padding(.vertical, 15)
                    //Spacer()
                    
                    Text("Escolha a escala")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(isIpad ? .title : .title2)
                        .fontWeight(isIpad ? .bold : .semibold)
                        .padding(.bottom, isIpad ? 30 : 10)
                    
                    ScaleChoice()
                        .padding(.bottom, isIpad ? 30 : 10)
                    
                    
                    Text("Quer expressar algo?")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(isIpad ? .title : .title2)
                        .fontWeight(isIpad ? .bold : .semibold)
                        .padding(.bottom, isIpad ? 20 : 10)
                    
                    HStack{
                        EmotionDropdown()
                            .padding(.vertical, 10)
                            
                        Spacer()
                        // PlayButton(corEmocao: Color("ColorPrimary")) // Descomente se tiver
                    }
                    .padding(.bottom, 10)
                }

                Spacer()
                VStack{
                    
                    Text("Campo Harmônico")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(isIpad ? .title : .title2)
                        .fontWeight(isIpad ? .bold : .semibold)
                    
                    // 2. Passamos o viewModel para a ViewHarmonyCamp!
                    ViewHarmonyCamp(viewModel: viewModel)
                        .padding(.top, 10)
                        .padding(.bottom, isIpad ? 20 : 10)
                    
                    
                    Button(action:{
                        showAcordes = true
                    }) {
                        Text("Ver Acordes")
                            .font(isIpad ? .title : .body)
                            .foregroundStyle(Color.white)
                            .frame(width: isIpad ? 230: 120, height: isIpad ? 50 : 32)
                            .background(Color("ColorPrimary"))
                            .cornerRadius(40)
                        
                    }
                    .navigationDestination(isPresented: $showAcordes){
                        // ChordsPage() // Descomente se tiver
                    }
                    .padding(.bottom, isIpad ? 200 : 100)
                    Spacer()
                }
            }
            .frame(maxWidth: isIpad ? 450 : 320)
            .padding(.top, isIpad ? 100 : 60)
        }
        // 3. Injetamos o viewModel no ambiente para o Carrossel, Escala e Emoção conseguirem usá-lo
        .environment(viewModel)
    }
}

#Preview {
    VerticalMain()
}
