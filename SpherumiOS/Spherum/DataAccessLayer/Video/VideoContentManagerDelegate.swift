protocol VideoContentManagerDelegate: AnyObject {
    
    func videoContentManager(_ videoContentManager: VideoContentManager,
                             didDidChange videoContentType: VideoContentType)
    
    func videoContentManager(_ videoContentManager: VideoContentManager,
                             didOutput sample: VideoContentProviderSessionOutputSample)
    
    func videoContentManager(_ videoContentManager: VideoContentManager,
                             didFinishWrite output: VideoContentRecorderOutput)
    
}
