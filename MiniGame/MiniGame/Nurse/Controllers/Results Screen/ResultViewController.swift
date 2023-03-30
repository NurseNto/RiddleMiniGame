import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var lblScore: UILabel!

    @IBOutlet weak var imageScoreView: UIImageView!
    var result = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        lblScore.text = "\(result)/20"
        if result < 10 {
            imageScoreView.image = UIImage(named: "game-lose")
            view.backgroundColor = .black
        } else {
            imageScoreView.image = UIImage(named: "win-")
        }
    }
    
    @IBAction func backHomeTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func replayTapped(_ sender: Any) {
        show(RiddleViewController(), sender: self)
    }
}
