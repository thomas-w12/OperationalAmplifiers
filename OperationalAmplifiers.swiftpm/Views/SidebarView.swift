//


import Foundation
import SwiftUI

struct HideableLeftSideBarView<Content>: View where Content: View {

    @Binding var showSideBar: Bool
    @Binding var showSideBarButton: Bool
    
    let width: CGFloat
    let buttonImage: AnyView
    
    var body: some View {
        HStack(spacing: 0) {
            
            content()
                .frame(width: width)
                .background(Color.background.shadow(radius: 5))
            
            if showSideBarButton {
                VStack {
                    Button {
                        showSideBar.toggle()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(.background)
                                .shadow(radius: 10)
                            buttonImage                        }
                        .frame(width: 50, height: 50)
                        .padding()
                        
                        
                    }
                    .padding()
                    //  .animation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.3), value: showSideBar)
                    Spacer()
                }
            }
            Spacer()
        }
        .offset(x: showSideBar ? 0 : -width)
        .animation(.easeInOut(duration: 0.2), value: showSideBar)
    }
    
    @ViewBuilder
    let content: () -> Content
    
    init(showSideBar: Binding<Bool>, showSideBarButton: Binding<Bool>, width: CGFloat, buttonImage: AnyView, @ViewBuilder content: @escaping () -> Content) {
        self._showSideBar = showSideBar
        self._showSideBarButton = showSideBarButton
        self.width = width
        self.buttonImage = buttonImage
        self.content = content
    }
}

struct HideableRightSideBarView<Content>: View where Content: View {
    
    @Binding var showSideBar: Bool
    @Binding var showSideBarButton: Bool
    
    let width: CGFloat
    let buttonImage: AnyView
    
    var body: some View {
        HStack(spacing: 0) {
            
            Spacer()
            
            
            if showSideBarButton {
                VStack {
                    Button {
                        showSideBar.toggle()
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .foregroundColor(.background)
                                .shadow(radius: 10)
                            buttonImage                        }
                        .frame(width: 50, height: 50)
                        .padding()
                        
                        
                    }
                    .padding()
                    //.animation(.spring(response: 0.8, dampingFraction: 0.5, blendDuration: 0.3), value: showSideBar)
                    Spacer()
                }
            }
            content()
                .frame(width: width)
                .background(Color.background.shadow(radius: 5))
        }
        .offset(x: showSideBar ? 0 : width)
        .animation(.easeInOut(duration: 0.2), value: showSideBar)
    }
    
    @ViewBuilder
    let content: () -> Content
    
    init(showSideBar: Binding<Bool>, showSideBarButton: Binding<Bool>, width: CGFloat, buttonImage: AnyView, @ViewBuilder content: @escaping () -> Content) {
        self._showSideBar = showSideBar
        self._showSideBarButton = showSideBarButton
        self.width = width
        self.buttonImage = buttonImage
        self.content = content
    }
}

struct SideBarView: View {
    
    @ObservedObject var appState: AppState

    let icon8URL = URL(string: "https://icons8.com")
    
    var body: some View {
        VStack {
            Text("Contents")
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
                    ForEach(AppState.AppStatePage.allCases) { page in
                        if page != .end {
                            SidebarContentButton(directToPage: page, appState: appState)
                                .padding()
                        }
                    }
                }
                
            }
            Spacer()
            
            HStack {
                Text("Icons from")
                Link("Icons8", destination: icon8URL!)
            }
            .font(AppHelperClass.smallTextFont)
            .padding()
            
        }
    }
}


struct SidebarContentButton: View {
    
    let directToPage: AppState.AppStatePage
    
    @ObservedObject var appState: AppState
    
    var body: some View {
        Button {
            
            withAnimation {
                appState.previousPage = appState.currentPage
                appState.currentPage  = directToPage
                
            }
            
        } label: {
            HStack {
                ZStack {
                    if directToPage == appState.currentPage {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle(lineWidth: 2))
                    }
                    Text(directToPage.rawValue)
                        .font(AppHelperClass.textFont)
                        .padding(.vertical)
                    
                    
                    
                }
                .frame(maxWidth: 250)
            }
            
        }
    }
}
