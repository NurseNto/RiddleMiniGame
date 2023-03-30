import UIKit

class RiddleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var riddleArray: Riddles?
    var riddleShuffledArray: Riddles?
    var questions: Riddles?
    var noCorrect = 0
    var questionIndex = 0
    var currentQuestionPosition = 0
    var sound = SoundHelper()
    var points = 0
    
    @IBOutlet weak var questionContainerView: UIView!
    @IBOutlet weak var answerTable: UITableView!
    @IBOutlet weak var questionLabel: UILabel!

    private var answerNib = String(describing: AnswerTableViewCell.self)

    override func viewDidLoad() {
        super.viewDidLoad()
        questionContainerView.layer.cornerRadius = questionContainerView.layer.bounds.size.width / 20
        questionContainerView.layer.cornerRadius = questionContainerView.layer.bounds.size.height / 10
        questionContainerView.clipsToBounds = true
        answerTable.layer.cornerRadius = answerTable.layer.bounds.width / 35
        answerTable.layer.cornerRadius = answerTable.layer.bounds.height / 25
        answerTable.clipsToBounds = true
        answerTable.backgroundColor = .clear
        
        answerTable.dataSource = self
        answerTable.delegate = self
        questions = riddleArray
        startServiceCall()

        answerTable.register(UINib(nibName: answerNib, bundle: .main), forCellReuseIdentifier: answerNib)
    }

    @IBAction func quitButtonTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func restartButtonTapped(_ sender: Any) {
        show(RiddleViewController(), sender: self)
    }

    func startServiceCall() {
        NetworkHelper.shared.getRiddles() { response in
            _ = true
            self.riddleArray = response
            self.riddleShuffledArray = response?.shuffled()

            DispatchQueue.main.async {
                self.getCurrentQuestion(pos: self.questionIndex)
                self.answerTable.reloadData()
                self.scrollToTop()
            }
        }
    }
    
    func scrollToTop(){
        answerTable.layoutIfNeeded()
        answerTable.contentOffset = CGPoint(x: 0, y: -answerTable.contentInset.top)
    }

    func getCurrentQuestion(pos: Int) {
        questionLabel.text = riddleArray?[pos].question
    }

    func loadNextQuestion() {
        if currentQuestionPosition + 1 < riddleArray?.count ?? 0 {
            currentQuestionPosition += 1
            startServiceCall()
        } else {
            let resultScreen = ResultViewController()
            resultScreen.result = noCorrect
            show(resultScreen, sender: self)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return riddleArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: answerNib, for: indexPath) as? AnswerTableViewCell else { return UITableViewCell() }
        let item = riddleShuffledArray?[indexPath.section]
        cell.answerLabel.text = item?.answer
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let selectedAnswer = riddleShuffledArray?[indexPath.section].answer
        let correctAnswer = riddleArray?.first?.answer

        if selectedAnswer == correctAnswer {
            sound.soundPlay()
            noCorrect += 1
            let alert = UIAlertController(title: "Done", message: "Correct", preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "dismiss", style: .cancel, handler: { _ in self.loadNextQuestion() }) )
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Wrong", message: "", preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: "dismiss", style: .destructive, handler: { _ in self.loadNextQuestion() }) )
            present(alert, animated: true)
        }
    }
}
