import UIKit
import WebKit

class TextDocumentViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    private var url: URL!
    private var documentTitle: String!
    
    func setup(documentTitle: String, url: URL) {
        self.documentTitle = documentTitle
        self.url = url
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = documentTitle

        if let url = url {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
