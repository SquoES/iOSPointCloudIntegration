import RxSwift
import RxCocoa
import RxMVVM

class ARRecordingViewModel: ViewModel {
    
    private var prepareVideoDisposeBag: DisposeBag!
    
    let virtualObjectLoader = VirtualObjectLoader()
    
    let cancelUpload = PublishSubject<Void>()
    
    override func subscribe() {
        
        cancelUpload.bind(onNext: { [weak self] in
            self?.cancelUploadAction()
        }).disposed(by: disposeBag)
        
        super.subscribe()
    }
    
    func postVideo(url: URL) {
        prepareVideoDisposeBag = DisposeBag()
        
        PrepareAndUploadVideoPackage.default.use(input: .init(videoPackage: .video2D(url)))
            .do(onSubscribed: { [weak self] in
                self?.isLoading.onNext(true)
            }, onDispose: { [weak self] in
                self?.isLoading.onNext(false)
            }).subscribe(onSuccess: {
                Navigator.dismiss()
            }, onError: { [weak self] error in
                self?.handleError(error)
            }).disposed(by: prepareVideoDisposeBag)
    }
    
    private func cancelUploadAction() {
        prepareVideoDisposeBag = nil
    }
    
}
