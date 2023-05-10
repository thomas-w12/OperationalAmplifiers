//


import Foundation

class AppState: ObservableObject {
    enum AppStatePage: String, CaseIterable, Identifiable {
        
        var id: Self {
            return self
        }
        
        case start = "Start"
        case first = "Introduction"
        case second = "Inverting Amplifier"
        case third = "Non-Inverting Amplifier"
        case quiz = "Quiz"
        case end = "End"
        
    }
    
    @Published var currentPage: AppStatePage = .start
    @Published var previousPage: AppStatePage?
    @Published var showSideBar: Bool = false
    @Published var showQuizHelp: Bool = false

    
    init(currentPage: AppStatePage = AppStatePage.start) {
        self.currentPage = currentPage
    }
}


class DragDropQuizStatus: ObservableObject {
    
    enum AmplifierQuizStatus: String, CaseIterable {
        case inverting = "Inverting Amplifier"
        case nonInverting = "Non-Inverting Amplifier"
    }
    
    @Published var dragDropQuizStatus: AmplifierQuizStatus = .inverting
    @Published var userScore: Int = 0
    @Published var currentQuestion: Int = 0
        
    let maxAskedQuestions = 10
    
    var userScorePercent: Double {
        Double(userScore) / Double(maxAskedQuestions*10)
    }
    
    func toggle() {
        if dragDropQuizStatus == .inverting {
            dragDropQuizStatus = .nonInverting
        } else {
            dragDropQuizStatus = .inverting
        }
    }
    
    init(dragDropQuizStatus: AmplifierQuizStatus = .inverting, userScore: Int = 0) {
        self.dragDropQuizStatus = dragDropQuizStatus
        self.userScore = userScore
    }
}
