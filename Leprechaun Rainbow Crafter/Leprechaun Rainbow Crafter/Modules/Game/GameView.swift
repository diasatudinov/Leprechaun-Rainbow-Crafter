import SwiftUI
import SpriteKit

struct GameView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var achievements: AchievementsViewModel
    @State var valueName = "-"
    @State var achivement1 = false
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GameSceneView(valueName: $valueName, achivement1: $achivement1).ignoresSafeArea()
                
                VStack {
                    ZStack {
                        HStack {
                            Spacer()
                            ZStack {
                                Image(.quizVariant)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 75)
                                
                                VStack(spacing: -7) {
                                    Text("NOW")
                                        .font(.custom(Fonts.tiltWarp.rawValue, size: 15))
                                        .foregroundStyle(.white)
                                    Text(valueName)
                                        .font(.custom(Fonts.tiltWarp.rawValue, size: 32))
                                        .foregroundStyle(.white)
                                }
                            }.frame(height: 75)
                                .padding()
                            Spacer()
                        }
                        
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image(.backBtn)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: DeviceInfo.shared.deviceType == .pad ? 75 : 50)
                            }
                            Spacer()
                        }.padding()
                    }
                    Spacer()
                }
                
            }
            .background(
                Image(.background)
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                    .scaledToFill()
            )
            .onChange(of: achivement1) { newValue in
                if newValue {
                    achievements.achievementOneDone()
                }
                
            }
            
        }
    }
}

#Preview {
    GameView(achievements: AchievementsViewModel())
}
