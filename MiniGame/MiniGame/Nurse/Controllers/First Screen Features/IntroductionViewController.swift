import UIKit

class IntroductionViewController: UIViewController {
    
    @IBOutlet weak var imgViewer: UIImageView!
    var number = 1
    @IBOutlet weak var pageController: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func swipeAction(_ sender: Any) {
        number += 1
        if number == 9 {
            imgViewer.isHidden = true
            pageController.isHidden = true
            navigationController?.popToRootViewController(animated: true)
        } else {
            imgViewer.image = UIImage(named: "Step\(number)")
            pageController.currentPage = number - 1
        }
    }
}
