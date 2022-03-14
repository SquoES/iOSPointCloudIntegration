protocol VideoContentProviderSessionDelegate: AnyObject {
    
    func videoContentProviderSession(_ videoContentProviderSession: VideoContentProviderSession,
                                     didOutput sample: VideoContentProviderSessionOutputSample)
    
}
