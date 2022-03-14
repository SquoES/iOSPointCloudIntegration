import RxSwift
import RxCocoa
import RxMVVM

class RecordTypeItemViewModel: ViewModel {
    
    let recordType: RecordType
    
    let selected: BehaviorRelay<Bool>
    
    init(recordType: RecordType, selected: Bool) {
        self.recordType = recordType
        self.selected = BehaviorRelay(value: selected)
    }
    
    static var allItems: [RecordTypeItemViewModel] {
        RecordType.allCases.enumerated().map { RecordTypeItemViewModel(recordType: $1, selected: $0 == 0) }
    }
    
}

enum RecordType: CaseIterable {
    case createModel
    case lidar
    case faceID
    
    private var imageName: String {
        switch self {
        case .createModel:
            return "create-model-record-type"
            
        case .lidar:
            return "lidar-record-type"
            
        case .faceID:
            return "faceid-record-type"
        }
    }
    
    var name: String {
        switch self {
        case .createModel:
            return "CREATE MODEL"
            
        case .lidar:
            return "LIDAR"
            
        case .faceID:
            return "FACEID"
        }
    }
    
    var image: UIImage? {
        UIImage(named: imageName)
    }
    
    static var allCases: [RecordType] {
        [.lidar, .faceID]
    }
}
