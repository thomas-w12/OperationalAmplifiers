//


import SwiftUI

struct ContentView: View {
    
    @StateObject var appState = AppState()
    @StateObject var dragDropQuizStatus = DragDropQuizStatus()
    @State var showSideBarButton: Bool = false
    
    
    
    var body: some View {
        GeometryReader { geo in
            
            ZStack {
                
                switch appState.currentPage {
                case .start:
                    StartView(appState: appState)
                        .preferredColorScheme(.light)
                        .transition(.scrollSlide)
                        .onTapGesture {
                            appState.showSideBar = false
                        }
                case .first:
                    FirstView(appState: appState)
                        .preferredColorScheme(.light)
                        .transition(.scrollSlide)
                        .onTapGesture {
                            appState.showSideBar = false
                        }
                case .second:
                    SecondView(appState: appState)
                        .preferredColorScheme(.light)
                        .transition(.scrollSlide)
                        .onTapGesture {
                            appState.showSideBar = false
                        }
                case .third:
                    ThirdView(appState: appState)
                        .preferredColorScheme(.light)
                        .transition(.scrollSlide)
                        .onTapGesture {
                            appState.showSideBar = false
                        }
                case .quiz:
                    QuizView(dragDropQuizStatus: dragDropQuizStatus, appState: appState)
                        .preferredColorScheme(.light)
                        .transition(.scrollSlide)
                        .onTapGesture {
                            appState.showSideBar = false
                        }
                case .end:
                    EndView(dragDropQuizStatus: dragDropQuizStatus, appState: appState)
                        .preferredColorScheme(.light)
                        .transition(.scrollSlide)
                        .onTapGesture {
                            appState.showSideBar = false
                        }
                }
                
                Color.black
                    .ignoresSafeArea()
                    .opacity(appState.showSideBar ? 0.2 : 0)
                    .animation(.easeInOut, value: appState.showSideBar)
                
                
                HideableLeftSideBarView(showSideBar: $appState.showSideBar, showSideBarButton: $showSideBarButton, width: geo.size.width*0.25, buttonImage: AnyView(Image(systemName: "list.dash").font(.largeTitle))) {
                    SideBarView(appState: appState)
                }
                .ignoresSafeArea()
                
                
                
            }
            .onChange(of: appState.currentPage) { newValue in
                withAnimation {
                    if newValue == .start {
                        self.showSideBarButton = false
                    } else {
                        self.showSideBarButton = true
                    }
                }
                appState.showSideBar = false
            }
            .onChange(of: appState.showQuizHelp) { newValue in
                if newValue {
                    appState.showSideBar = false
                }
            }
            .onChange(of: appState.showSideBar) { newValue in
                if newValue {
                    appState.showQuizHelp = false
                }
            }
            
        }
    }
    
    
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appState: AppState(currentPage: .second))
    }
}
