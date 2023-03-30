import AVFoundation
import UIKit

class FirstScreenViewController: UIViewController {
    @IBOutlet var popView: UIView!
    @IBOutlet weak var jokesButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet weak var musicButton: UIButton!

    var player: AVAudioPlayer?
    var soundPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.layer.cornerRadius = playButton.layer.bounds.size.width / 10
        playButton.clipsToBounds = true
       jokesButton.layer.cornerRadius = jokesButton.layer.bounds.size.width / 10
        jokesButton.clipsToBounds = true
        popView.layer.cornerRadius = popView.layer.bounds.size.width / 10
        popView.clipsToBounds = true
        blurView.bounds = self.view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    @IBAction func infoTapped(_ sender: Any) {
        show(IntroductionViewController(), sender: self)
    }

    @IBAction func playButtonTapped(_ sender: Any) {
       show(RiddleViewController(), sender: self)
    }

    @IBAction func jokesTapped(_ sender: Any) {
        show(JokesViewController(), sender: self)
    }

    // Settings features
    @IBAction func settingsTapped(_ sender: Any) {
        animateSettingView(desired: blurView)
        animateSettingView(desired: popView)
    }
    
    @IBAction func doneAction(_ sender: Any) {
        animateSettingViewOut(desired: popView)
        animateSettingViewOut(desired: blurView)
    }
    
    @IBAction func soundTapped(_ sender: Any) {
    }
    @IBAction func didTapMusic(_ sender: Any) {
        if let player = player, player.isPlaying {
            // stop playback
            player.stop()
            musicButton.tintColor = .white
        } else {
            // set up player and play
            let urlString = Bundle.main.path(forResource: "memories", ofType: "mp3")
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else {
                    return
                }
                
                player.play()
                if #available(iOS 15.0, *) {
                    musicButton.tintColor = .tintColor
                } else {
                    // Fallback on earlier versions
                }

            } catch {
                print("Something went wrong")
            }
        }
    }
    
    
    // view animation functions
    func animateSettingView(desired: UIView) {
        let back = self.view!
        
        back.addSubview(desired)
        
        desired.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desired.alpha = 0
        desired.center = back.center
        
        UIView.animate(withDuration: 0.3, animations: {
            desired.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desired.alpha = 1
        })
    }
    
    func animateSettingViewOut(desired: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            desired.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desired.alpha = 0
        }, completion: {_ in
            desired.removeFromSuperview()
        })
    }
    
}
