import UIKit

class JokeTableViewCell: UITableViewCell {

    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var jokeContainer: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        jokeContainer.layer.cornerRadius = jokeContainer.layer.bounds.size.width / 10
        jokeContainer.clipsToBounds = true
        
        jokeContainer.layer.cornerRadius = 0
    }
}
