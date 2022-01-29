import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    var photos: [Photo] = []
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photosCollectionView.frame = CGRect(x: Const.photosCollectionViewFrame,
                                            y: Const.photosCollectionViewFrame * 2,
                                            width: view.frame.width - Const.photosCollectionViewFrame * 2,
                                            height: view.frame.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photos = PhotoProvider().photos()
        
        photosCollectionView.delegate = self
        photosCollectionView.dataSource = self
        
        photosCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Const.cellReuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: Const.cellReuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        
        photoCell.configure(with: photos[indexPath.row])
        
        return photoCell
    }
}

extension CollectionViewController {
    private enum Const {
        static let photosCollectionViewFrame: CGFloat = 8
        static let cellReuseIdentifier = "cell"
    }
}
