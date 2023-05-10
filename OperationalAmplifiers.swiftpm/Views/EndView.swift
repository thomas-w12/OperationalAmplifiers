//


import SwiftUI
import IrregularGradient

struct EndView: View {
    
    @ObservedObject var dragDropQuizStatus: DragDropQuizStatus
    @ObservedObject var appState: AppState
    
    @State private var buttonSize = CGSize(width: 1, height: 1)
    
    let emojis = ["🥳","🤩", "😄", "🙂", "😐", "🙁"]
    
    var index: Int {
        let doubleIndex = (1.0-dragDropQuizStatus.userScorePercent) * Double(emojis.count-1)
        return Int(round(doubleIndex))
    }
    
    var body: some View {
        
        GeometryReader { geo in
            VStack {
                
                Text("Thank you!")
                    .font(.custom("Orbitron-Bold", size: 40))
                    .padding(10)
                
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 2)
                    .foregroundColor(.accentColor)
                    .padding(.top, 5)
                
                
                BackgroundRectangleView {
                    GeometryReader { geoProxy in
                        
                        VStack {
                            Spacer()
                            Text(emojis[index])
                                .font(.system(size: 80))
                                .padding(geo.size.height*0.05)
                            
                            Text("Final score:")
                                .font(AppHelperClass.extraBoldedTextFont)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Text("\(dragDropQuizStatus.userScore) / \(dragDropQuizStatus.maxAskedQuestions*10)")
                                .font(AppHelperClass.extraMegaBoldedTextFont)
                                .foregroundColor(.accentColor)
                                .padding(geo.size.height*0.05)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            Button {
                                withAnimation {
                                    appState.previousPage = appState.currentPage
                                    appState.currentPage = .quiz
                                    dragDropQuizStatus.currentQuestion = 0
                                    dragDropQuizStatus.userScore = 0
                                }
                                
                            } label: {
                                Text("Restart Quiz")
                                    .font(.custom("Quicksand-Bold", size: 32))
                                    .irregularGradient(colors: [ .white], background: Color.accentColor, animate: true, speed: 1)
                                    .padding(.bottom)
                                    .scaleEffect(buttonSize)
                                    .onAppear{
                                        buttonSize = CGSize(width: 1.1, height: 1.1)
                                    }
                                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: buttonSize)
                            }
                            
                            Spacer()
                        }
                    }
                }
                
            }
        }
    }
    
}

struct EndView_Previews: PreviewProvider {
    static var previews: some View {
        EndView(dragDropQuizStatus: DragDropQuizStatus(dragDropQuizStatus: .inverting, userScore: 20), appState: AppState())
    }
}
