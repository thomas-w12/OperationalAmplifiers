//


import SwiftUI
import LaTeXSwiftUI
import ConfettiSwiftUI

struct QuizView: View {
    
    @ObservedObject var dragDropQuizStatus: DragDropQuizStatus
    @ObservedObject var appState: AppState
    
    @State private var animateWrongDrop: Bool = false
    @State private var showBottomVStack = false
    
        
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                
                VStack {
                    ZStack {
                        Text("Quiz")
                            .font(.custom("Orbitron-Bold", size: 40))
                            .padding(10)
                        HStack {
                            
                            
                            Spacer()
                            Text("\(dragDropQuizStatus.currentQuestion) / \(dragDropQuizStatus.maxAskedQuestions)")
                                .font(AppHelperClass.boldedTextFont)
                                .foregroundColor(.accentColor)
                                .padding(.horizontal, geo.size.width*0.02)
                                .offset(x: -geo.size.width*0.07)
                            
                        }
                        
                    }
                    
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 2)
                        .foregroundColor(.accentColor)
                        .padding(.top, 5)
                    
                    HStack {
                        GeometryReader { geoProxy in
                            
                            VStack {
                                BackgroundRectangleView {
                                    GeometryReader { geo in
                                        
                                        DragDropQuizView(dragDropQuizStatus: dragDropQuizStatus, animateWrongDrop: $animateWrongDrop)
                                            .confettiCannon(counter: $dragDropQuizStatus.currentQuestion, num: 40, confettiSize: 15, rainHeight: 400, openingAngle: Angle(degrees: 30), closingAngle: Angle(degrees: 150))
                                        
                                    }
                                }
                                .offset(x: animateWrongDrop ? -30 : 0)
                            }
                            
                        }
                        .frame(maxWidth: appState.showQuizHelp ? geo.size.width*0.75 : .infinity)
                        .animation(.spring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.3), value: appState.showQuizHelp)
                        
                        Spacer()
                        
                        
                        
                    }
                    .opacity(showBottomVStack ? 1 : 0)
                }
                .onTapGesture {
                    appState.showQuizHelp = false
                    appState.showSideBar = false
                }
                
                Color.black
                    .ignoresSafeArea()
                    .opacity(appState.showQuizHelp ? 0.2 : 0)
                    .animation(.easeInOut, value: appState.showQuizHelp)
                
                
                HideableRightSideBarView(showSideBar: $appState.showQuizHelp, showSideBarButton: .constant(true), width: geo.size.width*0.25, buttonImage: AnyView(Image(systemName: "questionmark").font(.largeTitle))) {
                    VStack {
                        Text("Help center")
                            .font(AppHelperClass.extraBoldedTextFont)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .padding(.top, 30)
                        
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 2)
                            .foregroundColor(.accentColor)
                            .padding(.horizontal, 10)
                        
                        
                        
                        
                        ScrollView(.vertical, showsIndicators: true) {
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Group {
                                    Text("Remember the formula of the amplifications for the ").font(AppHelperClass.textFont) + Text("\(dragDropQuizStatus.dragDropQuizStatus.rawValue):").font(AppHelperClass.boldedTextFont)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical)
                                
                                switch dragDropQuizStatus.dragDropQuizStatus {
                                case .inverting:
                                    LaTeX("$\\LARGE A = - \\frac{R_{f}}{R_{in}}$")
                                        .frame(maxWidth: .infinity ,alignment: .center)
                                case .nonInverting:
                                    LaTeX("$\\LARGE A = 1+\\frac{R_{f}}{R_{1}}$")
                                        .frame(maxWidth: .infinity ,alignment: .center)
                                    
                                }
                                Text("Drag and drop the correct resistor from the top bar onto the missing resistor in the circuit!")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(AppHelperClass.textFont)
                                    .padding(.vertical)
                                
                            }
                            .padding(.horizontal, geo.size.width*0.0125)
                            
                        }
                    }
                }
                .ignoresSafeArea()
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    withAnimation(.easeInOut(duration: 1)) {
                        showBottomVStack = true
                        
                    }
                }
                
            }
            .onChange(of: dragDropQuizStatus.currentQuestion) { newValue in
                
                if dragDropQuizStatus.currentQuestion == dragDropQuizStatus.maxAskedQuestions {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        
                        withAnimation {
                            appState.previousPage = appState.currentPage
                            appState.currentPage = .end
                            
                        }
                    }
                } else {
                    withAnimation(.easeInOut.delay(0.5)) {
                        dragDropQuizStatus.toggle()
                    }
                }
            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView(dragDropQuizStatus: DragDropQuizStatus(), appState: AppState())
    }
}
