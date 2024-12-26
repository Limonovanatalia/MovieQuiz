import UIKit

final class MovieQuizViewController: UIViewController {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var counterLabel: UILabel!
    @IBOutlet private var yesButton: UIButton!
    @IBOutlet private var noButton: UIButton!
    
    // MARK: - Lifecycle
    struct QuizQuestion {
        // строка с названием фильма,
        // совпадает с названием картинки афиши фильма в Assets
        let image: String
        // строка с вопросом о рейтинге фильма
        let text: String
        // булевое значение (true, false), правильный ответ на вопрос
        let correctAnswer: Bool
    }
    //вью модель для состояния "Вопрос показан"
    struct QuizStepViewModel {
        let image: UIImage
        let question: String
        let questionNumber: String
    }
    // для состояния "Результат квиза"
    struct QuizResultsViewModel {
      // строка с заголовком алерта
      let title: String
      // строка с текстом о количестве набранных очков
      let text: String
      // текст для кнопки алерта
      let buttonText: String
    }
    
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    
    // MARK: массив вопросов
    private let questions: [QuizQuestion] = [
        QuizQuestion(
            image: "The Godfather",
            text: "Рейтинг этого фильма больше, чем 6?", correctAnswer: true),
        QuizQuestion(
            image: "The Dark Knight",
            text: "Рейтинг этого фильма больше, чем 6?", correctAnswer: true),
        QuizQuestion(
            image: "Kill Bill",
            text: "Рейтинг этого фильма больше, чем 6?", correctAnswer: true),
        QuizQuestion(
            image: "The Avengers",
            text: "Рейтинг этого фильма больше, чем 6?", correctAnswer: true),
        QuizQuestion(
            image: "Deadpool",
            text: "Рейтинг этого фильма больше, чем 6?",
            correctAnswer: true),
        QuizQuestion(
            image: "The Green Knight",
            text: "Рейтинг этого фильма больше, чем 6?", correctAnswer: true),
        QuizQuestion(
            image: "Old",
            text: "Рейтинг этого фильма больше, чем 6?", correctAnswer: false),
        QuizQuestion(
            image: "The Ice Age Adventures of Buck Wild",
            text: "Рейтинг этого фильма больше, чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Tesla",
            text: "Рейтинг этого фильма больше, чем 6?",
            correctAnswer: false),
        QuizQuestion(
            image: "Vivarium",
            text: "Рейтинг этого фильма, больше, чем 6?",
            correctAnswer: false)
    ]
    // MARK: методы
    override func viewDidLoad() {
        let currentQuestion = questions[currentQuestionIndex]
        let model = convert(model: currentQuestion)
        self.show(quiz: model)
        textLabel.textColor = .ypWhite
        
    }
    //метод конвертации, который принимает моковый вопрос и возврщает вью модель для главного экрана
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questions.count)")
        return questionStep
    }
    // приватный метод вывода на экран вопроса, который принимает на вход вью модель вопроса и ничего не возвращает
    private func show(quiz step: QuizStepViewModel) {
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questions.count - 1 {
            let text = "Ваш результат: \(correctAnswers)/10"
            let viewModel = QuizResultsViewModel(
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз")
            show(quiz: viewModel)
            
        } else {
            currentQuestionIndex += 1
           
            let nextQuestion = questions[currentQuestionIndex]
                    let viewModel = convert(model: nextQuestion)
                    
                    show(quiz: viewModel)
        }
    }
    private func disableButtons() {
        yesButton.isEnabled = false
        noButton.isEnabled = false
    }

    private func enableButtons() {
        yesButton.isEnabled = true
        noButton.isEnabled = true
    }

        // приватный метод, который меняет цвет рамки
        // принимает на вход булевое значение и ничего не возвращает
        private func showAnswerResult(isCorrect: Bool) {
            if isCorrect {
                correctAnswers += 1
            }
            imageView.layer.masksToBounds = true
            imageView.layer.borderWidth = 8
            imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)
            { self.showNextQuestionOrResults()
                self.imageView.layer.borderColor = UIColor.clear.cgColor
                self.enableButtons()
            }
        }
    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in
            self.currentQuestionIndex = 0
            self.correctAnswers = 0
            
            let firstQuestion = self.questions[self.currentQuestionIndex]
                let firstQuestionModel = self.convert(model: firstQuestion)
                self.show(quiz: firstQuestionModel)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
        // метод вызывается, когда пользователь нажимает на кнопку "Да"
        @IBAction private func yesButtonClicked(_sender: UIButton) {
            disableButtons()
            let currentQuestion = questions[currentQuestionIndex]
            let givenAnswer = true
            
            showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        }
        // метод вызывается, когда пользователь нажимает на кнопку "Нет"
        @IBAction private func noButtonClicked(_sender: UIButton) {
            disableButtons()
            let currentQuestion = questions[currentQuestionIndex]
            let givenAnswer = false
            
            showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        }
}
