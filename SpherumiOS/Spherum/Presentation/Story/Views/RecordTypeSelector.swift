import UIKit
import RxSwift
import RxCocoa
import RxMVVM
import RxDataSources

class RecordTypeSelector: XibView, UICollectionViewDelegateFlowLayout {
    
    private let allViewModels = BehaviorRelay(value: RecordTypeItemViewModel.allItems)
    lazy var itemsSections = allViewModels.map { [SectionModel(model: "", items: $0)] }
    
    let itemsDataSource: RxCollectionViewSectionedReloadDataSource<SectionModel<String, RecordTypeItemViewModel>> = CollectionViewConnector.reloadDataSource(RecordTypeItemCollectionViewCell.self)
    
    let disposeBag = DisposeBag()
    
    let selectedType = BehaviorRelay<RecordType>(value: .lidar)
    
    let startRecord = PublishSubject<Void>()
    
    var itemSize: CGSize {
        let itemEdgeLength = recordTypesCollectionView?.frame.height ?? 100
        return CGSize(width: itemEdgeLength, height: itemEdgeLength)
    }

    @IBOutlet weak var recordTypesCollectionView: UICollectionView!
    @IBOutlet weak var selectedRecordTypeNameLabel: UILabel!
    
    override func loadUI() {
        
        CollectionViewConnector.register(RecordTypeItemCollectionViewCell.self,
                                         for: recordTypesCollectionView)
        recordTypesCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        itemsSections.bind(to: recordTypesCollectionView.rx.items(dataSource: itemsDataSource)).disposed(by: disposeBag)
        
        recordTypesCollectionView.rx.itemSelected.bind(onNext: { [weak self] in
            self?.handleSelect(indexPath: $0)
        }).disposed(by: disposeBag)
        
        recordTypesCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .centeredHorizontally, animated: false)
        
        for direction in [UISwipeGestureRecognizer.Direction.left, .right] {
            let recognizer = UISwipeGestureRecognizer(target: self,
                                                      action: #selector(handleSwipe(_:)))
            recognizer.direction = direction
            addGestureRecognizer(recognizer)
        }
        
        selectedType.map { $0.name }.bind(to: selectedRecordTypeNameLabel.rx.text).disposed(by: disposeBag)
    }
    
    private func handleSelect(indexPath: IndexPath) {
        let currentIndex = RecordType.allCases.firstIndex(of: selectedType.value) ?? 0
        
        if currentIndex == indexPath.row {
            startRecord.onNext(())
            print("start record")
        } else {
            recordTypesCollectionView.scrollToItem(at: indexPath,
                                                   at: .centeredHorizontally,
                                                   animated: true)
            selectedType.accept(RecordType.allCases[indexPath.row])
        }
    }
    
    // MARK: - Handle Swipe
    @objc func handleSwipe(_ recognizer: UISwipeGestureRecognizer) {
        var change = 0
        
        switch recognizer.direction {
        case .left:
            change = 1
            print("left")
            
        case .right:
            print("right")
            change = -1
            
        default:
            return
        }
        
        let nextIndex = (RecordType.allCases.firstIndex(of: selectedType.value) ?? 0) + change
        
        if nextIndex < 3 && nextIndex >= 0 {
            let nextType = RecordType.allCases[nextIndex]
            selectedType.accept(nextType)
            recordTypesCollectionView.scrollToItem(at: IndexPath(row: nextIndex, section: 0),
                                                   at: .centeredHorizontally,
                                                   animated: true)
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let itemWidth = itemSize.width
        let collectionViewWidth = UIScreen.main.bounds.width
        let inset = (collectionViewWidth - itemWidth) / 2
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0.0
    }
    
}
