//
//  HorizontalMain.swift
//  Tone
//
//  Created by Gabriel Groppo on 25/05/26.
//

import SwiftUI

struct HorizontalMain: View {
    @Environment(CarouselViewModel.self) var viewModel
    @State private var showAcordes: Bool = false
    let isIpad = UIDevice.current.userInterfaceIdiom == .pad
    @State private var audioPiano: AdvancedAudioManager = AdvancedAudioManager(filepath: "Audios/C_Piano")
    @State private var progressionTask: Task<Void, Never>? = nil
    var body: some View {
        ZStack{
            Image("BackGroundImage")
                .resizable()
                .ignoresSafeArea()
            
            AnimatedStarsOverlay()
            
            HStack{
                VStack(alignment: .leading){
                    Image(isIpad ? "MediumLogo" : "SmallLogo")
                        .padding(.trailing )
                        
                    Spacer()
                    VStack{
                        Text("Escolha o tom")
                            .foregroundStyle(Color("ColorSecondary"))
                            .font(isIpad ? .title : .title2)
                            .fontWeight(isIpad ? .bold : .semibold)
                        
                        ChoiceKeyCarroussel()
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                        
                        Text("Escolha a escala")
                            .foregroundStyle(Color("ColorSecondary"))
                            .font(isIpad ? .title : .title2)
                            .fontWeight(isIpad ? .bold : .semibold)
                            .padding(.bottom, 30)
                        
                        ScaleChoice()
                            .padding(.bottom, 40)
                        
                        
                        Text("Quer expressar algo?")
                            .foregroundStyle(Color("ColorSecondary"))
                            .font(isIpad ? .title : .title2)
                            .fontWeight(isIpad ? .bold : .semibold)
                            .padding(.bottom, 20)
                        
                        HStack{
                            EmotionDropdown()
                                .padding(.vertical, 10)
                                .zIndex(1)
                            Spacer()
                            PlayButton(){
                                PlayProgression()
                            }
                        }
                        .padding(.bottom, 120)
                        
                    }
                    .frame(width: 450)
                    .padding(.horizontal, 70)
                    Spacer()
                }
                VStack{
                    Spacer()
                    Text("Campo Harmônico")
                        .foregroundStyle(Color("ColorSecondary"))
                        .font(isIpad ? .title : .title2)
                        .fontWeight(isIpad ? .bold : .semibold)
                    
                    ViewHarmonyCamp()
                        .padding(.top, 8)
                        .padding(.bottom, 10)
                    
                    Button(action:{
                        showAcordes = true
                    }) {
                        Text("Ver Acordes")
                            .font(isIpad ? .title : .body)
                            .foregroundStyle(Color.white)
                            .frame(width: isIpad ? 230: 150, height: isIpad ? 50 : 50)
                            .background(Color("ColorPrimary"))
                            .cornerRadius(40)
                        
                    }
                    .navigationDestination(isPresented: $showAcordes){
                            ChordsPage()
                                //.environment(viewModel)
                    }
                    .padding(.bottom, isIpad ? 70 : 60)
                    Spacer()
                }
                .frame(width: 300)
                .padding(.horizontal, 100)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, isIpad ? 40 : 60)
        }
        .onDisappear {
            StopAudio()
        }
    }
    
    private func PlayProgression() {
        if progressionTask != nil {
            progressionTask?.cancel()
            progressionTask = nil
            
            print("Execução anterior cancelada. Reiniciando...")
        }

        let escalaAtual = viewModel.escalaSelecionada
        let emocaoAtual = viewModel.sentimentoSelecionado
        let campoHarmonico = viewModel.campoHarmonicoAtual

        guard emocaoAtual != .nenhum else { return }
        guard !campoHarmonico.isEmpty else { return }

        guard let grausDaProgressao = MusicConstants.progressao[escalaAtual]?[emocaoAtual] else { return }

        let acordesParaTocar = grausDaProgressao.compactMap { grauRomano -> String? in
            let alvo = grauRomano.uppercased()
            return campoHarmonico.first(where: { $0.grau.uppercased() == alvo })?.nome
        }
        progressionTask = Task {
            for nomeDoAcorde in acordesParaTocar {
                if Task.isCancelled { break }
                
                print("Tocando acorde: \(nomeDoAcorde)")
                
                await MainActor.run {
                    audioPiano.tocarAcorde(nomeDoAcorde: nomeDoAcorde)
                }
                
                do {
                    try await Task.sleep(for: .seconds(1))
                } catch {
                    break
                }
            }
            
            // Quando a progressão terminar naturalmente de tocar todos os acordes,
            // limpamos a propriedade de estado para que ela fique pronta para a próxima.
            progressionTask = nil
        }
    }
    
    private func StopAudio() {
        progressionTask?.cancel()
        progressionTask = nil
        
        print("O usuário saiu da tela ou resetou o áudio. Parando tudo.")
    }
}

#Preview {
    HorizontalMain()
        .environment(CarouselViewModel())
}
