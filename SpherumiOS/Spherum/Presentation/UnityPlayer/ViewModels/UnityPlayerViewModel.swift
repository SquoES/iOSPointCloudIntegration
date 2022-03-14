import RxSwift
import RxCocoa
import RxMVVM

class UnityPlayerViewModel: ViewModel {
    
    private let videoGroup: BunnyCDNVideoGroup
    
    private let downloadProgress = Progress(totalUnitCount: 0)
    private var downloadProgressObservation: NSKeyValueObservation?
    private var loadVideoTask: Task<Void, Error>?
    
    let progressString = BehaviorRelay<String>(value: "0 %")
    let downloading = BehaviorRelay<Bool>(value: true)
    
    let close = PublishSubject<Void>()
    let startVideo = BehaviorSubject<String?>(value: nil)
    
    init(videoGroup: BunnyCDNVideoGroup) {
        self.videoGroup = videoGroup
    }
    
    deinit {
        downloadProgressObservation?.invalidate()
    }
    
    override func subscribe() {
        
        close.bind { [weak self] in
            self?.closeAction()
        }
        .disposed(by: disposeBag)
        
        downloadProgressObservation = downloadProgress.observe(\.completedUnitCount) { [weak self] progress, _ in
            DispatchQueue.main.async {
                let progressString = String(format: "%.0f %%", (progress.fractionCompleted * 100))
                #if DEBUG
                print("progressString:", progressString)
                #endif
                self?.progressString.accept(progressString)
            }
        }
        
        loadFilesAction()
        
        super.subscribe()
    }
    
    private func loadFilesAction() {
        loadVideoTask = Task { [weak self] in
            guard let self = self else {
                return
            }
            
            try await BunnyProvider.instance.downloadAllFiles(forVideoGroup: self.videoGroup,
                                                              progress: self.downloadProgress)
            self.downloading.accept(false)
            
            if let lastComponent = self.videoGroup.mainFolder.ObjectName.split(separator: "/").last {
                let folderName = String(lastComponent)
                print("FOLDER NAME:", folderName)
                let folderPath = BunnyProvider.instance.getLocalFolderURL(for: self.videoGroup.mainFolder)
                print("FOLDER PATH:", folderPath)
                DispatchQueue.main.async {
                    self.startVideo.onNext(folderName)
                }
            }
        }
    }
    
    private func closeAction() {
        // DISABLE UNITY
        loadVideoTask?.cancel()
        Task {
            await BunnyProvider.instance.cancelAllTasks()
        }
        Navigator.dismiss()
    }
    
}
