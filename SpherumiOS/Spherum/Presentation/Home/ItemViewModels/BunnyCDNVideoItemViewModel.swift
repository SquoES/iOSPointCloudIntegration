import RxSwift
import RxCocoa
import RxMVVM
import UIKit

class BunnyCDNVideoItemViewModel: ViewModel {
    
    let bunnyCDNVideoGroup: BunnyCDNVideoGroup
    
    lazy var previewImage = Observable.just(createPreview())
    lazy var title = Observable.just(createTitle())
    
    init(bunnyCDNVideoGroup: BunnyCDNVideoGroup) {
        self.bunnyCDNVideoGroup = bunnyCDNVideoGroup
    }
    
    private func createPreview() -> UIImage? {
        guard let previewFile = bunnyCDNVideoGroup.getPreviewFile() else {
            return nil
        }
        guard let fileURL = BunnyProvider.instance.getLocalFileURL(for: previewFile) else {
            return nil
        }
        return UIImage(contentsOfFile: fileURL.path)
    }
    
    private func createTitle() -> String? {
        BunnyProvider.instance.getInfo(forVideoGroup: bunnyCDNVideoGroup)?.title
    }
    
}
