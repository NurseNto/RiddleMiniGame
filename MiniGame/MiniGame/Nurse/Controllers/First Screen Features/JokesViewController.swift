import UIKit

class JokesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var jokesTable: UITableView!
    
    var jokesArray: Jokes?
    private var jokeNib = String(describing: JokeTableViewCell.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jokesTable.dataSource = self
        jokesTable.delegate = self
        
        jokesTable.layer.cornerRadius = jokesTable.layer.bounds.size.width / 30
        jokesTable.layer.cornerRadius = jokesTable.layer.bounds.size.height / 20
        jokesTable.clipsToBounds = true
        
        NetworkHelper.shared.getJokes() {response in
            self.jokesArray = response
            DispatchQueue.main.async {
                self.jokesTable.reloadData()
            }
        }
        
        jokesTable.register(UINib(nibName: jokeNib, bundle: .main), forCellReuseIdentifier: jokeNib)
    }
    
    
    @IBAction func doneTapped(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return jokesArray?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: jokeNib, for: indexPath) as! JokeTableViewCell
        cell.jokeLabel.text = jokesArray?[indexPath.section].joke
        cell.jokeLabel.font = .italicSystemFont(ofSize: 20)
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
        return 130
    }
}
