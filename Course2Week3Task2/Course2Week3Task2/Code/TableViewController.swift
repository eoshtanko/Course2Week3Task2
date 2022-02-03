import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var photoTableView: UITableView!
    
    var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photos = PhotoProvider().photos()
        
        photoTableView.register(UITableViewCell.self, forCellReuseIdentifier: Const.cellReuseIdentifier)
        
        photoTableView.delegate = self
        photoTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoTableView.frame = view.frame
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let photoCell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath)
        
        photoCell.textLabel?.text = photos[indexPath.row].name
        photoCell.imageView?.image = photos[indexPath.row].image
        
        return photoCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Const.photoCellHight;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row selected")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("Accessory selected")
    }
}

extension TableViewController {
    private enum Const {
        static let cellReuseIdentifier = "cell"
        static let photoCellHight: CGFloat = 60
    }
}
