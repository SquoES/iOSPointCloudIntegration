//
//  DepthVideoSamplesReader.h
//  Spherum3DScanner
//
//  Created by Artem Eremeev on 08.07.2021.
//

#ifndef DepthVideoSamplesReader_h
#define DepthVideoSamplesReader_h

#import <AVFoundation/AVDepthData.h>
#import <CoreVideo/CoreVideo.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DepthVideoSamplesReader <NSObject>

- (CVPixelBufferRef)extractNextPixelBuffer;
- (AVDepthData*)extractNextDepthData;

@end

NS_ASSUME_NONNULL_END

#endif /* DepthVideoSamplesReader_h */
